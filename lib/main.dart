import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'movie.dart';
void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: screen(),
    );
  }
}

class screen extends StatefulWidget {

  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {
List<Movie> movies=[];
  initState(){
    getmovies();
    super.initState();
  }


  getmovies() async{
   var response = await Dio().get("https://api.themoviedb.org/3/movie/popular",queryParameters:{"api_key":"f55fbda0cb73b855629e676e54ab6d8e"} );
   for(int i=0;i<(response.data["results"] as List).length;i++){
     Movie movie = new Movie.frommap(response.data["results"][i]);
     movies.add(movie);

   }


   setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.blueGrey[900] ,
        centerTitle: true,
        title: Text("MovieHunt",style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),

          Container(

            height: 310,
            color: Colors.blueGrey[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("  Now Playing",style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white,fontSize: 22),),
                    Spacer(),
                    Text("View All  ",style: TextStyle(fontWeight: FontWeight.bold , color: Colors.blue,fontSize: 12),),


                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 250,
                  color: Colors.transparent,
                  margin: EdgeInsets.all(8),
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: movies.length,

                      itemBuilder: (_,i){
                        Movie movie = movies[i];
                        return Container(
                          height: 200,
                          color: Colors.transparent,
                          margin: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(movie.poster_path.toString(),
                                    fit: BoxFit.cover,

                                  ),
                                ),
                              ),
                              Expanded(child:Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                        RatingBar.builder(
                        initialRating:(movie.vote_average!/2.0),
                        itemSize: 20,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                        print(rating);
                        },
                        ),
                                  ],
                                ),


                              ),

                              )
                            ],

                          ),


                        );



                      },


                  ),

                ),



              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.all(8),
            height: 310,
            color: Colors.blueGrey[900],
          ),


        ],

      ),

    );
  }
}




