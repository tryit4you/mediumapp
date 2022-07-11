import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medium_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function removeTransaction;
  TransactionList({this.transactionList, this.removeTransaction});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: transactionList.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            )
          : ListView.builder(
              itemCount: transactionList.length,
              itemBuilder: (ctx, idx) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transactionList[idx].amount}')),
                      ),
                    ),
                    title: Text(transactionList[idx].title,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400)),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy')
                          .format(transactionList[idx].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                        onPressed: () =>
                            removeTransaction(transactionList[idx].id),
                        icon: Icon(Icons.remove_circle,
                            color: Theme.of(context).errorColor)),
                  ),
                );
              }),
    );
  }
}
