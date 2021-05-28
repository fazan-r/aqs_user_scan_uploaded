import 'package:aqs_final_project/reusable_widget/alert.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showingAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure want to log out?',
      cancelActiontext: 'Cancel',
      defaultActionText: 'Logout',
    );
    
    if (didRequestSignOut == true){
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Colors.amber,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.blue[900], Colors.orangeAccent],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          )),
        ),
        title: Text('AQS Dashboard'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
