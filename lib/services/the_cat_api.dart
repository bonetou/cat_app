import 'package:http/http.dart';
import 'dart:convert';

Future<List<dynamic>> getData() async {
  final url = 'https://api.thecatapi.com/v1/breeds?limit=5';
  final apikey = '084ba1e9-75a2-47d1-9bc0-4a773f8e18dc';
  Response response = await get(url, headers: {'x-api-key': apikey});
  return json.decode(response.body);
}

Future<String> getImage(String id) async {
  print('iddddd');
  print(id);
  final url = 'https://api.thecatapi.com/v1/images/search?limit=1&breed_id=$id';
  final apikey = '084ba1e9-75a2-47d1-9bc0-4a773f8e18dc';
  Response response = await get(url, headers: {'x-api-key': apikey});
  return json.decode(response.body)[0]['url'];
}
