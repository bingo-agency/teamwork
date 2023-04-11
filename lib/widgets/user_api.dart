import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String name;

  const User({
    required this.name,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
      );
}

class UserApi {
  static Future<List<User>> getUserSuggestions(String query) async {
    final url = Uri.parse('https://mrworker.pk/API/tags');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => User.fromJson(json)).where((user) {
        final nameLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

class City {
  final String name;

  const City({
    required this.name,
  });

  static City fromJson(Map<String, dynamic> json) => City(
        name: json['name'],
      );
}

class UserApi1 {
  static Future<List<City>> getCitySuggestions(String query) async {
    final url = Uri.parse(
        'https://gist.githubusercontent.com/immujahidkhan/014fb1629ddc931e6f6d4a3a4d31abaa/raw/8f5cc4f88b9dc4efc5058c5354b9f955e4bda16f/cities.json');
    // final url = Uri.parse('https://mrworker.pk/API/categories.php');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // final jsonResponse = json.decode(response.body);

      final List cities = jsonDecode(response.body);

      return cities.map((json) => City.fromJson(json)).where((cities) {
        final nameLower = cities.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

class Category {
  final String name;

  const Category({
    required this.name,
  });

  static Category fromJson(Map<String, dynamic> json) => Category(
        name: json['name'],
      );
}

class UserApi2 {
  static Future<List<Category>> getCategorySuggestions(String query) async {
    final url = Uri.parse('https://mrworker.pk/API/categories');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final List category = jsonResponse['categories'] as List;

      return category.map((json) => Category.fromJson(json)).where((category) {
        final nameLower = category.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
