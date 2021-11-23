
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetrailsPage extends StatefulWidget {

  const DetrailsPage({Key key, this.data}) : super(key: key);
  final QueryDocumentSnapshot data;
  
  @override
  _DetrailsPageState createState() => _DetrailsPageState();
}

class _DetrailsPageState extends State<DetrailsPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                child: Text(widget.data.get('item'), style: TextStyle(color: Colors.blue, fontSize: 22),),
              ),
              Text(widget.data.get('transactionId'),
              ),
              Text(widget.data.get('supplier'),
              ),
              Text(widget.data.get('origin'),
              ),
              Text(widget.data.get('quantity').toString(),
              ),
              Text(widget.data.get('slaughteringDate'),
              ),
              Text(widget.data.get('ocLocation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
