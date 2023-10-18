import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omega_employee_management/Model/TaskListModel.dart';
import '../Helper/Color.dart';

class TaskDetails extends StatefulWidget {
 final TaskData? model;
  const TaskDetails({Key? key, this.model}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar (
        elevation: 0,
        backgroundColor: colors.primary,
        centerTitle: true,
        title: Text("Details", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child:
              Card(
                elevation: 3,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width/1,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Description:"),
                                Container(child: Text("${widget.model!.description}", overflow: TextOverflow.ellipsis,))
                              ],
                            ),
                            SizedBox(height: 9),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Assign Date:'), //
                                Text("${widget.model!.dateCreated}"),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Due Date:"),
                                Text("${widget.model!.dueDate}")
                              ],
                            ),
                            SizedBox(height: 9),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Card(
                elevation: 3,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Assign To:'),
                                Text("${widget.model!.users}"),
                              ],
                            ),
                            SizedBox(height: 5),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Due Date:"),
                            //     Text("${widget.model!.dueDate}"),
                            //   ],
                            // ),
                            // SizedBox(height: 9),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
             SizedBox(height: 10),
            customTabbar(),
            _currentIndex  == 1 ? comment(context) : files(context)
          ],
        ),
    );
  }

  int _currentIndex = 1;
  customTabbar(){
    return Padding(
      padding: const EdgeInsets.only(left:5.0,right:5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 1;

                  print("fiesrt indexexxe");
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 1 ?
                    colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)
                ),
                height: 40,
                width: 105,
                child: Center(
                  child: Text("Comments",style: TextStyle(color: _currentIndex == 1 ? colors.whiteTemp:colors.blackTemp,fontSize: 15)),
                ),
              ),
            ),
            SizedBox(width:20),
            InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 2;
                  print("second indexxxx");
                  // showAlertDialog(
                  //   context,
                  //   'Pin Code',
                  //   'Please Enter Pin Code Here!',
                  // );,
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 2 ?
                    colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)
                ),
                height: 40,
                width: 130,
                child: Center(
                  child: Text("Files",style: TextStyle(color: _currentIndex == 2 ?colors.whiteTemp:colors.blackTemp, fontSize: 15)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();
  File? _imageFile;
  List<String> imagePathList = [];
  bool isImages = false;


  Widget uploadMultiImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            // pickImageDialog(context, 1);
            // await pickImages();
            _getFromCamera();
          },
          child: Container(
            height: 40,
            width: 165,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: colors.primary),
            child: Center(
              child: Text(
                "Upload Image",
                style: TextStyle(color: colors.whiteTemp),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: isImages,
            child:  buildGridView()),
      ],
    );
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imagePathList.add(_imageFile?.path ?? "");
        isImages = true ;
      });
      //Navigator.pop(context);
    }
  }

  Widget buildGridView() {
    return Container(
      height: 200,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.file(File(imagePathList[index]),
                          fit: BoxFit.cover),
                    ),
                  )),
              Positioned(
                top: 5,
                right: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imagePathList.remove(imagePathList[index]);
                    });
                  },
                  child: Icon(Icons.remove_circle,
                      size: 30, color: Colors.red.withOpacity(0.7)),
                ),
              )
            ],
          );
        },
      ),
    );
  }



  comment(BuildContext) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
             elevation: 4,
             child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                height: 60,
                width: MediaQuery.of(context).size.width/1.1,
                child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Add a comment",
                  hintStyle: TextStyle(fontSize: 13),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  files(BuildContext) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
              height: 60,
              width: MediaQuery.of(context).size.width/1.1,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Add a comment",
                  hintStyle: TextStyle(fontSize: 13),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
