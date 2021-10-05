import 'databsehelper.dart';
import 'dbmodel.dart';

class DBService {
  Future<bool> addProduct(MovieModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.insert(MovieModel.table, model);

      isSaved = inserted == 1 ? true : false;
    }

    return isSaved;
  }

  Future<bool> updateProduct(MovieModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.update(MovieModel.table, model);

      isSaved = inserted == 1 ? true : false;
    }

    return isSaved;
  }

  Future<List<MovieModel>> getProducts() async {
    await DB.init();
    List<Map<String, dynamic>> products = await DB.query(MovieModel.table);

    return products.map((item) => MovieModel.fromMap(item)).toList();
  }



  Future<bool> deleteProduct(MovieModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int deleted = await DB.delete(MovieModel.table, model);

      isSaved = deleted == 1 ? true : false;
    }

    return isSaved;
  }
}
