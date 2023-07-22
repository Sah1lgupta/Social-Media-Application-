
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:testing2/api/news_api_service.dart';
import 'package:testing2/widgets/news_card.dart';

import '../models/news_model.dart';






class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {



  List<Articles>? articles=null;


  NewsApiService newsApiService= NewsApiService();


  @override
  void setState(VoidCallback fn) {
   articles;
    super.setState(fn);
  }



  Future _fetchNews() async {
    try {
      final  List<Articles> newsList = await newsApiService.fetchNews();
      setState(() {


      });
    } catch (e) {
      setState(() {

      });
      print('Error: $e');
    }
  }



  @override
  void initState() {


    _fetchNews();
    log('$_fetchNews()');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: newsApiService.fetchNews(),builder: (BuildContext context, AsyncSnapshot<List<Articles>> snapshot){


      if(snapshot.hasData){

        articles = snapshot.data;


        return  ListView.builder(
          itemCount: articles!.length,
          itemBuilder: (context, index) => customListTile(articles![index]),


        );
      }
      return Center(child: CircularProgressIndicator(),);
    },);

      /***
      loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return ListTile(
          leading: Image.network(news.imageUrl),
          title: Text(news.title),
          subtitle: Text(news.description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailScreen(url: news.status),
              ),
            );
          },
        );
      },

    );

    ***/
  }
}
