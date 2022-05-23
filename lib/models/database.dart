import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBase with ChangeNotifier {
  //shared prefs start

  String initial_city = 'Select City';

  // Database() {
  //   getCity();
  // }

  // void getCity() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String seetea = (await prefs.getString('initial_city') ?? '');
  //   initial_city = seetea;
  //   notifyListeners();
  // }
  Future<String> getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = (prefs.getString('initial_city') ?? 'Islamabad');
    initial_city = stringValue;
    notifyListeners();
    return stringValue;
  }

  void setCity(city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('initial_city', city);
    print('new city set');
    print(city);
    initial_city = city;
    notifyListeners();
  }

  String username = '';
  String password = '';

  addCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('initial_city', "Islamabad");
    notifyListeners();
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('initial_city', initial_city);
    String username = '';
    String password = '';
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initial_city = prefs.getString('initial_city') ?? 'Islamabad';
    notifyListeners();
  }

  void _getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? '';
    password = prefs.getString('password') ?? '';
    notifyListeners();
  }

  void addAuth(username, password, user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
    prefs.setString('id', user['id'].toString());
    prefs.setString('image', user['image'].toString());
    prefs.setString('phone', user['phone'].toString());
    prefs.setString('timestamp', user['timestamp'].toString());
    print('auth added ');
    String? us = await prefs.getString('image');
    print("Coming from the add auth " + us.toString());
    _setPrefItems();
    notifyListeners();
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("username");
    prefs.remove("email");
    prefs.remove("password");
    prefs.remove("id");
    prefs.remove("image");
    prefs.remove("phone");
    prefs.remove("timestamp");
    prefs.remove("initial_city");
  }

  // void setCity(initial_city) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('initial_city', initial_city);
  //   print(initial_city + ' was selected');
  //   _setPrefItems();
  //   notifyListeners();
  // }

  String getUsername() {
    _getAuth();
    return username;
  }

  // String getCity() {
  //   _getPrefItems();
  //   return initial_city;
  // }

  Future<String> getCurrentCity() async {
    if (initial_city == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      initial_city = prefs.getString('initial_city') ?? 'Islamabad';
      notifyListeners();
    }

    return initial_city;
  }

  // late Future<SharedPreferences> sharedPreferences;
  //
  // Stream<SharedPreferences> get prefsState => sharedPreferences.asStream();

  // Future get fetchPrefs async {
  //   final SharedPreferences prefs = await sharedPreferences;
  //   // prefs.getInt('counter');
  //   prefs.setString('username', 'hassan');
  //   prefs.setString('password', '123456');
  //
  //   print('cool');
  // }

  //shared prefs end

  Map<String, dynamic> _mapRegister = {};
  bool _errorRegister = false;
  String _errorMessageRegister = '';

  Map<String, dynamic> get mapRegister => _mapRegister;

  bool get errorRegister => _errorRegister;

  String get errorMessageRegister => _errorMessageRegister;

  Future<void> userRegister(String email, String password, String phone) async {
    final response = await get(
      Uri.parse('https://teamworkpk.com/API/registrationapi.php?email=' +
          email +
          '&password=' +
          password +
          '&phone=' +
          phone),
    );
    if (response.statusCode == 200) {
      try {
        _mapListingDetail = jsonDecode(response.body);
        _errorListingDetail = false;
      } catch (e) {
        _errorListingDetail = true;
        _errorMessageListingDetail = e.toString();
        _mapListingDetail = {};
      }
    } else {
      _errorListingDetail = true;
      _errorMessageListingDetail =
          'Error : It could be your Internet connection.';
      _mapListingDetail = {};
    }
    notifyListeners();
  }

  // login starts here
  Map<String, dynamic> _mapLogin = {};
  Map<String, dynamic> _user = {};
  bool _errorLogin = false;
  String _errorMessageLogin = '';

  Map<String, dynamic> get mapLogin => _mapLogin;

  Map<String, dynamic> get user => _user;

  bool get errorLogin => _errorLogin;

  String get errorMessageLogin => _errorMessageLogin;

  Future<void> userLogin(String email, String password) async {
    String completeurl = 'https://teamworkpk.com/API/loginapi.php?email=' +
        email +
        '&password=' +
        password;
    print(completeurl);
    final response = await get(
      Uri.parse('https://teamworkpk.com/API/loginapi.php?email=' +
          email +
          '&password=' +
          password),
    );
    if (response.statusCode == 200) {
      try {
        _mapLogin = jsonDecode(response.body);
        _errorLogin = false;
        if (_mapLogin.isNotEmpty && _mapLogin['message'] == "True") {
          _user = _mapLogin['user'];
          addAuth(email, password, _user);
        }
      } catch (e) {
        _errorLogin = true;
        _errorMessageLogin = e.toString();
        _mapLogin = {};
      }
    } else {
      _errorLogin = true;
      _errorMessageLogin = 'Error : It could be your Internet connection.';
      _mapLogin = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapFeatured = {};
  bool _errorFeatured = false;
  String _errorMessageFeatured = '';

  Map<String, dynamic> get mapFeatured => _mapFeatured;

  bool get errorFeatured => _errorFeatured;

  String get errorMessageFeatured => _errorMessageFeatured;

  Future<void> get fetchFeatured async {
    final response = await get(
      Uri.parse('https://teamworkpk.com/API/featured.php'),
    );
    if (response.statusCode == 200) {
      try {
        _mapFeatured = jsonDecode(response.body);
        _errorFeatured = false;
      } catch (e) {
        _errorFeatured = true;
        _errorMessageFeatured = e.toString();
        _mapFeatured = {};
      }
    } else {
      _errorFeatured = true;
      _errorMessageFeatured = 'Error : It could be your Internet connection.';
      _mapFeatured = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapListingDetail = {};
  bool _errorListingDetail = false;
  String _errorMessageListingDetail = '';

  Map<String, dynamic> get mapListingDetail => _mapListingDetail;

  bool get errorListingDetail => _errorListingDetail;

  String get errorMessageListingDetail => _errorMessageListingDetail;

  Future<void> fetchListingDetail(String id) async {
    final response = await get(
      Uri.parse(
          'https://teamworkpk.com/API/listing_detail.php?web_post_id=' + id),
    );
    if (response.statusCode == 200) {
      try {
        _mapListingDetail = jsonDecode(response.body);
        _errorListingDetail = false;
      } catch (e) {
        _errorListingDetail = true;
        _errorMessageListingDetail = e.toString();
        _mapListingDetail = {};
      }
    } else {
      _errorListingDetail = true;
      _errorMessageListingDetail =
          'Error : It could be your Internet connection.';
      _mapListingDetail = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapSearch = {};
  bool _errorSearch = false;
  String _errorMessageSearch = '';

  Map<String, dynamic> get mapSearch => _mapSearch;

  bool get errorSearch => _errorSearch;

  String get errorMessageSearch => _errorMessageSearch;

  Future<void> Search(String curl) async {
    final response = await get(
      Uri.parse('https://teamworkpk.com/API/nonfeatured.php' + curl),
    );
    if (response.statusCode == 200) {
      try {
        _mapSearch = jsonDecode(response.body);
        _errorSearch = false;
      } catch (e) {
        _errorSearch = true;
        _errorMessageSearch = e.toString();
        _mapSearch = {};
      }
    } else {
      _errorSearch = true;
      _errorMessageSearch = 'Error : It could be your Internet connection.';
      _mapSearch = {};
    }
    notifyListeners();
  }

  // Future<void> get fetchListingDetail async {
  //   final response = await get(
  //     Uri.parse('https://teamworkpk.com/API/listing_detail.php?web_post_id='),
  //   );
  //   if (response.statusCode == 200) {
  //     try {
  //       _mapFeatured = jsonDecode(response.body);
  //       _errorFeatured = false;
  //     } catch (e) {
  //       _errorFeatured = true;
  //       _errorMessageFeatured = e.toString();
  //       _mapFeatured = {};
  //     }
  //   } else {
  //     _errorFeatured = true;
  //     _errorMessageFeatured = 'Error : It could be your Internet connection.';
  //     _mapFeatured = {};
  //   }
  //   notifyListeners();
  // }

  Map<String, dynamic> _mapListing = {};
  bool _errorListing = false;
  String _errorMessageListing = '';

  Map<String, dynamic> get mapListing => _mapListing;

  bool get errorListing => _errorListing;

  String get errorMessageListing => _errorMessageListing;

  Future<void> get fetchListing async {
    final response = await get(
      Uri.parse('https://teamworkpk.com/API/nonfeatured.php'),
    );
    if (response.statusCode == 200) {
      try {
        _mapListing = jsonDecode(response.body);
        _errorListing = false;
      } catch (e) {
        _errorListing = true;
        _errorMessageListing = e.toString();
        _mapListing = {};
      }
    } else {
      _errorListing = true;
      _errorMessageListing = 'Error : It could be your Internet connection.';
      _mapListing = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapProjects = {};
  bool _errorProjects = false;
  String _errorMessageProjects = '';

  Map<String, dynamic> get mapProjects => _mapProjects;

  bool get errorProjects => _errorProjects;

  String get errorMessageProjects => _errorMessageProjects;

  Future<void> get fetchProjects async {
    final response = await get(
      Uri.parse('https://teamworkpk.com/API/projects.php'),
    );
    if (response.statusCode == 200) {
      try {
        _mapProjects = jsonDecode(response.body);
        _errorProjects = false;
      } catch (e) {
        _errorProjects = true;
        _errorMessageProjects = e.toString();
        _mapProjects = {};
      }
    } else {
      _errorProjects = true;
      _errorMessageProjects = 'Error : It could be your Internet connection.';
      _mapProjects = {};
    }
    notifyListeners();
  }

  void initialValues() {
    _mapFeatured = {};
    _errorFeatured = false;
    _errorMessageFeatured = '';

    _mapListing = {};
    _errorListing = false;
    _errorMessageListing = '';

    _mapProjects = {};
    _errorProjects = false;
    _errorMessageProjects = '';

    _mapListingDetail = {};
    _errorListingDetail = false;
    _errorMessageListingDetail = '';

    _mapSearch = {};
    _errorSearch = false;
    _errorMessageSearch = '';

    notifyListeners();
  }
}
