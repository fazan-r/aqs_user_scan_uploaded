
import 'package:aqs_final_project/dashboard_item/deail_page_onsearch.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class LagiCoba extends StatefulWidget {

  const LagiCoba({Key key, this.qrcoderesult}) : super(key: key);
  final qrcoderesult;

  @override
  _LagiCobaState createState() => _LagiCobaState();
}

class _LagiCobaState extends State<LagiCoba> {


  final textController = TextEditingController();
  String qrcoderesult = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future scan() async {
    try {
      String qrcoderesult = await BarcodeScanner.scan();
      setState(() => this.qrcoderesult = qrcoderesult);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.qrcoderesult = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qrcoderesult = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.qrcoderesult =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.qrcoderesult = 'Unknown error: $e');
    }
  }
  Future uploadCurrentUser()async{
    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    final uname = user.displayName;
    final _posisi = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    CollectionReference userDataUpload = FirebaseFirestore.instance.collection('transcationRecap').doc(qrcoderesult).collection('scanned');
    return userDataUpload.add({
      'uid' : uid,
      'name' : uname,
      'email' : uemail,
      'location' : GeoPoint(_posisi.latitude, _posisi.longitude),
      'time' : Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan here'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "RESULT",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 80,
              height: 30,
              // ignore: deprecated_member_use
              child: RaisedButton(
                child: Text('SCAN'),
                onPressed: () {
                  setState(() {
                    scan();
                    textController.text = qrcoderesult;
                  });
                },
              ),
            ),
            Container(
                height: 150,
                child: StreamBuilder<QuerySnapshot>(
                  stream: qrcoderesult != '' && qrcoderesult != null
                      ? FirebaseFirestore.instance
                      .collection('transcationRecap')
                      .where("transactionId", isEqualTo: qrcoderesult)
                      .snapshots()
                      : FirebaseFirestore.instance
                      .collection("transcationRecap")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                      } else {
                          if (snapshot.data.docs.isEmpty) {
                            return Center(
                              child: Text('No data found'),
                            );
                      } else {
                        return ListView(
                          children: [
                            ...snapshot.data.docs.map((QueryDocumentSnapshot data) {

                              final String productId = data.get('transactionId');
                              final String item = data.get('item');

                              return ListTile(
                                onTap: () {
                                  uploadCurrentUser();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPagesTwo(data: data) ));
                                },
                                title: Text(productId),
                                subtitle: Text(item),
                              );
                            })
                          ],
                        );
                      }
                    }
                  },
                )),
            // ignore: deprecated_member_use
          ],
        ),
      ),
    );
  }
}
