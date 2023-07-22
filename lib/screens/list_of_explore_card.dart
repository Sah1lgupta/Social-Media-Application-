import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:testing2/api/apis.dart';
import 'package:testing2/models/posts.dart';
import 'package:testing2/screens/explore.dart';
import 'package:testing2/widgets/post_card.dart';

import '../main.dart';

class ExploreList extends StatefulWidget {
  const ExploreList({Key? key}) : super(key: key);

  @override
  State<ExploreList> createState() => _ExploreListState();
}

class _ExploreListState extends State<ExploreList> {



  final List<Map<String, dynamic>> cardData = [
    {
      'name': 'news',
      'value': 1,
      'imageUrl': 'https://example.com/profile1.jpg',
      'gradientColors': [Colors.blue, Colors.teal],
      'imageIcon': 'assets/images/news.png'

    },
    {
      'name': 'songs',
      'value': 2,
      'imageUrl': 'https://example.com/profile2.jpg',
      'gradientColors': [Colors.pink, Colors.deepPurple],
      'imageIcon': 'assets/images/songs.png'
    },
    // Add more card data as needed
  ];


  @override
  void setState(VoidCallback fn) {
    cardData;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as desired
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: cardData.length,
      itemBuilder: (context, index) {
        final card = cardData[index];
        return Explore(
          name: card['name']!,
          value: card['value']!,
          imageUrl: card['imageUrl']!,
          gradientColors: card['gradientColors']!,
          imageIcon: card['imageIcon'],
        );
      },
    );
  }
}
