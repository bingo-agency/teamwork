import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/auth/users.dart';

import '../../models/database.dart';
import 'login.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map;
    String message;
    var dbclass = context.read<DataBase>();

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Register",
          style: GoogleFonts.ubuntu(),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  height: 350,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Register & Find over 54,000 properties",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 30.0,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ), //BoxDecoration
                          ), //Container
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        // Text(
                        //     'Register and get access to 54,000 database records'),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Image(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/images/banner6.png'),
                              ) //BoxDecoration
                              ), //Container
                        )
                      ])),
              Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Register',
                    style: GoogleFonts.ubuntu(
                        fontSize: 25.0,
                        color: Theme.of(context).secondaryHeaderColor),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hoverColor: Colors.purple,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                        ),
                      ),
                      labelText: 'Complete Name',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  onChanged: (value) =>
                      EmailValidator.validate(value.toString())
                          ? null
                          : "Please enter a valid email.",
                  validator: (value) =>
                      EmailValidator.validate(value.toString())
                          ? null
                          : "Please enter a valid email.",
                  controller: emailController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      labelText: 'Email',
                      labelStyle: GoogleFonts.ubuntu(color: Colors.purple)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                    labelText: 'Password',
                    labelStyle: GoogleFonts.ubuntu(color: Colors.purple),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Phone',
                      labelStyle: GoogleFonts.ubuntu(color: Colors.purple)),
                ),
              ),
              SizedBox(
                height: 50,
                // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    // print(loginMap['message']);
                    var name = nameController.text.toString();
                    var email = emailController.text.toString();
                    var password = passwordController.text.toString();
                    var phone = phoneController.text.toString();
                    //print
                    // await dbclass.userRegister(name, email, password, phone);
                    var userclass = await dbclass.userRegister(
                        name, email, password, phone);
                    userclass;

                    map = dbclass.mapRegister;
                    message = dbclass.mapRegister['message'].toString();
                    // print(message);
                    // print('printing user');
                    // print(dbclass.mapRegister['user'].toString());
                    //checking map if its empty or shit
                    if (map.isEmpty) {
                      // print('map is empty');

                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Warning', style: GoogleFonts.ubuntu()),
                          content: FutureBuilder(
                            future: dbclass.userRegister(
                                name, email, password, phone),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  softWrap: true,
                                  style: GoogleFonts.ubuntu(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                );
                              } else {
                                return const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(); // dismisses only the dialog and returns nothing
                              },
                              child: const Text('Try again'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (message.isNotEmpty && message == 'True') {
                        //shared prefs !!!

                        // print('True');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => const users()));
                      } else if (message.isNotEmpty && message != 'True') {
                        // print('False');
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Warning'),
                            content: Text(message.toString()),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // dismisses only the dialog and returns nothing
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    // print(nameController.text);
                    // print(emailController.text);
                    // print(passwordController.text);
                    // print(phoneController.text);
                  },
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // print(dbclass.getEmail());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Login()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Login instead",
                          style: GoogleFonts.ubuntu(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
