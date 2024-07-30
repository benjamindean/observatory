import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observatory/deal/providers/history_provider.dart';
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
    final AsyncValue<List<History>?> historyState = ref.watch(
      historyProvider(id),
    );

    return historyState.when(
      data: (history) {
        if (history == null || history.isEmpty) {
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

        final List<FlSpot> spots = history
            .asMap()
            .entries
            .map(
              (entry) => FlSpot(
                entry.key.toDouble(),
                entry.value.deal?.price.amount ?? regularPrice,
              ),
            )
            .toList();

        return Padding(
          padding: const EdgeInsets.all(16.0),
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
                              touchedSpot.y.toString(),
                              TextStyle(
                                color: context.colors.scheme.onTertiary,
                              ),
                            ),
                          )
                          .toList();
                    },
                  ),
                ),
                titlesData: const FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: context.colors.scheme.secondary,
                    width: 0.5,
                  ),
                ),
                minY: lowestPrice - 1,
                maxY: regularPrice + 1,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    barWidth: 3,
                    color: context.colors.scheme.secondary,
                    dotData: const FlDotData(
                      show: false,
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
      },
    );
  }
}
