import 'package:flutter/material.dart';
import 'package:team_work/AppState/models/homeListingModel.dart';
import 'package:team_work/AppState/services/homeListingServices.dart';

class HomeListingProvider extends ChangeNotifier {
  final _service = HomeListingServices();
  bool isLoading = false;
  List<HomeListingModel> _homeListing = [];
  List<HomeListingModel> get homeListing => _homeListing;

  Future<void> getHomeListing() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getHomeListing();

    _homeListing = response;
    isLoading = false;
    notifyListeners();
  }
}
