import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;
  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _tittleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitted() {
    if (_amountController.text.isEmpty) return;

    final enterdTittle = _tittleController.text;
    final enterdAmount = double.parse(_amountController.text);

    if (enterdTittle.isEmpty || enterdAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.newTx(
      _tittleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((picked) {
      if (picked == null) return;

      setState(() {
        _selectedDate = picked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Tittle'),
                controller: _tittleController,
                onSubmitted: (_) => _submitted(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitted(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: _selectedDate == null
                          ? Text('No Date Chosen!')
                          : Text(
                              'Picked Date :   ${DateFormat.yMMMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _pickDate,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add Transaction',
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
