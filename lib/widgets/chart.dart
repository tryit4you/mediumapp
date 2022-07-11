import 'package:flutter/material.dart';
import 'package:medium_app/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      double totalSum = 0.0;
      var weekDay = DateTime.now().subtract(Duration(days: index));
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  Chart(this.recentTransactions);

  double get totalSpending {
    return groupedTransactionValue.fold(0.0, (result, tx) {
      return result + (tx['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ...groupedTransactionValue.map((data) {
            double pendingPctOfTotal = 0.0;
            if (totalSpending != 0)
              pendingPctOfTotal = ((data['amount'] as double) / totalSpending);

            return Flexible(
                fit: FlexFit.tight,
                child:
                    ChartBar(data['day'], data['amount'], pendingPctOfTotal));
          }).toList()
        ]),
      ),
    );
  }
}
