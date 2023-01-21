import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:team_work/AppState/models/projectModel.dart';

class ProjectServices {
  Future<List<ProjectModel>> getAllProjects() async {
    const url = 'https://teamworkpk.com/API/projects';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final rsbody = jsonDecode(response.body);
      final json = rsbody['projects'] as List;
      // print(json.toString() + ' Coming from todo services.');
      final projects = json.map((e) {
        return ProjectModel(
            id: e['id'],
            title: e['title'],
            ribbon: e['ribbon'],
            description: e['description'],
            price: e['price'],
            address: e['address'],
            city: e['city'],
            views: e['views'],
            type: e['type'],
            year_build: e['year_build'],
            image_link: e['image_link'],
            video_link: e['video_link'],
            timestamp: e['timestamp']);
      }).toList();
      return projects;
    }
    return [];
    // throw "Something went wrong";
  }
}
