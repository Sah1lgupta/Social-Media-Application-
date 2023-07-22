import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:testing2/api/apis.dart';
import 'package:testing2/models/posts.dart';
import 'package:testing2/widgets/post_card.dart';

import '../main.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Post> _list = [];

  @override
  void initState() {
    log("$_list");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: APIs.getAllPost(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
        //if data is loading
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const SizedBox();

        //if some or all data is loaded then show it
          case ConnectionState.active:
          case ConnectionState.done:
            final data = snapshot.data?.docs;
            _list = data?.map((e) =>    Post.fromJson(e.data())).toList() ?? [];

            if (_list.isNotEmpty) {
              return ListView.builder(
                  itemCount: _list.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PostCard(post: _list[index]);
                  });
            } else {
              return const Center(
                child: Text('no posts found!',
                    style: TextStyle(fontSize: 20)),
              );
            }
        }
      },
    );
  }
}
