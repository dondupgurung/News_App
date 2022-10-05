import 'package:dio/dio.dart';
import 'package:news_app/Api/api.dart';
import 'package:news_app/Models/news.dart';

class NewsService {


  static Future<List<News>> getNews({required String query}) async {
    final dio = Dio();
    try {
      final response = await dio.get(Api.baseUrl, queryParameters: {
        'q': query,
        'lang': 'en'
      }, options: Options(
          headers: {
            'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
            'X-RapidAPI-Key': '69c542821fmshde1e6bbc819f88ap188c23jsn859bff01f243',

          }
      ));
      if(response.data['status'] == 'No matches for your search.'){
        return [News(
            title: 'No matches for your search.',
            author: '',
            published_date: '',
            link: '',
            summary: '',
            media: '')];
      }else {
        final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
        return data;
      }


    }
    on DioError catch (e) {
      print(e.message);
      return [];
    }
  }

  static Future<List<News>> getDefaultNews() async {
    final dio = Dio();
    try {
      await Future.delayed(Duration(seconds: 6));
      final response = await dio.get(Api.baseUrl, queryParameters: {
        'q': 'politics',
        'lang': 'en'
      }, options: Options(
          headers: {
            'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
            'X-RapidAPI-Key': '69c542821fmshde1e6bbc819f88ap188c23jsn859bff01f243',

          }
      ));

      final data = (response.data['articles'] as List).map((e) =>
          News.fromJson(e)).toList();
      return data;
    }
    on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }


}
