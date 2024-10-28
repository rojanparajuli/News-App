import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/constant/api.dart';
import 'package:news/model/top_stories/top_stories_data.dart';

class NewsDataService {
  final String baseUrl = "${HackerApi.baseUrl}v0/newstories.json?print=pretty";
  final String baseUrl1 = "${HackerApi.baseUrl}v0/item/";

  Future<List<int>> fetchLatestNews() async {
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

  Future<TopStoriesData> fetchItemData(int id) async {
   final response = await http.get(Uri.parse('$baseUrl1$id.json'));
   print("Responseeeeeeeeeeeeeeeeeeeeeee${response.body}");
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return TopStoriesData.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load latest news');
    }
  }
}
