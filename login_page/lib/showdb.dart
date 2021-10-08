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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Show Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _fetchData(),
          ],
        ),
      ),
    );
  }

  Widget _fetchData() {
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

  Widget _buildUI(List<MovieModel>? data) {
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
            color: Colors.red,
            child: Center(
              child: Text(
                "Add Product",
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
        children: [_buildDataTable(data)],
      ),
    );

    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
      padding: EdgeInsets.all(10),
    );
  }

  _buildDataTable(List<MovieModel>? model) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            "Product Name",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Price",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Action",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      sortColumnIndex: 1,
      rows: model!
          .map(
            (data) => DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    data.movieName,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                DataCell(
                  Text(
                    data.directorName,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DbAddMovie(
                                  model: data,
                                ),
                              ),
                            );
                          },
                        ),
                        new IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            dbService.deleteProduct(data).then((value) {
                              setState(() {
                                Navigator.of(context);
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
