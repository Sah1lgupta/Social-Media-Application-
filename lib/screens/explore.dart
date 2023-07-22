

import 'package:flutter/material.dart';
import 'package:testing2/screens/news_list.dart';
import 'package:testing2/screens/songs_list.dart';

class Explore extends StatefulWidget {

  const Explore({Key? key, required this.name, required this.value,  required this.imageUrl, required this.gradientColors,required this.imageIcon  }) : super(key: key);

  final name;
  final  value;
  final imageUrl;
  final gradientColors;
  final imageIcon;

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {  if(widget.value ==1  ) {Navigator.push(context, MaterialPageRoute(builder: (_) => NewsList()));}

        else if( widget.value ==2   )  { Navigator.push(context, MaterialPageRoute(builder: (_) => SongListScreen())); }
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "${widget.name}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),

              Center(child: Image.asset('${widget.imageIcon}',width: 100,height: 100,)),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    SizedBox(width: 8.0),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
