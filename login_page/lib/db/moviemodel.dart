

class MovieModel {
  static String table = 'products';

  int id;
  String movieName;
  String directorName;
  String posterPic;
  String date;

  MovieModel({
    required this.id,
    required this.movieName,
    required this.directorName,
    required this.posterPic,
    required this.date
  });

  static MovieModel fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map["id"],
      movieName: map['movieName'].toString(),
      directorName: map['directorName'],
      posterPic: map['posterPic'],
      date: map['date']
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'movieName': movieName,
      'directorName': directorName,
      'posterPic': posterPic,
      'date': date
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

// abstract class Model {
//   late int id;
//
//   static fromMap() {}
//   toMap() {}
//
// // Map<String, dynamic> toJson();
// }