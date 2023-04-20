import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

import 'dart:async';

class DataBase with ChangeNotifier {
  //add property stepper :

  int activeIndex = 0;
  int totalIndex = 2;

  changeStep(int index) {
    activeIndex = index;
    notifyListeners();
  }

  //shared prefs start

  String initial_city = 'Select City';
  bool postedAd = false;

  //property images starts

  // List<Asset> propertyImages = <Asset>[];

  // String loadAssets = 'No Error Dectected';
  bool showSpinner = false;

  // Future<void> setPropertyImages(listofimages) async {
  //   propertyImages = listofimages;
  //   notifyListeners();
  // }

  getPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
      }

// You can request multiple permissions at once.
      // Map<Permission, PermissionStatus> statuses = await [
      //   Permission.location,
      //   Permission.storage,
      // ].request();
      // print(statuses[Permission.location]);
      getCurrentlocation();
      getCityLocation();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    } else {
      // print('is not dnied');
    }
    notifyListeners();
  }

  double x = 0.0;
  double y = 0.0;

  void getCurrentlocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // var lastPosition = await Geolocator.getLastKnownPosition();
    x = position.latitude;
    y = position.longitude;
    Getlocation(x.toString(), y.toString());
    // print('${lastPosition}last position');
    notifyListeners();
  }

  Map<String, dynamic> _mapLocation = {};
  bool _errorLocation = false;
  String _errorMessageLocation = '';

  Map<String, dynamic> get mapLocation => _mapLocation;

  bool get errorLocation => _errorLocation;

  String get errorMessageLocation => _errorMessageLocation;

  Future<void> Getlocation(String lat, String lng) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyCb3U_z-owpRwGS321AP0JX09crvvQj4dw&sensor=false'));

    if (response.statusCode == 200) {
      try {
        _mapLocation = jsonDecode(response.body);
        // print(_mapLocation.toString());

        _errorLocation = false;
        if (_mapLocation.isNotEmpty) {
          getCityLocation();

          // addlocation( lat , lng);
        }
      } catch (e) {
        _errorLocation = true;
        _errorMessageLocation = e.toString();
        _mapLocation = {};
      }
    } else {
      _errorLocation = true;
      _errorMessageLocation = 'Error : It could be your Internet connection.';
      _mapLocation = {};
    }
    notifyListeners();
  }

  Future<void> getCityLocation() async {
    var gottenCity = _mapLocation['results'][0]['address_components'][5]
            ['long_name']
        .toString();
    initial_city = gottenCity;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('initial_city', gottenCity);
    initial_city = prefs.getString('initial_city') ?? '';
    // print('printing city name$initial_city');
    // SetCityForSearchbar(Cityname.toString());

    notifyListeners();
  }

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  Future<void> loadAssets() async {
    // List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      // resultList = await MultiImagePicker.pickImages(
      //   maxImages: 300,
      //   enableCamera: true,
      //   selectedAssets: propertyImages,
      //   cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
      //   materialOptions: const MaterialOptions(
      //     actionBarColor: "#6f1c74",
      //     actionBarTitle: "Select Property Images",
      //     allViewTitle: "All Photos",
      //     useDetailsView: false,
      //     selectCircleStrokeColor: "#5e1863",
      //   ),
      // );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // propertyImages = resultList;
    error = error;

    notifyListeners();
  }

  Future getSpinnerValue() async {
    var spinVal = showSpinner;
    return spinVal;
  }

  Dio dio = Dio();

  // Future uploadImageToServer() async {
  //   String completeurl =
  //       'https://teamworkpk.com/API/add_property_images.php?post_id=' + post_id;
  //   print(completeurl);
  //   for (var i = 0; i < propertyImages.length; i++) {
  //     // print(i);
  //     ByteData byteData = await propertyImages[i].getByteData();
  //     List<int> imageData = byteData.buffer.asUint8List();

  //     MultipartFile multiPartFile = MultipartFile.fromBytes(
  //       imageData,
  //       filename: propertyImages[i].name,
  //       contentType: MediaType('image', 'jpeg'),
  //     );
  //     FormData formData = FormData.fromMap({'image': multiPartFile});
  //     var response = await dio.post(completeurl, data: formData);
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //     } else {
  //       print(response.statusCode);
  //     }
  //   }
  // }

  // Future uploadImageToServer() async {
  //   String completeurl =
  //       'https://teamworkpk.com/API/add_property_images.php?post_id=' + post_id;
  //   print(completeurl);
  //   var newString;
  //   try {
  //     showSpinner = true;
  //
  //     var uri = Uri.parse(completeurl);
  //     http.MultipartRequest request = http.MultipartRequest('POST', uri);
  //
  //     request.fields['userid'] = id;
  //     // request.fields['title'] = id;
  //
  //     List<http.MultipartFile> newList = <http.MultipartFile>[];
  //     int piloop = 0;
  //     var response;
  //
  //     for (int i = 0; i < propertyImages.length; i++) {
  //       print('printing i ');
  //       print(i);
  //       var path = await FlutterAbsolutePath.getAbsolutePath(
  //           propertyImages[i].identifier);
  //       File imageFile = File(path);
  //
  //       var stream = http.ByteStream(imageFile.openRead());
  //       var length = await imageFile.length();
  //
  //       var multipartFile = http.MultipartFile(
  //         "image",
  //         stream,
  //         length,
  //         contentType: MediaType('image', 'png'),
  //         filename: basename(imageFile.path),
  //       );
  //       newList.add(multipartFile);
  //
  //       // print('printing newList inside loop');
  //       // print(newList);
  //       request.files.addAll(newList);
  //       piloop++;
  //     }
  //
  //     response = await request.send();
  //
  //     print('printing newList outside loop');
  //     print(newList);
  //
  //     if (response.statusCode == 200) {
  //       response.stream.transform(utf8.decoder).listen((value) {
  //         print('last val ' + value);
  //         // print(jsonDecode(value));
  //       });
  //       if (propertyImages.length == piloop) {
  //         print('its 200 and length is equal to list as well ');
  //         Timer(
  //             const Duration(seconds: 2),
  //             () => () {
  //                   showSpinner = true;
  //                 });
  //       } else {
  //         print('not 200');
  //         Timer(
  //             const Duration(seconds: 2),
  //             () => () {
  //                   showSpinner = true;
  //                 });
  //       }
  //       print('piloop is same length');
  //       print(piloop);
  //     }
  //
  //     await piloop;
  //     if (piloop == propertyImages.length) {
  //       print('piloop is same length');
  //       print(piloop);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     showSpinner = false;
  //
  //     print(e.toString());
  //     // notifyListeners();
  //   }
  // }

  // Future<void> selectImages() async {
  //   final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  //
  //   if (selectedImages!.isNotEmpty) {
  //     imageFileList!.addAll(selectedImages);
  //   }
  //   print("Image List Length:" + imageFileList!.length.toString());
  //   notifyListeners();
  // }

  String post_id = '0';
  List<dynamic> finalResImages = [];

  Future<void> setPostId(id) async {
    id = post_id;
    notifyListeners();
  }

