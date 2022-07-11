import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;

  NewTransaction(this.newTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;
  void _onSubmitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text ?? 0);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate == null)
      return;
    widget.newTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2099))
        .then((datePicked) {
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: this._titleController,
            keyboardType: TextInputType.text,
            onSubmitted: (_) => _onSubmitData(),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _onSubmitData(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedDate == null
                    ? 'No date choosen!'
                    : 'Picked Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                TextButton(
                  onPressed: () => _presentDatePicker(),
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: _onSubmitData,
            child: Text(
              'Add Transaction',
            ),
            textColor: Theme.of(context).textTheme.button.color,
            color: Theme.of(context).primaryColor,
          ),
        ]),
      ),
    );
  }
}
