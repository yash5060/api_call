import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_x_elon_musk/models/launch.dart';
class API{
  static Future<List<Launch>> getAll() async {
    Uri url = Uri.parse('https://api.spacexdata.com/v3/launches/past');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print('working');
      List<dynamic> json = jsonDecode(response.body);
      print(json.length);
      List<Launch> ans=[];
      for(int i=0;i<json.length;i++)
        {
          ans.add(Launch.fromJson(json, i));
        }
      return ans;
    }
    else {
      print('not working');
      List<Launch> ret=[];
      return ret;
    }
  }
}
