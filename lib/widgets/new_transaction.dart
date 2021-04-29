import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function adTx;

  NewTransaction(this.adTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.adTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDataPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickerDate) {
      if (pickerDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickerDate;
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
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'title'),
                controller: _titleController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}')),
                    TextButton(
                      child: Text('Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: _presentDataPicker,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    textStyle: Theme.of(context).textTheme.button,
                  ),
                  child: Text(
                    'Add Transaction',
                  ),
                  onPressed: _submitData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
