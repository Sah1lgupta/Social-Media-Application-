
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testing2/models/posts.dart';

import '../main.dart';

class PostCard extends StatefulWidget {


  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  final _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.post.profileImage),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.post.name}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Image.network(widget.post.post),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_upward)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_downward)),
                      IconButton(onPressed: (){ _showBottomSheetForComments(context);}, icon: Icon(Icons.comment)),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(onPressed: (){ _showBottomSheetForShare(context);}, icon: Icon(Icons.share)),

                    ],),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget? _showBottomSheetForComments(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
        context: context,
        builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('no comments found!'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
          children: [

          Padding(
          padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
          child: Row(
          children: [
          //input field & buttons
          Expanded(
          child: Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
          child: Row(
          children: [
          //emoji button


          Expanded(
          child: TextField(

          controller: _textController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onTap: () {

          },
          decoration: const InputDecoration(
          hintText: 'Type Something...',
          hintStyle: TextStyle(color: Colors.blueAccent),
          border: InputBorder.none),
          )),




          //adding some space
          SizedBox(width: mq.width * .02),
          ],
          ),
          ),
          ),

          //send message button
          MaterialButton(
          onPressed: () {
          if (_textController.text.isNotEmpty) {

          //simply post comment


          _textController.text = '';
          }
          },
          minWidth: 0,
          padding:
          const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
          shape: const CircleBorder(),
          color: Colors.green,
          child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
          ],
          ),
          ),



            SizedBox(height: 10,)

          ],
          ),


        ],
      );
    }
    );
  }


  Widget? _showBottomSheetForShare(BuildContext context) {
    showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('no user found!'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Text(' '),
                  SizedBox(height: 10,)
                ],
              ),

            ],
          );
        }
    );
  }

  }

