

class MovieModel extends Model {
  static String table = 'table';

  int? id;
  String movieName;
  String directorName;
  String productPic;
  String? date;

  MovieModel({
    this.id,
    required this.movieName,
    required this.directorName,
    required this.productPic,
     this.date,
  });

  static MovieModel fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      movieName: map['movieName'],
      directorName: map['directorName'],
      productPic: map['productPic'],
      //date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'movieName': movieName,
      'directorName': directorName,
      'productPic': productPic,
     // 'date': date
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

abstract class Model {
  int? id;

  static fromMap() {}
  toMap() {}
// Map<String, dynamic> toJson();
}
