import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/database.dart';

class SettingsPage extends StatefulWidget {
  String id;
  SettingsPage({Key? key, required this.id}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var dbclass = context.read<DataBase>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<DataBase>(builder: (context, value, child) {
          TextEditingController nameController =
              TextEditingController(text: value.name);
          TextEditingController emailController =
              TextEditingController(text: value.email);
          TextEditingController passwordController =
              TextEditingController(text: value.password);
          TextEditingController phoneController =
              TextEditingController(text: value.phone);
          TextEditingController cityController =
              TextEditingController(text: value.initial_city);
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    dbclass.name = value;
                  },
                  controller: nameController,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    dbclass.email = value;
                  },
                  controller: emailController,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    dbclass.password = value;
                  },
                  controller: passwordController,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    dbclass.phone = value;
                  },
                  controller: phoneController,
                ),
                const SizedBox(height: 32.0),
                const Divider(),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  // color: Colors.red,
                  // textColor: Colors.white,
                  child: const Text('Delete Profile'),
                  onPressed: () {
                    // TODO: Implement delete profile functionality
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
