import 'package:flutter/material.dart';

import '../models/news_model.dart';


  Widget customListTile(Articles? articles) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin:EdgeInsets.all(12),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                  )
                ]
              ),

              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child:  articles!.description != null ?   Text('${articles.title}',style: TextStyle(fontWeight: FontWeight.bold),) :  Text('no result',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  SizedBox(height: 8,),




                  Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:   articles.urlToImage != null ? NetworkImage(articles.urlToImage!) :NetworkImage("https://sportshub.cbsistatic.com/i/r/2023/07/01/45052925-70b0-4b1d-889a-df7138169701/thumbnail/1200x675/68e11a6aa992b6b36662b022e4069e68/gettyimages-15065083011.jpg"),
                      )
                    ),
                  ),

                  SizedBox(height: 8,),

                  Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child:  articles.description != null ?   Text('${articles.description}',style: TextStyle(fontWeight: FontWeight.normal),) :  Text('no result',style: TextStyle(fontWeight: FontWeight.normal),),
                  ),

                  SizedBox(height: 8,),



                ],
              ),),

            ],
          ),
        ),

      ),
    );
  }
