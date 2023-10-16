import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/news.dart';

class WebService{

  Future<List<News>> getNews(String comapny, String fromDate) async{
    var response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=$comapny&from=$fromDate&sortBy=publishedAt&apiKey=7cbef3e0859e47bea7efc555e5a5b35e'),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    if(response.statusCode >= 200 && response.statusCode < 300){
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      List<News> news = [];
      for(var article in data['articles']){
        news.add(News.fromJson(article));
      }
      return news;
    }
    else{
      print("I get error: ${response.statusCode}");
      return []; 
    }
  }

  Future<List<News>> getNewsWithDio() async{
    Dio dio = Dio();
    Response r = await dio.get(
      'https://newsapi.org/v2/everything?q=tesla&from=2023-09-14&sortBy=publishedAt&apiKey=7cbef3e0859e47bea7efc555e5a5b35e',
      options: Options(
        headers: {
          "Authorization": "Bearer "
        }
      )
    );
    if(r.statusCode! >= 200 && r.statusCode! < 300){
      List<News> news = [];
      print(r.data);
      for(var article in r.data['articles']){
        news.add(News.fromJson(article));
      }
      return news;
    }
    else{
      print("I get error: ${r.statusCode}");
      return [];
    }
  }
}