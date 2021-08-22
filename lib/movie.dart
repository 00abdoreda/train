class Movie{

  String? title;
  num ? vote_average;
  String? poster_path;
  String ? overview;
  int ? vote_count;

  Movie.frommap(Map<String,dynamic>map){
    this.title=map["title"];
    this.vote_average=map["vote_average"];
    this.poster_path= "https://image.tmdb.org/t/p/original/${map["poster_path"]}";
    this.overview=map["overview"];
    this.vote_count=map["vote_count"];

  }

}