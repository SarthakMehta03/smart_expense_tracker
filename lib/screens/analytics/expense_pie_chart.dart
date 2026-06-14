import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensePieChart extends StatelessWidget {
  final double food;
  final double travel;
  final double shopping;
  final double bills;
  final double others;

  const ExpensePieChart({
    super.key,
    required this.food,
    required this.travel,
    required this.shopping,
    required this.bills,
    required this.others,
  });

  @override
  Widget build(BuildContext context) {
    double total = food + travel + shopping + bills + others;

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 50,
              sections: [
                PieChartSectionData(
                  color: Colors.orange,
                  value: food,
                  title: total == 0
                      ? '0%'
                      : '${((food / total) * 100).toStringAsFixed(1)}%',
                  radius: 90,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                PieChartSectionData(
                  color: Colors.blue,
                  value: travel,
                  title: total == 0
                      ? '0%'
                      : '${((travel / total) * 100).toStringAsFixed(1)}%',
                  radius: 90,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                PieChartSectionData(
                  color: Colors.green,
                  value: shopping,
                  title: total == 0
                      ? '0%'
                      : '${((shopping / total) * 100).toStringAsFixed(1)}%',
                  radius: 90,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                PieChartSectionData(
                  color: Colors.red,
                  value: bills,
                  title: total == 0
                      ? '0%'
                      : '${((bills / total) * 100).toStringAsFixed(1)}%',
                  radius: 90,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                PieChartSectionData(
                  color: Colors.purple,
                  value: others,
                  title: total == 0
                      ? '0%'
                      : '${((others / total) * 100).toStringAsFixed(1)}%',
                  radius: 90,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 20,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            buildLegend(Colors.orange, "Food"),
            buildLegend(Colors.blue, "Travel"),
            buildLegend(Colors.green, "Shopping"),
            buildLegend(Colors.red, "Bills"),
            buildLegend(Colors.purple, "Others"),
          ],
        ),
      ],
    );
  }

  Widget buildLegend(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}