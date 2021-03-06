import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/db/dbmodel.dart';
import 'package:login_page/db/service.dart';
import 'package:login_page/db/showdb.dart';

class DbAddMovie extends StatefulWidget {
  DbAddMovie({Key? key, this.modelC, this.isEditMode = false})
      : super(key: key);
  MovieModel? modelC;
  bool? isEditMode;

  @override
  _DbAddMovieState createState() => _DbAddMovieState();
}

class _DbAddMovieState extends State<DbAddMovie> {
  File? image;
  TextEditingController movieNameController = TextEditingController();
  TextEditingController directorNameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  DateTime dateTimeController = DateTime.now();
  final globalFormKey = GlobalKey<FormState>();
  late DBService dbService;
  late MovieModel model;
  late bool isEditModel;
  bool isTextArea = false;

  // Future<PickedFile>? imageFile;
  // ImagePicker _picker = new ImagePicker();
  Future<PickedFile>? _imageFile;
  ImagePicker _picker = new ImagePicker();
  late Future<File>? imageFile;

  // late Image image;

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
    model = new MovieModel(
        movieName: 'movie',
        date: '432',
        directorName: 'Tom',
        productPic: 'image/path');
    if (widget.isEditMode!) {
      model = widget.modelC!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite Example"),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: globalFormKey,
          child: Column(
            children: [
              margin_20,
              Container(
                margin:
                    EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                child: TextFormField(
                  controller: movieNameController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Movie Name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.movie,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (value) => {
                    this.model.movieName = value,
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Movie Name";
                    }
                    return null;
                  },
                ),
              ),
              margin_20,
              Container(
                margin:
                    EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                child: TextFormField(
                  controller: directorNameController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Director Name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (value) => {
                    this.model.directorName = value,
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Director Name";
                    }
                    return null;
                  },
                ),
              ),
              margin_20,
              // ElevatedButton(
              //   child: Text("Choose Image"),
              //   onPressed: () => pickImage(ImageSource.gallery),
              // ),
              // ElevatedButton(
              //   child: Text("Choose Image from Camera"),
              //   onPressed: () => pickImage(ImageSource.gallery),
              // ),
              margin_20,

              // image != null
              //     ? Image.file(
              //         image!,
              //         width: 120,
              //         height: 120,
              //         fit: BoxFit.cover,
              //       )
              //     : FlutterLogo(
              //         size: 120,
              //       ),

              margin_10,
              picPicker(
                model.productPic,
                (file) => {
                  setState(
                    () {
                      model.productPic = file.path;
                    },
                  )
                },
              ),
              margin_20,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                      child: Text("Choose Date"),
                      onPressed: () => selectDate(context),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: Center(
                        child: Text(
                          dateTimeController.day.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: Center(
                        child: Text(
                          dateTimeController.month.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 50,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: Center(
                        child: Text(
                          dateTimeController.year.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              margin_20,
              // ElevatedButton(
              //   child: Text("insert"),
              //   onPressed: () async {
              //     // int insertData = await db.insert({
              //     //   DataBaseHelper.columnMovieName : '13 Reasons Why',
              //     //   DataBaseHelper.columnDirectorName:'Tom McCarthy',
              //     //   DataBaseHelper.columnDate:'12-03-2020',
              //     //   DataBaseHelper.columnPoster:'/path/img.jpg'
              //     // });
              //     print("the inserted id is ");
              //
              //     MovieModel movieModel =MovieModel(movieName: "movieName",
              //         directorName: "directorName",
              //         productPic: "productPic",
              //         date: "date");
              //
              //     print("datttaa $movieModel");
              //     if(globalFormKey.currentState!.validate()){
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => ShowDataBase(),
              //         ),
              //       );
              //     }
              //
              //   },
              // ),

              // ElevatedButton(
              //   child: Text("query"),
              //   onPressed: () async {
              //
              //   },
              // ),
              button()
            ],
          ),
        ),
      ),
    );
  }

  var margin_30 = SizedBox(
    height: 30,
  );

  var margin_40 = SizedBox(
    height: 40,
  );

  var margin_50 = SizedBox(
    height: 50,
  );

  var margin_20 = SizedBox(
    height: 20,
  );

  var margin_5 = SizedBox(
    height: 5,
  );

  var margin_10 = SizedBox(
    height: 20,
  );

  var weightMargin_10 = SizedBox(
    width: 5,
  );

  var weightMargin_20 = SizedBox(
    width: 10,
  );

  var weightMargin_30 = SizedBox(
    width: 30,
  );

  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //
  //     if (image == null) {
  //       return "Please Selected the image";
  //     }
  //     final tempImage = File(image.path);
  //     // setState(() => this.image = tempImage);
  //     setState(() => model.productPic = tempImage as String);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image $e');
  //   }
  // }

  Future<Null> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateTimeController,
        firstDate: DateTime(1948),
        lastDate: DateTime(2090));
    if (pickedDate != null) {
      setState(() {
        dateTimeController = pickedDate;
        print(dateTimeController.toString());
      });
    }
  }

  button() {
    // return ElevatedButton(
    //   child: Text("submit"),
    //   onPressed: () {
    //     print("calleddd");
    //     // print("llllisttt ---- ${dbService.getProducts()}");
    //     // if (globalFormKey.currentState!.validate()) {
    //     //   dbService.addProduct(model).then((value) => (){
    //     //     // print("printt $value");
    //     //     Navigator.push(
    //     //         context,
    //     //         MaterialPageRoute(builder: (context) => ShowDataBase(),),);
    //     //   });
    //     // }
    //     if(globalFormKey.currentState!.validate()){
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => ShowDataBase(),
    //         ),
    //       );
    //     }
    //   },
    // );
    return new Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (globalFormKey.currentState!.validate()) {
            print(model.toMap());
            if (widget.isEditMode!) {
              dbService.updateProduct(model).then(
                (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowDataBase(),
                    ),
                  );
                },
              );
            } else {
              dbService.addProduct(model).then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowDataBase(),
                  ),
                );
              });
            }
          }
        },
        child: Container(
          height: 40.0,
          margin: EdgeInsets.all(10),
          width: 150,
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              "Add Movie ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  picPicker(String fileName, Function onFilePicked) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: new IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.image, size: 35.0),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.gallery)
                      as Future<PickedFile>?;
                  _imageFile!.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: new IconButton(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                icon: Icon(Icons.camera, size: 35.0),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.camera)
                      as Future<PickedFile>?;
                  _imageFile?.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
          ],
        ),
        fileName != null
            ? Image.file(
                File(fileName),
                width: 300,
                height: 300,
              )
            : new Container()
      ],
    );
  }
}
