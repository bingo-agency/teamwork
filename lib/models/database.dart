import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import '../pages/home/home.dart';

class DataBase with ChangeNotifier {
  //add new property image picker

  List<XFile> image_Files = [];
  List<File> get imageFiles =>
      image_Files.map((file) => File(file.path)).toList();

  final picker = ImagePicker();

  Future<void> selectImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 50,
    );

    if (pickedFiles.isNotEmpty) {
      image_Files.addAll(pickedFiles);
      for (var i = 0; i < image_Files.length; i++) {
        print(image_Files[i]);
        print(i.toString());
      }
      notifyListeners();
    }
  }

  Future<void> removeImage(int index) async {
    final file = File(image_Files[index].path);
    await file.delete();
    image_Files.removeAt(index);
    notifyListeners();
  }

  //ends

  void pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    propertyImages.add(File(pickedFile!.path));
    notifyListeners();
    // setState(() {
    // _propertyImages.add(File(pickedFile.path));
    // });
  }

  //shared prefs start

  String initial_city = 'Select City';
  bool postedAd = false;

  //Add property images starts

  List<File> propertyImages = [];

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

  var formattedAddress = '';
  Future<void> getCityLocation() async {
    var gottenAddress = _mapLocation['results'][0]['formatted_address'];
    var gottenCity = _mapLocation['results'][0]['address_components'][5]
            ['long_name']
        .toString();
    initial_city = gottenCity;
    formattedAddress = gottenAddress;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('initial_city', gottenCity);
    initial_city = prefs.getString('initial_city') ?? '';
    // print('printing city name$initial_city');
    // SetCityForSearchbar(Cityname.toString());
    adLocation = formattedAddress;
    // if(adLocation==""){

    // }

    notifyListeners();
  }

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  Future<void> loadAssets() async {
    // List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {} on Exception catch (e) {
      error = e.toString();
    }

    error = error;

    notifyListeners();
  }

  Future getSpinnerValue() async {
    var spinVal = showSpinner;
    return spinVal;
  }

  // Dio dio = Dio();

  String post_id = '0';
  List<dynamic> finalResImages = [];

  Future<void> setPostId(id) async {
    id = post_id;
    notifyListeners();
  }

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

  // Future<void> setType(value) async {
  //   typeIndex = value;
  //   notifyListeners();
  // }

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

  // new one june 2023
  // addProperty
  // addNewProperty

  String adPurpose = 'Exchange';
  String adPropertyType = 'House';
  String adType = 'Residential';
  String adLocation = "";
  String adCity = 'Islamabad';
  String adPrice = '';
  String adArea = '';
  String adVideoLink = 'http://';
  String adTitle = '';
  String adDescription = '';
  String adInternalId = '';

  String selectedAdCity = 'Islamabad';
  List<String> adCityOptions = [
    "Islamabad",
    "Lahore",
    "Rawalpindi",
    "Karachi",
    "Abbottabad",
    "Murree",
    "Ahmed Nager Chatha",
    "Ahmadpur East",
    "Ali Khan Abad",
    "Alipur",
    "Arifwala",
    "Attock",
    "Bhera",
    "Bhalwal",
    "Bahawalnagar",
    "Bahawalpur",
    "Bhakkar",
    "Burewala",
    "Chillianwala",
    "Chakwal",
    "Chichawatni",
    "Chiniot",
    "Chishtian",
    "Daska",
    "Darya Khan",
    "Dera Ghazi Khan",
    "Dhaular",
    "Dina",
    "Dinga",
    "Dipalpur",
    "Faisalabad",
    "Ferozewala",
    "Fateh Jhang",
    "Ghakhar Mandi",
    "Gojra",
    "Gujranwala",
    "Gujrat",
    "Gujar Khan",
    "Hafizabad",
    "Haroonabad",
    "Hasilpur",
    "Haveli Lakha",
    "Jatoi",
    "Jalalpur",
    "Jattan",
    "Jampur",
    "Jaranwala",
    "Jhang",
    "Jhelum",
    "Kalabagh",
    "Karor Lal Esan",
    "Kasur",
    "Kamalia",
    "Kamoke",
    "Khanewal",
    "Khanpur",
    "Kharian",
    "Khushab",
    "Kot Addu",
    "Jauharabad",
    "Lalamusa",
    "Layyah",
    "Liaquat Pur",
    "Lodhran",
    "Malakwal",
    "Mamoori",
    "Mailsi",
    "Mandi Bahauddin",
    "Mian Channu",
    "Mianwali",
    "Multan",
    "Muridke",
    "Mianwali Bangla",
    "Muzaffargarh",
    "Narowal",
    "Nankana Sahib",
    "Okara",
    "Renala Khurd",
    "Pakpattan",
    "Pattoki",
    "Pir Mahal",
    "Qaimpur",
    "Qila Didar Singh",
    "Rabwah",
    "Raiwind",
    "Rajanpur",
    "Rahim Yar Khan",
    "Sadiqabad",
    "Safdarabad",
    "Sahiwal",
    "Sangla Hill",
    "Sarai Alamgir",
    "Sargodha",
    "Shakargarh",
    "Sheikhupura",
    "Sialkot",
    "Sohawa",
    "Soianwala",
    "Siranwali",
    "Talagang",
    "Taxila",
    "Toba Tek Singh",
    "Vehari",
    "Wah Cantonment",
    "Wazirabad",
    "Badin",
    "Bhirkan",
    "Rajo Khanani",
    "Chak",
    "Dadu",
    "Digri",
    "Diplo",
    "Dokri",
    "Ghotki",
    "Haala",
    "Hyderabad",
    "Islamkot",
    "Jacobabad",
    "Jamshoro",
    "Jungshahi",
    "Kandhkot",
    "Kandiaro",
    "Kashmore",
    "Keti Bandar",
    "Khairpur",
    "Kotri",
    "Larkana",
    "Matiari",
    "Mehar",
    "Mirpur Khas",
    "Mithani",
    "Mithi",
    "Mehrabpur",
    "Moro",
    "Nagarparkar",
    "Naudero",
    "Naushahro Feroze",
    "Naushara",
    "Nawabshah",
    "Nazimabad",
    "Qambar",
    "Qasimabad",
    "Ranipur",
    "Ratodero",
    "Rohri",
    "Sakrand",
    "Sanghar",
    "Shahbandar",
    "Shahdadkot",
    "Shahdadpur",
    "Shahpur Chakar",
    "Shikarpaur",
    "Sukkur",
    "Tangwani",
    "Tando Adam Khan",
    "Tando Allahyar",
    "Tando Muhammad Khan",
    "Thatta",
    "Umerkot",
    "Warah",
    "Adezai",
    "Alpuri",
    "Akora Khattak",
    "Ayubia",
    "Banda Daud Shah",
    "Bannu",
    "Batkhela",
    "Battagram",
    "Birote",
    "Chakdara",
    "Charsadda",
    "Chitral",
    "Daggar",
    "Dargai",
    "Darya Khan",
    "Dera Ismail Khan",
    "Doaba",
    "Dir",
    "Drosh",
    "Hangu",
    "Haripur",
    "Karak",
    "Kohat",
    "Kulachi",
    "Lakki Marwat",
    "Latamber",
    "Madyan",
    "Mansehra",
    "Mardan",
    "Mastuj",
    "Mingora",
    "Nowshera",
    "Paharpur",
    "Pabbi",
    "Peshawar",
    "Saidu Sharif",
    "Shorkot",
    "Shewa Adda",
    "Swabi",
    "Swat",
    "Tangi",
    "Tank",
    "Thall",
    "Timergara",
    "Tordher",
    "Awaran",
    "Barkhan",
    "Chagai",
    "Dera Bugti",
    "Gwadar",
    "Harnai",
    "Jafarabad",
    "Jhal Magsi",
    "Kacchi",
    "Kalat",
    "Kech",
    "Kharan",
    "Khuzdar",
    "Killa Abdullah",
    "Killa Saifullah",
    "Kohlu",
    "Lasbela",
    "Lehri",
    "Loralai",
    "Mastung",
    "Musakhel",
    "Nasirabad",
    "Nushki",
    "Panjgur",
    "Pishin Valley",
    "Quetta",
    "Sherani",
    "Sibi",
    "Sohbatpur",
    "Washuk",
    "Zhob",
    "Ziarat",
  ];
  String finalAdCity = '';

  void setAdCity(newAdCity) {
    finalAdCity = newAdCity;
    notifyListeners();
  }

  String selectedSearchType = 'Any';
  List<String> typeSearchOptions = [
    'Any',
    'House',
    'Studio',
    'Apartment',
    'Plot',
    'Shop',
    'Restaurant',
    'Building',
    'Land',
    'Vehicle',
    'Other'
  ];
  String finalSearchType = '';

  void setSearchType(newSearchType) {
    finalSearchType = newSearchType;
    notifyListeners();
  }

  String selectedType = 'House';
  List<String> typeOptions = [
    'House',
    'Studio',
    'Apartment',
    'Plot',
    'Shop',
    'Restaurant',
    'Building',
    'Land',
    'Vehicle',
    'Other'
  ];
  String finalType = '';

  void setType(newType) {
    finalType = newType;
    notifyListeners();
  }

  String selectedUnit = 'Marla';
  List<String> unitOptions = ['Marla', 'Sqft'];
  String finalUnit = '';

  void setUnit(newUnit) {
    finalUnit = newUnit;
    notifyListeners();
  }

  String uploadStatus = 'Posting...';
  bool uploadValue = false;
  Future<void> addNewProperty(
      BuildContext context,
      internalId,
      type,
      purpose,
      city,
      location,
      area,
      price,
      title,
      description,
      video_link,
      propertyType) async {
    String uploadStatus = 'Posting...';
    bool uploadValue = false;
    print('adding new property now ! ');
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://teamworkpk.com/API/addNewProperty.php?user_id=' + id));

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization':
          'Bearer <auth-eadgbe11235813>', // Replace with the actual access token
    });
    //for image and videos and files

    for (var i = 0; i < image_Files.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          image_Files[i].name, image_Files[i].path));
      print(image_Files[i].name);
    }

    // Add additional fields to the request
    request.fields['type'] = type;
    request.fields['internal_id'] = internalId;
    request.fields['purpose'] = purpose;
    request.fields['city'] = city;
    request.fields['location'] = location;
    request.fields['area'] = area;
    request.fields['price'] = price;
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['video_link'] = video_link;
    request.fields['property_type'] = propertyType;

    print('type' + type);
    print('internalId = ' + internalId);
    print('purpose' + purpose);
    print('city' + city);
    print('location' + location);
    print('area' + area);
    print('price' + price);
    print('title' + title);
    print('description' + description);
    print('video_link' + video_link);
    print(adType +
        ' - ' +
        adInternalId +
        ' - ' +
        adPurpose +
        ' - ' +
        adCity +
        ' - ' +
        adLocation +
        ' - ' +
        adArea +
        ' - ' +
        adPrice +
        ' - ' +
        adTitle +
        ' - ' +
        adDescription +
        ' - ' +
        adVideoLink);

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);

    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      print("SUCCESS");
      uploadStatus = 'Your ad has been posted.';
      uploadValue = true;
      print(responseData);
    } else {
      print("ERROR");
    }
    notifyListeners();
  }

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

