import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(AntIcons.contactsOutlined,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'Basic Info',
                            style: GoogleFonts.ubuntu(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(AntIcons.userOutlined),
                          prefixIconColor: Theme.of(context).primaryColor,
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
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(AntIcons.mailOutlined),
                          prefixIconColor: Theme.of(context).primaryColor,
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
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(AntIcons.securityScanOutlined),
                          prefixIconColor: Theme.of(context).primaryColor,
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
                      const Divider(),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(AntIcons.auditOutlined,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'Contact Info',
                            style: GoogleFonts.ubuntu(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(AntIcons.phoneOutlined),
                          prefixIconColor: Theme.of(context).primaryColor,
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
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'City',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(AntIcons.environmentOutlined),
                          prefixIconColor: Theme.of(context).primaryColor,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your City';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          dbclass.initial_city = value;
                        },
                        controller: cityController,
                      ),
                      const SizedBox(height: 32.0),
                      const Divider(),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        // color: Colors.red,
                        // textColor: Colors.white,
                        child: const Text('Update Profile'),
                        onPressed: () {
                          print('Update Profile');
                          // TODO: Implement delete profile functionality
                        },
                      ),
                      const SizedBox(height: 32.0),
                      const Divider(),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(AntIcons.warningOutlined,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'Account Settings',
                            style: GoogleFonts.ubuntu(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(
                          'Delete this account',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        subtitle: const Text('Your account will be removed'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            print('delete account');
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(AntIcons.deleteOutlined),
                              SizedBox(
                                width: 1.0,
                              ),
                              Text('Delete Account'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
