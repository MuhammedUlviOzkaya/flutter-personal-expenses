import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange
    ];
    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: FittedBox(
              child: Text(
                '₺${widget.transaction.amount}',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          //style: Theme.of(context).textTheme.titleMedium,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).errorColor),
                icon: Icon(Icons.delete),
                label: Text('Delete'))
            : IconButton(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: Icon(Icons.delete),
                color:
                    //Theme.of(context).secondaryHeaderColor,
                    Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
