
import 'package:news_app/Models/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/Service/news_service.dart';



final newsProvider = FutureProvider.family((ref, String query) => NewsService.getNews(query: query));

final searchProvider = StateNotifierProvider< SearchNewsProvider, List<News>>((ref) => SearchNewsProvider());

class SearchNewsProvider extends StateNotifier<List<News>>{
  SearchNewsProvider() : super([]){
    getNews();
  }

  Future<void> getNews() async{
    final response = await NewsService.getDefaultNews();
    state = response;
  }

  Future<void> searchNews(String query) async{
    state = [];
    final response = await NewsService.getNews(query: query);
    state = response;
  }

}