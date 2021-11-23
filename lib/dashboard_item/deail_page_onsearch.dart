
import 'package:aqs_final_project/dashboard_item/outgoing_checkinh_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPagesTwo extends StatefulWidget {

  const DetailPagesTwo({Key key, this.data}) : super(key: key);
  final QueryDocumentSnapshot data;

  @override
  _DetailPagesTwoState createState() => _DetailPagesTwoState();
}

class _DetailPagesTwoState extends State<DetailPagesTwo> {


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
              Container(),

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
              Row(
                children: <Widget>[
                  TextButton(
                      child: Text('Add processing checking'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutgoingCheckingForm()));
                    },
                  ),
                  TextButton(
                      child: Text('Add outgoing checking'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutgoingCheckingForm()));
                    },
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
