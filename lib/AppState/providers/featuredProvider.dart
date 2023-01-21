import 'package:flutter/material.dart';
import 'package:team_work/AppState/models/featuredModel.dart';
import 'package:team_work/AppState/services/featuredServices.dart';

class FeaturedProvider extends ChangeNotifier {
  final _service = FeaturedServices();
  bool isLoading = false;
  List<FeaturedModel> _featured = [];
  List<FeaturedModel> get featured => _featured;

  Future<void> getAllFeatured() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAllFeatured();

    _featured = response;
    isLoading = false;
    notifyListeners();
  }
}
