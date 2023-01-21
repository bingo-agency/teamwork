import 'package:flutter/material.dart';
import 'package:team_work/AppState/models/listingModel.dart';
import 'package:team_work/AppState/models/searchModel.dart';
import 'package:team_work/AppState/services/searchServices.dart';

class SearchProvider extends ChangeNotifier {
  final _service = SearchServices();
  bool isLoading = false;
  List<SearchModel> _searchList = [];
  List<SearchModel> get searchList => _searchList;

  Future<void> search(curl) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.search(curl);

    _searchList = response;
    isLoading = false;
    notifyListeners();
  }
}
