import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:vigenesia/Constant/const.dart';
import 'package:vigenesia/Models/Motivasi_Model.dart';

class EditPage extends StatefulWidget {
  final String id;
  final String isi_motivasi;
  const EditPage({Key? key, required this.id, required this.isi_motivasi}) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}
class _EditPageState extends State<EditPage> {
  String baseurl=url;

  var dio=Dio();

  Future<dynamic>putPost(String isi_motivasi, String ids) async {

    Map<String,
        dynamic>data= {
      "isi_motivasi": isi_motivasi, "id": ids
    }

    ;
    var response=await dio.put('$baseurl/vigenesia/api/dev/PUTmotivasi',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType,
        ));
    print("---> ${response.data} + ${response.statusCode}");
    return response.data;
  }

  TextEditingController isiMotivasiC=TextEditingController();

  @override Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: Text("Edit"),
        backgroundColor: Colors.black26,
    ),
      body: SafeArea(child: Container(child: Container(width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5,
          color: Colors.grey.shade800,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            ListTile(
                leading: Icon(Icons.edit_note_rounded,
            color: Colors.black,
            size: 32.0,),
                title: Text('${widget.isi_motivasi}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.deepOrange, fontFamily: 'Raleway'),),
          ),
            Container(width: MediaQuery.of(context).size.width / 1.4,
              padding: EdgeInsets.all(50),
              child: FormBuilderTextField(name: "isi_motivasi",
                  style: TextStyle(color: Colors.grey),
                controller: isiMotivasiC,
                decoration: InputDecoration(suffixIcon: const Icon(Icons.edit_outlined,
                    color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  filled: true,
                  fillColor: Colors.black54,
                  contentPadding: EdgeInsets.only(left: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
              ),
            ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 1.0,color: Colors.orange,),
                  backgroundColor: Colors.grey.shade900,
                  foregroundColor: Colors.orange,
                  shadowColor: Colors.black,
                  elevation: 10,
                  primary: Colors.black,
                  onSurface: Colors.red,
                ),
                onPressed: () {
              putPost(isiMotivasiC.text, widget.id).then((value)=> {
                if (value !=null) {
                  Navigator.pop(context),
                  Flushbar(message: "Berhasil Update & Refresh dlu",
                    duration: Duration(seconds: 5),
                    backgroundColor: Colors.green,
                    flushbarPosition: FlushbarPosition.TOP,
                  ).show(context)
                }
              }

              );
            },
                child: Text("Submit"))
          ],
        ),
        ),
      ),
      )),
    );
  }
}