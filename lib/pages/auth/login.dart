import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_work/models/database.dart';

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
                            child: Text(
                              "Login & Find over 54,000 properties",
                              style: TextStyle(
                                  fontSize: 40.0,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
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
                    style: TextStyle(
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
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Theme.of(context).primaryColor),
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

                      var login = await dbclass.userLogin(email, password);
                      map = await dbclass.mapLogin;
                      message = await dbclass.mapLogin['message'].toString();
                      if (map.isEmpty) {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Warning'),
                            content: FutureBuilder(
                              future: dbclass.userLogin(email, password),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data.toString(),
                                    softWrap: true,
                                    style: TextStyle(
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

                            // Container(
                            //     height: 200,
                            //     child:
                            //         Center(child: CircularProgressIndicator())),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // dismisses only the dialog and returns nothing
                                },
                                child: Text('Try again'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        if (message.isNotEmpty && message == 'True') {
                          //shared prefs !!!
                          print('True');
                        } else if (message.isNotEmpty && message == 'False') {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Warning'),
                              content: FutureBuilder(
                                future: dbclass.userLogin(email, password),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.toString(),
                                      softWrap: true,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    );
                                  } else {
                                    return const SizedBox(
                                      height: 150,
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
                                  child: Text('Try again'),
                                ),
                              ],
                            ),
                          );
                        }

                        print('your login map is ' + map.toString());
                      }

                      // dbclass
                      //     .userLogin(
                      //         emailController.text, passwordController.text)
                      //     .then((value) => () async {})
                      //     .whenComplete(() => () {
                      //           print(dbclass.mapLogin.toString());
                      //         });
                      print(emailController.text);
                      print(passwordController.text);
                      // print();
                      // print();
                    },
                  )),
              const Divider(),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      //signup screen
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
