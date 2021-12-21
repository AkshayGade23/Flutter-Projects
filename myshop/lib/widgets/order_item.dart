import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _isExpanded
          ? min(widget.order.products.length * 178.0 + 130, 292)
          : 92,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '\$ ${widget.order.amount}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                DateFormat('dd/mm/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: _isExpanded
                    ? Icon(Icons.expand_less)
                    : Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _isExpanded
                  ? min(widget.order.products.length * 178.0 + 130, 200)
                  : 0,
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => ListTile(
                        title: Text(
                          prod.title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '\$ ${prod.price}',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Text(
                          ' x ${prod.quantity}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
