import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:team_work/AppState/models/featuredModel.dart';

class FeaturedServices {
  Future<List<FeaturedModel>> getAllFeatured() async {
    const url = 'https://teamworkpk.com/API/featured';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final rsbody = jsonDecode(response.body);
      final json = rsbody['featured'] as List;
      // print(json.toString() + ' Coming from todo services.');
      final featured = json.map((e) {
        return FeaturedModel(
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
          floor_plans: e['floor_plans'],
          public_user_id: e['public_user_id'],
          comments: e['comments'],
          video_link: e['video_link'],
          verification_status: e['verification_status'],
          featured: e['featured'],
          timestamp: e['timestamp'],
        );
      }).toList();
      return featured;
    }
    return [];
    // throw "Something went wrong";
  }
}
