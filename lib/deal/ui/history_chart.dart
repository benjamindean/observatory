import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:collection/collection.dart';
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
    final AsyncValue<List<History>?> historyState = ref.watch(
      historyProvider(id),
    );

    return historyState.when(
      data: (history) {
        if (history == null || history.isEmpty) {
          return const HistoryEmptyMessage();
        }

        final double regularPrice = history
            .map((item) => item.deal?.regular.amount ?? 0)
            .sorted((a, b) => b.compareTo(a))
            .first
            .ceil()
            .toDouble();

        final double lowestPrice = history
            .map((item) => item.deal?.price.amount ?? 0)
            .sorted((a, b) => a.compareTo(b))
            .first
            .ceil()
            .toDouble();

        final Map<int, History> sortedHistory = {
          for (final h in history)
            DateTime.parse(h.timestamp ?? '').millisecondsSinceEpoch: h
        };

        final List<FlSpot> spots =
            sortedHistory.entries.sorted((a, b) => a.key.compareTo(b.key)).map(
          (entry) {
            return FlSpot(
              entry.key.toDouble(),
              entry.value.deal?.price.amount ?? regularPrice,
            );
          },
        ).toList();

        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) =>
                        context.colors.scheme.tertiary,
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots
                          .map(
                            (LineBarSpot touchedSpot) => LineTooltipItem(
                              '${NumberFormat.simpleCurrency(
                                name: currency,
                              ).format(touchedSpot.y)}\n${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt()))}',
                              TextStyle(
                                color: context.colors.scheme.onTertiary,
                              ),
                            ),
                          )
                          .toList();
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
                  bottomTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      interval: 15,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(0),
                          style: TextStyle(
                            color: context.colors.scheme.secondary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                  border: Border.all(
                    color: context.colors.scheme.secondary,
                    width: 1.5,
                  ),
                ),
                minY: lowestPrice - 0.1,
                maxY: regularPrice + 0.1,
                lineBarsData: [
                  LineChartBarData(
                    preventCurveOverShooting: true,
                    spots: spots,
                    barWidth: 1,
                    color: context.colors.scheme.secondary,
                    isStrokeJoinRound: true,
                    dotData: const FlDotData(
                      show: true,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: context.colors.scheme.secondary.withOpacity(0.3),
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
