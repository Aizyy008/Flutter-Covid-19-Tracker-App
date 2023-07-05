import 'dart:convert';

import 'package:covid_app/Services/Utilities/app_urls.dart';
import "package:http/http.dart" as http;
import 'package:covid_app/Model/world_states_model.dart';

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }
  //use dynamic because i don't want all data just my required entities
  Future<List<dynamic>> CountryStateApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
