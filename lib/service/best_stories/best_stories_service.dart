import 'dart:convert';

import 'package:news/constant/api.dart';
import 'package:http/http.dart' as http;
import 'package:news/model/best_stories/best_stories_model.dart';

class BestStoriesService {
  final String baseUrl = "${HackerApi.baseUrl}v0/beststories.json?print=pretty";
  final String baseUrl1 = "${HackerApi.baseUrl}v0/item/";

  Future<List<int>> fetchbeststories() async {
    final response = await http.get(Uri.parse(baseUrl));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      List<int> newsItems = jsonData.map((item) {
        if (item is int) {
          return item;
        } else {
          throw Exception('Expected an int but got ${item.runtimeType}');
        }
      }).toList();

      return newsItems;
    } else {
      throw Exception('Failed to load latest news');
    }
  }

  Future<BestStories> fetchItemData(int id) async {
    final response = await http.get(Uri.parse('$baseUrl1$id.json'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BestStories.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load latest news');
    }
  }
}
