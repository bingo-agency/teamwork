import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_work/models/database.dart';
import 'package:team_work/pages/auth/forget_pass.dart';
import 'package:team_work/pages/auth/register.dart';
import 'package:team_work/pages/auth/users.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map;
    String message;
    var dbclass = context.read<DataBase>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Login",
          style: GoogleFonts.ubuntu(),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  height: 350,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            child: Text(
                              "Login & Find over 54,000 properties",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 30.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                              child: const Image(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/images/banner6.png'),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ) //BoxDecoration
                              ), //Container
                        )
                      ])),
              Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: GoogleFonts.ubuntu(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                  )),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const forgetPassword()));
                },
                child: Text(
                  'Forgot Password',
                  style:
                      GoogleFonts.ubuntu(color: Theme.of(context).primaryColor),
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: Colors.purple,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    child: const Text('Login'),
                    onPressed: () async {
                      // print(loginMap['message']);
                      var email = emailController.text.toString();
                      var password = passwordController.text.toString();
                      //print
                      var userclass = await dbclass.userLogin(email, password);
                      map = await dbclass.mapLogin;
                      message = await dbclass.mapLogin['message'].toString();
                      //checking map if its empty or shit
                      if (map.isEmpty) {
                        print('map is empty');
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Warning', style: GoogleFonts.ubuntu()),
                            content: FutureBuilder(
                              future: dbclass.userLogin(email, password),
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
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // dismisses only the dialog and returns nothing
                                },
                                child: Text(
                                  'Try again',
                                  style: GoogleFonts.ubuntu(),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        if (message.isNotEmpty && message == 'True') {
                          //shared prefs !!!

                          print('True');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const users()));
                        } else if (message.isNotEmpty && message == 'False') {
                          print('False');
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Warning',
                                style: GoogleFonts.ubuntu(),
                              ),
                              content: Text(
                                'Invalid Credentials,Login Failed',
                                style: GoogleFonts.ubuntu(),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(); // dismisses only the dialog and returns nothing
                                  },
                                  child: Text(
                                    'Try again',
                                    style: GoogleFonts.ubuntu(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      print(emailController.text);
                      print(passwordController.text);
                    },
                  )),
              const Divider(),
              Row(
                children: <Widget>[
                  Text(
                    'Does not have account?',
                    style: GoogleFonts.ubuntu(),
                  ),
                  TextButton(
                    child: Text(
                      'Register',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const Register()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ],
          )),
    );
  }
}
