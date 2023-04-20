import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_work/pages/home/home.dart';

import '../../models/database.dart';

class forgetPassword extends StatelessWidget {
  const forgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();

    TextEditingController email = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password'),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                focusColor: Colors.white,
                //add prefix icon

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,

                hintText: "Email",

                //make hint text
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: "verdana_regular",
                  fontWeight: FontWeight.w400,
                ),

                //create lable
                labelText: 'Email',
                //lable style
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: "verdana_regular",
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              dbclass.checkUser(email.text);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Recovery'),
                      content: FutureBuilder(
                        future: dbclass.checkUser(email),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.toString());
                          } else {
                            return const Text(
                                'A link has been sent to your Email.');
                          }
                        },
                      ),
                      // Text(dbclass.mapForgotten.toString()),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage()));
                          },
                          child: const Text('Back Home'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  });
            },
            child: const Text('Recover Password'),
          ),
        ),
        // Container(
        //   alignment: Alignment.bottomRight,
        //   child: ElevatedButton(
        //     onPressed: () {},
        //     child: Text('Recover Password'),
        //   ),
        // )
      ]),
    );
  }
}
