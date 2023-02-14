import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia/Screens/MainScreens.dart';
import 'package:vigenesia/Screens/Register.dart';
import 'package:vigenesia/Constant/const.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:vigenesia/Models/Login_Model.dart';
import 'dart:convert';
import 'package:vigenesia/components/login_background.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String nama;
  late String iduser;

  // ignore: unused_field
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
        resizeToAvoidBottomInset : false,
      body: Login_Background(
        child: Login_Background(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                      "assets/images/vigenesia.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Form(
                        child: Container(
                             width: 250,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                style: TextStyle(color: Colors.grey),
                                name: "Email",
                                controller: emailController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black45,
                                    suffixIcon: const Icon(Icons.email,
                                    color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade100, width: 3.0),
                                        borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: EdgeInsets.only(left: 15),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade50),
                                        borderRadius: BorderRadius.circular(10.0)),
                                    labelText: "Email",
                                labelStyle: TextStyle(color: Colors.grey.shade50)),
                              ),
                              SizedBox(height: 20),
                              FormBuilderTextField(
                                style: TextStyle(color: Colors.grey),
                                name: "Password",
                                controller: passwordController,
                                obscureText: true,
                                obscuringCharacter: "*",
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black45,
                                    suffixIcon: const Icon(Icons.lock,
                                        color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade100, width: 3.0),
                                        borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding: EdgeInsets.only(left: 15),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade50),
                                        borderRadius: BorderRadius.circular(10.0)),
                                    labelText: "Password",
                                    labelStyle: TextStyle(color: Colors.grey.shade50)),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: 'belum memiliki akun ?',
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800),
                                  ),
                                  TextSpan(
                                      text: ' daftar',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      new Register()));
                                        },
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.deepOrange)),
                                ]),
                              ),
                              SizedBox(height: 40),
                              Container(
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
                                  await (String email, String password) async {
                                    var dio = Dio();
                                    String baseurl = url;
                                    Map<String, dynamic> data = {
                                      "email": email,
                                      "password": password
                                    };
                                    try {
                                      final Response = await dio.post(
                                          "$baseurl/vigenesia/api/login/",
                                          data: data,
                                          options: Options(headers: {
                                            'Content-type': 'application/json'
                                          }));
                                      print(
                                          "Respon -> ${Response.data} + ${Response.statusCode}");
                                      if (Response.statusCode == 200) {
                                        final loginModel =
                                            LoginModels.fromJson(Response.data);
                                        return loginModel;
                                      }
                                    } catch (e) {
                                      print("Failed To Load $e");
                                    }
                                  }(emailController.text,
                                          passwordController.text)
                                      .then((value) => {
                                            if (value != null)
                                              {
                                                setState(() {
                                                  nama = value.data.nama;
                                                  iduser = value.data.iduser;
                                                  print(
                                                      "ini Data id ---->${iduser}");
                                                  Navigator.pushReplacement(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              new MainScreens(
                                                                  iduser:
                                                                      iduser,
                                                                  nama: nama)));
                                                })
                                              }
                                            else if (value == null)
                                              {
                                                Flushbar(
                                                  message:
                                                      "Check Your email / password",
                                                  duration:
                                                      Duration(seconds: 5),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                ).show(context)
                                              }
                                          });
                                },
                                child: Text("Log In",
                                  style: TextStyle(
                                    color: Colors.grey.shade200,
                                  ),
                                )
                                ),
                          )
                        ],
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