// new login
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void login(context, email, password) async {
    _isLoading = true;
    notifyListeners();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(children: [
          const CircularProgressIndicator(),
          const SizedBox(
            width: 12.0,
          ),
          Text('Loading...', style: GoogleFonts.ubuntu())
        ]),
      ),
    );

    // Call your login API here
    String completeUrl = 'https://teamworkpk.com/API/loginapi';

    final response = await http.post(
      Uri.parse(completeUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['message'] == 'True') {
        id = jsonResponse['user'][0]['id'].toString();
        name = jsonResponse['user'][0]['name'].toString();
        image = jsonResponse['user'][0]['image'].toString();
        phone = jsonResponse['user'][0]['phone'].toString();
        timestamp = jsonResponse['user'][0]['timestamp'].toString();
        addAuth(id, name, email, password, image, phone, timestamp);
        print('its true');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (route) => false);
      } else {
        _isLoading = false;
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'Invald crednetials / Blocked User. Contact Admin Support.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        print('its false');
      }
      print(jsonResponse);

      _isLoading = false;
      notifyListeners();
    }
  }

// new login ends

  // login starts here

  // Map<String, dynamic> _mapLogin = {};
  // bool _errorLogin = false;
  // String _errorMessageLogin = '';

  // Map<String, dynamic> get mapLogin => _mapLogin;

  // bool get errorLogin => _errorLogin;

  // String get errorMessageLogin => _errorMessageLogin;

  // Future<void> userLogin(String email, String password) async {
  //   String completeurl =
  //       'https://teamworkpk.com/API/loginapi.php?email=$email&password=$password';
  //   print(completeurl);
  //   final response = await http.get(
  //     Uri.parse(
  //         'https://teamworkpk.com/API/loginapi.php?email=$email&password=$password'),
  //   );
  //   if (response.statusCode == 200) {
  //     try {
  //       _mapLogin = jsonDecode(response.body);
  //       _errorLogin = false;
  //       if (_mapLogin.isNotEmpty && _mapLogin['message'] == "True") {
  //         print('yes its true from db');
  //         print(_mapLogin['user'][0]['id'].toString());
  //         id = _mapLogin['user'][0]['id'].toString();
  //         name = _mapLogin['user'][0]['name'].toString();
  //         image = _mapLogin['user'][0]['image'].toString();
  //         phone = _mapLogin['user'][0]['phone'].toString();
  //         timestamp = _mapLogin['user'][0]['timestamp'].toString();
  //         addAuth(id, name, email, password, image, phone, timestamp);
  //       }
  //     } catch (e) {
  //       _errorLogin = true;
  //       _errorMessageLogin = e.toString();
  //       _mapLogin = {};
  //     }
  //   } else {
  //     _errorLogin = true;
  //     _errorMessageLogin = 'Error : It could be your Internet connection.';
  //     _mapLogin = {};
  //   }
  //   notifyListeners();
  // }

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

    _mapRegister = {};
    _errorRegister = false;
    _errorMessageRegister = '';

    _mapAddProperty = {};
    _errorAddProperty = false;
    _errorMessageAddProperty = '';

    notifyListeners();
  }
}
