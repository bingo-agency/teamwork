import 'package:flutter/material.dart';
import 'package:team_work/AppState/models/projectModel.dart';
import '../services/projectServices.dart';

class ProjectProvider extends ChangeNotifier {
  final _service = ProjectServices();
  bool isLoading = false;
  List<ProjectModel> _projects = [];
  List<ProjectModel> get projects => _projects;

  Future<void> getAllProjects() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAllProjects();

    _projects = response;
    isLoading = false;
    notifyListeners();
  }
}
