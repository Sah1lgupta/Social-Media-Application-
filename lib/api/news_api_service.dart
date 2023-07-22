
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:testing2/models/news_model.dart';

class NewsApiService {
   String apiKey = '1f565290b2fb45688ebf15a418cd1813';
   String baseUrl = 'https://newsapi.org/v2';
   String endPoint= "https://newsapi.org/v2/top-headlines?country=us&apiKey=1f565290b2fb45688ebf15a418cd1813";

    Future<List<Articles>> fetchNews() async {
  //  final response = await http.get(Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'));
     final response = await http.get(Uri.parse(endPoint));
     List<Articles>? articles=null;


     if(response.statusCode ==200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> body= jsonData['articles'];


       articles= body.map((dynamic item) => Articles.fromJson(item)).toList();
        return articles;

     }
     else{
       throw("can't get articles");
     }
  }

}