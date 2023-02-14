import 'dart:convert';
// ignore: unused_import
import 'dart:core';
// ignore: unused_import
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:vigenesia/Screens/Login.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia/Models/Motivasi_Model.dart';
import 'package:dio/dio.dart';
import 'package:vigenesia/Constant/const.dart';
import 'package:vigenesia/components/main_background.dart';
import 'package:flutter_glow/flutter_glow.dart';
// ignore: unused_import
import 'package:vigenesia/Screens/EditPage.dart';



class MainScreens extends StatefulWidget {
  final String iduser;
  final String nama;
  const MainScreens({Key? key, required this.iduser, required this.nama})
      : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  String baseurl = url;
  String? id;
  var dio = Dio();
  List<MotivasiModel> ass = [];
  TextEditingController titleController = TextEditingController();

  Future<dynamic> sendMotivasi(String isi) async {
    Map<String, dynamic> body = {
      "isi_motivasi": isi,
      "iduser": widget.iduser,
    };
    try {
      Response response = await dio.post(
          "$baseurl/vigenesia/api/dev/POSTmotivasi",
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print("Respon -> ${response.data} + ${response.statusCode}");

      return response;
    } catch (e) {
      print("Error di -> $e");
    }
  }

  List<MotivasiModel> listproduk = [];

  Future<List<MotivasiModel>> getData() async {
    var response = await dio
        .get('$baseurl/vigenesia/api/Get_motivasi?iduser=${widget.iduser}');
    print("${response.data}");
    if (response.statusCode == 200) {
      var getUsersData = response.data as List;
      var listUsers =
          getUsersData.map((i) => MotivasiModel.fromJson(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed To Load');
    }
  }

  Future<dynamic> deletePost(String id) async {
    dynamic data = {
      "id": id,
    };
    var response = await dio.delete('$baseurl/vigenesia/api/dev/DELETEmotivasi',
        data: data,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"Content-type": "application/json"}));

    print("${response.data}");
    var resbody = jsonDecode(response.data);
    return resbody;
  }

  Future<List<MotivasiModel>> getData2() async {
    var response = await dio.get('$baseurl/vigenesia/api/Get_motivasi');
    print("${response.data}");
    if (response.statusCode == 200) {
      var getUsersData = response.data as List;
      var listUsers =
          getUsersData.map((i) => MotivasiModel.fromJson(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed To Load');
    }
  }

  Future<void> _getData() async => setState(() {
        getData();
        listproduk.clear();

      });

  TextEditingController isiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData2();
    _getData();
  }

  String? trigger;
  String? triggeruser;

  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: const Color(0xFF252525),
        accentColor: const Color(0xFF607d8b),
        canvasColor: const Color(0xFFfafafa),
        fontFamily: 'Roboto');
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.black26,
          actions: <Widget>[
      Padding(
      padding: EdgeInsets.only(right: 20.0),
    ),
    ]
      ),
      backgroundColor: Colors.grey.shade900,
      resizeToAvoidBottomInset : false,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(children: <Widget>[
                    Row(
              //ROW 1
                        children: [
                           Container(
                              margin: EdgeInsets.only(top: 5.0),
                              padding: EdgeInsets.only(left: 0),
                              child:  Text(
                  " Selamat datang",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.grey.shade500, fontFamily: 'Raleway'),
                        ),
                      ),
                                ],
                      ),
                   Row(//ROW 2
                     children: [
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        padding: EdgeInsets.only(left: 5.0),
                        child:  Text(
                          "VIGENESIA",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.grey.shade200, fontFamily: 'Raleway'),
                        ),
                  ),
                       Container(
                         width: 40,
                       ),
                       Container(
                         alignment: Alignment.topRight,
                         margin: EdgeInsets.only(bottom: 20.0),
                         padding: EdgeInsets.only(left: 50.0),
                         child: Text(
                            "Hi, ${widget.nama}",
                           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.deepOrange, fontFamily: 'Raleway'),
                         ),
                       ),
                       Container(
                         width: 5,
                       ),
                       Container(
                         alignment: Alignment.topRight,
                         margin: EdgeInsets.only(bottom: 20.0),
                         padding: EdgeInsets.only(left: 35),
                           child: GestureDetector(
                             onTap: () {Navigator.pop(context);
                             Navigator.push(
                                 context,
                                 new MaterialPageRoute(
                                   builder: (BuildContext context) => new Login(),
                                 ));},
                             child: Icon(
                               Icons.logout,
                               size: 26.0,
                               color: Colors.grey,
                             ),
                           )
                       ),
              ],
                  ),

                  Row(//ROW 3
                  children: [
                    Container(
                      width: 340,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5.0),
                      child:  Expanded(
                        child: Text(
                        "Visi Generasi Indonesia adalah aplikasi mobile buatan karya anak bangsa dan tempat dimana para mahasiswa saling memberikan motivasi"
                            "satu sama lain.", maxLines: 4, textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey.shade500, fontFamily: 'Raleway'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                    )
                  ],
                ),
                    SizedBox(
                      child: FormBuilderTextField(
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                        controller: isiController,
                        name: "isi_motivasi",
                        decoration: InputDecoration(
                            hintText: 'Berikan Motivasi',
                          hintStyle: TextStyle(color: Colors.grey.shade900),
                          contentPadding:
                          new EdgeInsets.all(10),
                          suffixIcon: const Icon(Icons.edit,
                              color: Colors.white),
                          filled: true,
                          fillColor: Colors.grey.shade700,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade50),
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade100, width: 2.0),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                   ),
                Column(//ROW 3
                  children: [
                        FormBuilderRadioGroup(
                            activeColor: Colors.deepOrange,
                onChanged: (value) {
                  setState(() {
                    trigger = value as String;
                    print("HASILNYA --> ${trigger}");
                  });
                },
                name: "_",
                options: ["Motivasi By All User", "Motivasi By User"]
                    .map((e) =>
                        FormBuilderFieldOption(value: e, child: Text("${e}", style: TextStyle(color: Colors.white),)))
                    .toList()),
                    trigger == "Motivasi By All User"
                ? FutureBuilder(
                    future: getData2(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MotivasiModel>> snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                            child: Column(
                                children: [
                            for (var item in snapshot.data!)
                            Container(
                            width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  controller: _scrollController,
                                    shrinkWrap: true,
                                    children: [
                                    Container(child: Card(
                                        elevation: 5,
                                      color: Colors.grey.shade800,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                       ListTile(
                                            leading: Icon(Icons.people_alt,
                                              color: Colors.grey.shade400,
                                              size: 40.0,),
                                            title: Text('anonymous',style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w700)),
                                            subtitle: Text(item.isiMotivasi, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.grey.shade200, fontFamily: 'Raleway'),
                                            ),
                                      ),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                             )
                            ],
                          ),
                      )
                      ])
                        );
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return Text("No Data");
                      } else {
                        return CircularProgressIndicator();
                      }
                    })
                : Container(),
                    trigger == "Motivasi By User"
                ? FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MotivasiModel>> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            for (var item in snapshot.data!)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: [
                                    Container(child: Card(
                                      elevation: 5,
                                      color: Colors.grey.shade500,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                           ListTile(
                                            leading: Icon(Icons.edit_note_rounded,
                                              color: Colors.black,
                                              size: 32.0,),
                                            title: Text('${widget.nama}',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.deepOrange, fontFamily: 'Raleway'),),
                                            subtitle: Text(item.isiMotivasi,
                                              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              TextButton(
                                                child: const Icon(Icons.edit_outlined,
                                                  color: Colors.black,
                                                  size: 24.0,),
                                                onPressed: () {String id;
                                                // ignore: unused_local_variable
                                                String isi_motivasi;
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          EditPage(
                                                              id: item.id,
                                                              isi_motivasi: item
                                                                  .isiMotivasi),
                                                    ));},
                                              ),
                                              const SizedBox(width: 8),
                                              TextButton(
                                                child: const Icon(Icons.delete,
                                                color: Colors.black,
                                                size: 24.0,),
                                                onPressed: () {deletePost(item.id)
                                                    .then((value) => {
                                                  if (value != null)
                                                    {
                                                      Flushbar(
                                                        message:
                                                        "Berhasil Delete",
                                                        duration:
                                                        Duration(
                                                            seconds:
                                                            2),
                                                        backgroundColor:
                                                        Colors
                                                            .redAccent,
                                                        flushbarPosition:
                                                        FlushbarPosition
                                                            .TOP,
                                                      ).show(context)
                                                    }
                                                });
                                                getData();
                                                },
                                              ),
                                            ])
                                        ],
                                      )
                                )
                                    ),
                                      ],
                                    ),
                                    )
                                  ],
                                );
                              } else if (snapshot.hasError) {
                          return Text("${snapshot.hasError}");
                        } else {
                        return Text("No Data");
                      }
                    })
                : Container(),
              ]
            ),
           ]
        ),
       ]
      ),
    ),

        )
      ),

        bottomNavigationBar: Row(
          children: [
            Material(
            color: const Color(0xffff710a),
                child: InkWell(
                onTap: () {
                  _getData();
                },
                    child: const SizedBox(
                    height: kToolbarHeight,
                    width: 100,
                        child: Center(
                            child: Icon(Icons.refresh,
                              color: Colors.black,
                              size: 28.0,),

                 ),
               ),
                ),
             ),
            Expanded(
                  child: Material(
                  color: const Color(0xff747474),
                      child: InkWell(
                      onTap: () async {
                      if (isiController.text.toString().isEmpty) {
                          Flushbar(
                            message: "Tidak Boleh Kosong",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.redAccent,
                            flushbarPosition: FlushbarPosition.TOP,
                            ).show(context);
                          } else if (isiController.text.toString().isNotEmpty) {
                            await sendMotivasi(
                          isiController.text.toString(),
                          ).then((value) => {
                          if (value != null)
                            {
                          Flushbar(
                          message: "Berhasil Submit",
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.greenAccent,
                          flushbarPosition: FlushbarPosition.TOP,
                          ).show(context)
                            }
                      });
                      }

    print("Sukses");
    },

                          child: const SizedBox(
                          height: kToolbarHeight,
                          width: double.infinity,
                              child: Center(
                              child: Text(
                              'submit',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black, fontFamily: 'Raleway'),

            ),
              ),
          ),
        ),
        ),
        ),
        ],
       ),
    );

  }
}