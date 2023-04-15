import 'package:flutter/material.dart';
import 'package:team_work/AppState/models/listingModel.dart';
import 'package:team_work/AppState/services/listingServices.dart';

class ListingProvider extends ChangeNotifier {
  final _service = ListingServices();
  bool isLoading = false;
  List<ListingModel> _listing = [];
  List<ListingModel> get listing => _listing;

  Future<void> getAllListing(curl) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAllListing(curl);

    _listing = response;
    isLoading = false;
    notifyListeners();
  }
}