//   Future<void> uploadingPropertyImages(id) async {
//     String completeurl =
//         'https://teamworkpk.com/API/add_property_images.php?post_id=' + id;
//     print('printing uploading property images ');
//
//     if (imageFileList != null) {
//       print(imageFileList!.length);
// // string to uri
//       var uri = Uri.parse(completeurl);
//
// // create multipart request
//       var request = http.MultipartRequest("POST", uri);
//       for (var file in imageFileList!) {
//         print(file.path);
//         request.files.add(http.MultipartFile(
//             'picturePath',
//             File(file!.path).readAsBytes().asStream(),
//             File(file!.path).lengthSync(),
//             filename: file.path!.split("/").last));
//
//         request.files
//             .add(await http.MultipartFile.fromPath('picture', file!.name));
//         var res = await request.send();
//       }
//
//       var res = await request.send();
//       print(res);
//
//       // for (int i = 0; i < imageFileList!.length; i++) {
//       //   String base64Image = base64Encode(imageFileList[i]!.readAsBytes());
//       //   String fileName = primaryImage!.path.split("/").last;
//       //
//       //   response = await http.post(Uri.parse(completeurl), body: {
//       //     "image": base64Image,
//       //     "name": fileName,
//       //   });
//       //
//       //   if (response.statusCode == 200) {
//       //     print('its 200 from new shit ');
//       //     var abPost = jsonDecode(response.body);
//       //
//       //     if (response.body.isNotEmpty) {
//       //       print(abPost.toString());
//       //       post_id = abPost['adpost'][0]['last_id'].toString();
//       //       // postedAd = true;
//       //       // print('printing post_id');
//       //       // print(post_id);
//       //       // setPostId(post_id);
//       //       // uploadingPropertyImages(post_id);printing post_id
//       //     } else {
//       //       print('nope the status code is not 200' + response.body.toString());
//       //     }
//       //   } else {
//       //     // _errorAddProperty = true;
//       //     // _errorMessageAddProperty =
//       //     // 'Error : It could be your Internet connection.';
//       //     // _mapAddProperty = {};
//       //   }
//       // }
//
//       // for (var file in imageFileList!) {
//       //   String fileName = file.path.split("/").last;
//       //   var stream = http.ByteStream(file.openRead());
//       //   stream.cast();
//       //
//       //   // get file length
//       //
//       //   var length = await file.length(); //imageFile is your image file
//       //
//       //   // multipart that takes file
//       //   var multipartFileSign =
//       //       http.MultipartFile('image', stream, length, filename: fileName);
//       //   print(fileName);
//       //
//       //   request.files.add(multipartFileSign);
//       // }
//
//       // Map<String, String> headers = {
//       //   "Accept": "application/json",
//       //   "Authorization": "Bearer $value"
//       // }; // ignore this headers if there is no authentication
//
// //add headers
// //       request.headers.addAll(headers);
//
// //adding params
// //       request.fields['id'] = post_id;
// //       request.fields['images'] = request.files.toString();
// // request.fields['lastName'] = 'efg';
//
// // send
// //       response = await request.send();
//
//       // print(response.statusCode);
//
// // listen for response
// //       response.stream.transform(utf8.decoder).listen((value) {
// //         print('last val ' + value);
// //       });
//       // for (int i = 0; i < imageFileList!.length; i++) {
//       //   // print(imageFileList![i].path);
//       //   Uint8List base64Image = await imageFileList![i].readAsBytes();
//       //   String fileName = imageFileList![i].path.split("/").last;
//       //   print(fileName);
//       //
//       //   response = await http.post(Uri.parse(completeurl), body: {
//       //     "image": base64Image.toString(),
//       //     "name": fileName,
//       //   });
//       // }
//       // if (response.statusCode == 200) {
//       //   print('its 200 last one');
//       //   print(response.body);
//       //   var abPost = jsonDecode(response.body);
//       //   print(abPost);
//       //   return abPost;
//       // } else {
//       //   // _errorAddProperty = true;
//       //   // _errorMessageAddProperty =
//       //   //     'Error : It could be your Internet connection.';
//       //   // _mapAddProperty = {};
//       // }
//     }
//   }

  // promerty images ends

  // primary image shit starts here
  // File? primaryImage;
  File? primaryImage;

  // var imagetoupload;

  // late Future<File> file = primaryImage as Future<File>;

  Future setPrimaryImage(img) async {
    primaryImage = img;
    // imagetoupload = img;
    notifyListeners();
  }

  //primary image shit ends here

  //form fields
  String purposeIndex = 'Exchange';

  Future<void> setPurpose(value) async {
    purposeIndex = value;
    notifyListeners();
  }

  String propertyTypeIndex = 'Residential';

  Future<void> setproperty_type(value) async {
    propertyTypeIndex = value;
    notifyListeners();
  }

  String typeIndex = 'House';

  Future<void> setType(value) async {
    typeIndex = value;
    notifyListeners();
  }

  String addressIndex = '';

  Future<void> setAddress(value) async {
    addressIndex = value;
    notifyListeners();
  }

  String yearBuildIndex = '';

  Future<void> setYearBuild(value) async {
    yearBuildIndex = value;
    notifyListeners();
  }

  String priceIndex = '';

  Future<void> setPrice(value) async {
    priceIndex = value;
    notifyListeners();
  }

  String titleIndex = '';

  Future<void> setTitle(value) async {
    titleIndex = value;
    notifyListeners();
  }

  String descriptionIndex = '';

  Future<void> setDescription(value) async {
    descriptionIndex = value;
    notifyListeners();
  }

  Future<void> addPrefval(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = (prefs.getString(key) ?? value);
    // print('added to pref ' + key + ' - ' + value);
    notifyListeners();
  }

  Future<String> getPrefval(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = (prefs.getString(key) ?? value);
    // print('gotten from pref ' + key + ' - ' + value);
    notifyListeners();
    return stringValue;
  }

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
    prefs.setString('initial_city', city);
    // print('new city set');
    // print(city);
    initial_city = city;
    notifyListeners();
  }

  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String id = '';
  String image = '';
  String timestamp = '';

  addCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('initial_city', "Islamabad");
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initial_city = prefs.getString('initial_city') ?? 'Islamabad';
    notifyListeners();
  }

  void _getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    email = prefs.getString('email') ?? '';
    password = prefs.getString('password') ?? '';
    id = prefs.getString('id') ?? '';
    image = prefs.getString('image') ?? '';
    phone = prefs.getString('phone') ?? '';
    timestamp = prefs.getString('timestamp') ?? '';
    notifyListeners();
  }

  void addAuth(id, name, email, password, image, phone, timestamp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('image', image);
    prefs.setString('phone', phone);
    prefs.setString('timestamp', timestamp);
    // print('auth added ');
    notifyListeners();
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("password");
    prefs.remove("id");
    prefs.remove("image");
    prefs.remove("phone");
    prefs.remove("timestamp");
    prefs.remove("initial_city");
    notifyListeners();
  }

  Future<String> getName() async {
    _getAuth();
    // notifyListeners();
    return name;
  }

  Future<String> getEmail() async {
    _getAuth();
    return email;
  }

  Future<String> getPhone() async {
    _getAuth();
    return phone;
  }

  Future<String> getPassword() async {
    _getAuth();
    return password;
  }

  Future<String> getImage() async {
    _getAuth();

    return image;
  }

  Future<String> getId() async {
    _getAuth();

    return id;
  }

  Future<String> getTimestamp() async {
    _getAuth();
    return timestamp;
  }

  Future<String> getCurrentCity() async {
    if (initial_city == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      initial_city = prefs.getString('initial_city') ?? 'Islamabad';
      notifyListeners();
    }

    return initial_city;
  }

  Future<String> removeWebPost(webPostId) async {
    String finalres = '';
    String completeurl =
        'https://teamworkpk.com/API/remove.php?id=' + webPostId;
    // print(completeurl);
    var response = await http.get(Uri.parse(completeurl));
    if (response.statusCode == 200) {
      // print('your record is removed or is 200');
      // print(response.body);
      var res = jsonDecode(response.body);
      // print(res['remove'][0]);
      finalres = res['remove'].toString();
    }

    return finalres;
  }

  //shared prefs end

  //add property starts here

  Map<String, dynamic> _mapAddProperty = {};
  bool _errorAddProperty = false;
  String _errorMessageAddProperty = '';

  Map<String, dynamic> get mapAddProperty => _mapAddProperty;

  bool get errorAddProperty => _errorAddProperty;

  String get errorMessageAddProperty => _errorMessageAddProperty;

  Future<void> addProperty(id, purpose, type, city, address, yearBuild, price,
      title, description, propertyType) async {
    String completeurl =
        '${'https://teamworkpk.com/API/addPost.php?purpose=' + purpose + '&type=' + type + '&city=' + city + '&address=' + address + '&year_build=' + yearBuild + '&price=' + price + '&title=' + title + '&description=' + description + '&property_type=' + propertyType}&user_id=' +
            id;
    // print(completeurl);

    final http.Response response;
    if (primaryImage != null) {
      String base64Image = base64Encode(primaryImage!.readAsBytesSync());
      String fileName = primaryImage!.path.split("/").last;

      response = await http.post(Uri.parse(completeurl), body: {
        "image": base64Image,
        "name": fileName,
      });
      if (response.statusCode == 200) {
        // print('its 200');
        var abPost = jsonDecode(response.body);

        if (response.body.isNotEmpty) {
          // print(abPost['adpost'][0]['last_id'].toString());
          post_id = abPost['adpost'][0]['last_id'].toString();
          postedAd = true;
          // print('printing post_id');
          // print(post_id);
          // uploadImageToServer();
          setPostId(post_id);
        } else {
          // print('nope the status code is not 200' + response.body.toString());
        }

        try {
          _mapAddProperty = jsonDecode(response.body);
          _errorAddProperty = false;
        } catch (e) {
          _errorAddProperty = true;
          _errorMessageAddProperty = e.toString();
          _mapAddProperty = {};
        }
      } else {
        _errorAddProperty = true;
        _errorMessageAddProperty =
            'Error : It could be your Internet connection.';
        _mapAddProperty = {};
      }
    }

    notifyListeners();
  }

  //add proeprty ends here

  //user register starts here

  Map<String, dynamic> _mapRegister = {};
  bool _errorRegister = false;
  String _errorMessageRegister = '';

  Map<String, dynamic> get mapRegister => _mapRegister;

  bool get errorRegister => _errorRegister;

  String get errorMessageRegister => _errorMessageRegister;

  Future<void> userRegister(
      String name, String email, String password, String phone) async {
    String completeurl =
        'https://teamworkpk.com/API/registrationapi.php?name=$name&email=$email&password=$password&phone=$phone';
    // print(completeurl);
    final response = await http.get(
      Uri.parse(completeurl),
    );
    if (response.statusCode == 200) {
      try {
        _mapRegister = jsonDecode(response.body);
        _errorRegister = false;

        // var gottenmapreg = jsonDecode(response.body);
        // print(gottenmapreg);
        if (_mapRegister.isNotEmpty && _mapRegister['message'] == "True") {
          // print('yes its true from db and following is printing user object.');
          // print(_mapRegister['user']['id']);
          id = _mapRegister['user']['id'].toString();
          name = _mapRegister['user']['name'].toString();
          email = _mapRegister['user']['email'].toString();
          image = _mapRegister['user']['image'].toString();
          timestamp = _mapRegister['user']['timestamp'].toString();
          phone = _mapRegister['user']['phone'].toString();
          addAuth(id, name, email, password, image, phone, timestamp);
        }
      } catch (e) {
        _errorRegister = true;
        _errorMessageRegister = e.toString();
        _mapRegister = {};
      }
    } else {
      _errorRegister = true;
      _errorMessageRegister = 'Error : It could be your Internet connection.';
      _mapRegister = {};
    }
    notifyListeners();
  }

  //register ends here !!!

  // login starts here
  Map<String, dynamic> _mapLogin = {};
  bool _errorLogin = false;
  String _errorMessageLogin = '';

  Map<String, dynamic> get mapLogin => _mapLogin;

  bool get errorLogin => _errorLogin;

  String get errorMessageLogin => _errorMessageLogin;

  Future<void> userLogin(String email, String password) async {
    String completeurl =
        'https://teamworkpk.com/API/loginapi.php?email=$email&password=$password';
    // print(completeurl);
    final response = await http.get(
      Uri.parse(
          'https://teamworkpk.com/API/loginapi.php?email=$email&password=$password'),
    );
    if (response.statusCode == 200) {
      try {
        _mapLogin = jsonDecode(response.body);
        _errorLogin = false;
        if (_mapLogin.isNotEmpty && _mapLogin['message'] == "True") {
          // print('yes its true from db');
          // print(_mapLogin['user'][0]['id'].toString());
          id = _mapLogin['user'][0]['id'].toString();
          name = _mapLogin['user'][0]['name'].toString();
          image = _mapLogin['user'][0]['image'].toString();
          phone = _mapLogin['user'][0]['phone'].toString();
          timestamp = _mapLogin['user'][0]['timestamp'].toString();
          addAuth(id, name, email, password, image, phone, timestamp);
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
    final response = await http.get(
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
    final response = await http.get(
      Uri.parse(
          'https://teamworkpk.com/API/listing_detail.php?web_post_id=$id'),
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
    final response = await http.get(
      Uri.parse('https://teamworkpk.com/API/nonfeatured.php$curl'),
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

  final Map<String, dynamic> _mapForgotten = {};

  Map<String, dynamic> get mapForgotten => _mapForgotten;

  Future checkUser(email) async {
    var response = await http.post(Uri.parse(
        'http://teamworkpk.com/API/forget_password.php?email=$email'));

    var link = jsonDecode(response.body);

    if (link == "true") {
      // print('User has been sent an email for reset password.');
    } else {}
    // print(link);
    return link;
  }

  Map<String, dynamic> _mapAccount = {};
  bool _errorAccount = false;
  String _errorMessageAccount = '';

  Map<String, dynamic> get mapAccount => _mapAccount;

  bool get errorAccount => _errorAccount;

  String get errorMessageAccount => _errorMessageAccount;

  Future<void> fetchAccount(String id) async {
    final response = await http.get(
      Uri.parse(
          'https://teamworkpk.com/API/account.php?public_user_id=$id&selected=ads'),
    );
    // print('https://teamworkpk.com/API/account.php?public_user_id=' +
    //     id +
    //     '&selected=ads');
    if (response.statusCode == 200) {
      try {
        _mapAccount = jsonDecode(response.body);
        _errorAccount = false;
      } catch (e) {
        _errorAccount = true;
        _errorMessageAccount = e.toString();
        _mapAccount = {};
      }
    } else {
      _errorAccount = true;
      _errorMessageAccount = 'Error : It could be your Internet connection.';
      _mapAccount = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapListing = {};
  bool _errorListing = false;
  String _errorMessageListing = '';

  Map<String, dynamic> get mapListing => _mapListing;

  bool get errorListing => _errorListing;

  String get errorMessageListing => _errorMessageListing;

  Future<void> get fetchListing async {
    final response = await http.get(
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
    final response = await http.get(
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

    _mapAccount = {};
    _errorAccount = false;
    _errorMessageAccount = '';

    _mapLogin = {};
    _errorLogin = false;
    _errorMessageLogin = '';

    _mapRegister = {};
    _errorRegister = false;
    _errorMessageRegister = '';

    _mapAddProperty = {};
    _errorAddProperty = false;
    _errorMessageAddProperty = '';

    notifyListeners();
  }
}
