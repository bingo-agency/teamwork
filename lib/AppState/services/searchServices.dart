import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:team_work/AppState/models/searchModel.dart';

class SearchServices {
  Future<List<SearchModel>> search(String curl) async {
    final url = 'https://teamworkpk.com/API/nonfeatured' + curl;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final rsbody = jsonDecode(response.body);
      final json = rsbody['nonfeatured'] as List;
      // print(json.toString() + ' Coming from todo services.');
      final searchList = json.map((e) {
        return SearchModel(
          id: e['id'],
          internal_lead_id: e['internal_lead_id'],
          title: e['title'],
          description: e['description'],
          price: e['price'],
          address: e['address'],
          city: e['city'],
          views: e['views'],
          type: e['type'],
          property_type: e['property_type'],
          purpose: e['purpose'],
          land_area: e['land_area'],
          year_build: e['year_build'],
          primary_image: e['primary_image'],
          property_images: e['property_images'],
          floor_plans: e['floor_plans'],
          public_user_id: e['public_user_id'],
          comments: e['comments'],
          video_link: e['video_link'],
          verification_status: e['verification_status'],
          featured: e['featured'],
          timestamp: e['timestamp'],
          msg: e['msg'],
        );
      }).toList();
      return searchList;
    }
    return [];
    // throw "Something went wrong";
  }
}
