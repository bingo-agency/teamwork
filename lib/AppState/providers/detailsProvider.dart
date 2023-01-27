import 'package:flutter/material.dart';
import 'package:team_work/AppState/models/detailsModel.dart';
import 'package:team_work/AppState/services/detailsServices.dart';

class DetailsProvider extends ChangeNotifier {
  final _service = DetailsServices();
  bool isLoading = false;
  List<DetailsModel> _details = [];
  List<DetailsModel> get details => _details;

  Future<void> getDetails(id) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getDetails(id);

    _details = response;
    isLoading = false;
    notifyListeners();
  }
}
