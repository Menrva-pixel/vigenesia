import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia/Screens/Login.dart';
import 'package:vigenesia/Constant/const.dart';
import 'package:dio/dio.dart';
import 'package:drop_shadow/drop_shadow.dart';
//importtidakdigunakan//
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:vigenesia/components/login_background.dart';



class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  String baseurl = url;

  Future postRegister(
      String nama, String profesi, String email, String password) async {
    var dio = Dio();
    dynamic data = {
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password,
    };
    try {
      final Response = await dio.post("$baseurl/vigenesia/api/registrasi/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));
      print("Respon -> ${Response.data}+ ${Response.statusCode}");
      if (Response.statusCode == 200) {
        return Response.data;
      }
    } catch (e) {
      print("Failed to Load $e");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 1.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                  child: Text(
                    "halo!",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.deepOrange),
                  )),
                  Text(
                    "Buat Akun",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  SizedBox(height: 25),
                  FormBuilderTextField(
                      style: TextStyle(color: Colors.grey),
                    name: "name",
                    controller: nameController,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.people_outline_outlined,
                          color: Colors.deepOrange),
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
                        labelText: "Nama",
                    labelStyle: TextStyle(color: Colors.grey),
                  )),

                  SizedBox(height: 25 ),
                  FormBuilderTextField(
                      style: TextStyle(color: Colors.grey),
                    name: "profession",
                    controller: professionController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.work_outlined,
                            color: Colors.deepOrange),
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
                        labelText: "Profesi",
                      labelStyle: TextStyle(color: Colors.grey),
                    )),
                  SizedBox(height: 25),
                  FormBuilderTextField(
                      style: TextStyle(color: Colors.grey),
                    name: "email",
                    controller: emailController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.mail_outlined,
                            color: Colors.deepOrange),
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
                        labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey),
                    )
                  ),
                  SizedBox(height: 25),
                  FormBuilderTextField(
                    style: TextStyle(color: Colors.grey),
                    name: "password",
                    controller: passwordController,
                      obscureText: true,
                      obscuringCharacter: "*",
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.lock,
                            color: Colors.deepOrange),
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
                        labelText: "Password",
                      labelStyle: TextStyle(color: Colors.grey),
                    )
                  ),
                  SizedBox(height: 60),
                  Container(
                    padding: EdgeInsets.only(bottom: 100),
                    width: 90,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1.0,color: Colors.orange,),
                        backgroundColor: Colors.grey.shade900,
                        foregroundColor: Colors.orange.shade900,
                        shadowColor: Colors.black,
                        elevation: 10,
                        primary: Colors.black,
                        onSurface: Colors.red,
                      ),
                      onPressed: () async {
                        await postRegister(
                                nameController.text,
                                professionController.text,
                                emailController.text,
                                passwordController.text)
                            .then((value) => {
                                  if (value != null)
                                    {
                                      setState(() {
                                        Navigator.pop(context);
                                        Flushbar(
                                          message: "Berhasil Registrasi",
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.greenAccent,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                        ).show(context);
                                      })
                                    }
                                  else if (value == null)
                                    {
                                      Flushbar(
                                        message:
                                            "Check Your Field Before Register",
                                        duration: Duration(seconds: 5),
                                        backgroundColor: Colors.redAccent,
                                        flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context)
                                    }
                                });
                      },
                      child: Text("Daftar"),

                    ),
                  ),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Sudah Memiliki Akun ?',
                        style: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.w800,
                        )),
                      TextSpan(
                          text: ' Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      new Login()));
                            },
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.deepOrange)),
                    ]),
                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}