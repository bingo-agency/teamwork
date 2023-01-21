import 'package:flutter/material.dart';
import 'package:team_work/AppState/models/featuredModel.dart';
import 'package:team_work/AppState/models/listingModel.dart';
import 'package:team_work/AppState/services/featuredServices.dart';
import 'package:team_work/AppState/services/listingServices.dart';

class ListingProvider extends ChangeNotifier {
  final _service = ListingServices();
  bool isLoading = false;
  List<ListingModel> _listing = [];
  List<ListingModel> get listing => _listing;

  Future<void> getAllListing() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAllListing();

    _listing = response;
    isLoading = false;
    notifyListeners();
  }
}
