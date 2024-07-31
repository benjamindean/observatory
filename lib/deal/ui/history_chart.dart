import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:observatory/deal/providers/history_provider.dart';
import 'package:observatory/settings/providers/itad_config_provider.dart';
import 'package:observatory/shared/models/history.dart';
import 'package:observatory/shared/ui/observatory_shimmer.dart';

class HistoryChart extends ConsumerWidget {
  final String id;

  const HistoryChart({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currency = ref.watch(
      itadConfigProvider.select(
        (value) => value.valueOrNull?.currency ?? 'USD',
      ),
    );
    final AsyncValue<List<MapEntry<int, History>>> historyState = ref.watch(
      historyProvider(id),
    );

    return historyState.when(
      data: (history) {
        if (history.isEmpty) {
          return const HistoryEmptyMessage();
        }

        final List<FlSpot> spots = history
            .map(
              (entry) => FlSpot(
                entry.key.toDouble(),
                entry.value.deal?.price.amount.toDouble() ?? 0,
              ),
            )
            .toList();

        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipColor: (_) => context.colors.scheme.tertiary,
                    tooltipRoundedRadius: 12.0,
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map(
                        (LineBarSpot touchedSpot) {
                          return LineTooltipItem(
                            NumberFormat.simpleCurrency(
                              name: currency,
                            ).format(touchedSpot.y),
                            context.textStyles.labelMedium.copyWith(
                              color: context.colors.scheme.onTertiary,
                            ),
                            children: [
                              const TextSpan(text: '\n'),
                              TextSpan(
                                text: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                                    .format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    touchedSpot.x.toInt(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList();
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 60 * 60 * 24 * 30 * 1000,
                      getTitlesWidget: (value, meta) {
                        if (meta.min == value || meta.max == value) {
                          return const SizedBox.shrink();
                        }

                        return Text(
                          DateFormat(DateFormat.ABBR_MONTH).format(
                            DateTime.fromMillisecondsSinceEpoch(
                              value.toInt(),
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                          style: context.textStyles.labelSmall.copyWith(
                            color: context.colors.scheme.secondary,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      interval: 10,
                      getTitlesWidget: (value, meta) {
                        if (meta.min == value || meta.max == value) {
                          return Text(
                            value.toInt().toString(),
                            overflow: TextOverflow.ellipsis,
                            style: context.textStyles.labelSmall.copyWith(
                              color: context.colors.scheme.secondary,
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    preventCurveOverShooting: true,
                    isStepLineChart: true,
                    barWidth: 1,
                    color: context.colors.scheme.secondary,
                    dotData: const FlDotData(
                      show: true,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: context.colors.scheme.secondary.withOpacity(0.3),
                    ),
                    lineChartStepData: const LineChartStepData(
                      stepDirection: LineChartStepData.stepDirectionForward,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () {
        return const ObservatoryShimmer();
      },
      error: (error, stackTrace) {
        return const HistoryEmptyMessage();
      },
    );
  }
}

class HistoryEmptyMessage extends StatelessWidget {
  const HistoryEmptyMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(
          'No historical price data available.',
          style: TextStyle(
            color: context.colors.disabled,
          ),
        ),
      ),
    );
  }
}
