import 'dart:convert';

import 'package:covid_tracker_app/Services/Utilities/app_url.dart';
import 'package:covid_tracker_app/world_states.dart';
import 'package:http/http.dart' as http;

import '../Model/WorldStateModel.dart';

class StatesServices {
  Future<WorldStateModel> fetchWorldStateRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
