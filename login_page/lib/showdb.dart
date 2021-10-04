import 'package:flutter/material.dart';
import 'package:login_page/db/dbaddmovie.dart';
import 'package:login_page/db/dbmodel.dart';
import 'package:login_page/db/service.dart';


class ShowDataBase extends StatefulWidget {
  const ShowDataBase({Key? key}) : super(key: key);

  @override
  State<ShowDataBase> createState() => _ShowDataBaseState();
}

class _ShowDataBaseState extends State<ShowDataBase> {
  late DBService dbService;
  @override
  void initState() {
    super.initState();
    dbService = new DBService();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          _fetchData(),
        ],
      ),
    );
  }

  _fetchData() {
    return FutureBuilder<List<MovieModel>>(
      future: dbService.getProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<MovieModel>> movieModel) {
        if (movieModel.hasData) {
          return _buildUI(movieModel.data);
        }
        return CircularProgressIndicator();
      },
    );
  }

  _buildUI(List<MovieModel>? data) {
    List<Widget> widgets = <Widget>[];

    widgets.add(
      new Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DbAddMovie(),
              ),
            );
          },
          child: Container(
            height: 40.0,
            width: 100,
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                "Add Movie",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    widgets.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_buildDataTable(data!)],
      ),
    );
  }

  _buildDataTable(List<MovieModel> data) {

    data.map((model) => Text(model.movieName)).toList();

  }
  }

