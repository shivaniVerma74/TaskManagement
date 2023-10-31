import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Model/TaskListModel.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Model/AddCommentModel.dart';
import '../Model/FileModel.dart';

class TaskDetails extends StatefulWidget {
 final TaskData? model;
  const TaskDetails({Key? key, this.model}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  TextEditingController commentCtr  = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFile();
  }

  AddCommentModel? commentModel;
  addComments() async {
    var headers = {
      'Cookie': 'ci_session=25ee3f7e594da0604bae2735d787cc67e2db2b6a'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(addComment.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'task_id': '${widget.model?.id}',
      'comment': '${commentCtr.text}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = AddCommentModel.fromJson(result);
      setState(() {
        commentModel = finalResponse;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
      print("this is add comment data ${commentModel}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  updateStatus() async {
    print("update status api");
    var headers = {
      'Cookie': 'ci_session=dba5e06204be1e75ba50fc5c9827f31155e5a1f9'
    };
    var request = http.MultipartRequest('POST', Uri.parse(updateTaskStatus.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'task_id': '${widget.model!.id}',
      'status': 'Done'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  FileModel? fileModel;
  fileUpload() async {
    var headers = {
      'Cookie': 'ci_session=d4000545880f5c86431690491339c9cbcee8567b'
    };
    var request = http.MultipartRequest('POST', Uri.parse(addFile.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'task_id': '${widget.model?.id}'
    });
    request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path ?? ""));
    print('file uploaddd parameter ${request.fields}');
    print('uploaddd filessss ${request.files}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      // var finalResponse = FileModel.fromJson(result);
      // setState(() {
      //   fileModel = finalResponse;
      // });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  getFile()async{
    var headers = {
      'Cookie': 'ci_session=b665b3c078d9516b3bf58dfdc48e55e1c93328fb'
    };
    var request = http.MultipartRequest('POST', Uri.parse(getFiles.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'task_id': '${widget.model?.id}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = FileModel.fromJson(result);
      setState(() {
        fileModel = finalResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar (
        elevation: 0,
        backgroundColor: colors.primary,
        centerTitle: true,
        title: Text(getTranslated(context, 'DETAILS')!, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                      Card(
                      elevation: 3,
                      child: Container(
                        height: 145,
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
                                      Text(getTranslated(context, 'DESCRIPTION')!),
                                      Container(child: Text("${widget.model!.description}", overflow: TextOverflow.ellipsis,))
                                    ],
                                  ),
                                  SizedBox(height: 9),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(getTranslated(context, 'ASSIGNDATE')!), //
                                      Text("${widget.model!.dateCreated}"),
                                    ],
                                  ),
                                  SizedBox(height: 9),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(getTranslated(context, 'DUEDATE')!),
                                      Text("${widget.model!.dueDate}")
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  widget.model!.updateStatus == "pending" ?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(getTranslated(context, 'STATUS')!),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                          });
                                          updateStatus();
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                                            child: Center(
                                                child: Text("${widget.model!.updateStatus}",
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                ),
                                            ),
                                        ),
                                      ),
                                    ],
                                  ): SizedBox(height: 9),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Card(
                  elevation: 3,
                  child: Container(
                    height: 70,
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
                                  Text(getTranslated(context, 'ASSIGNTO')!),
                                  Container(
                                    width: 200,
                                    child: Text("${widget.model!.users}", overflow: TextOverflow.ellipsis, maxLines: 2)),
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
              _currentIndex  == 1 ? comment(context) : files(context),
              SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text("Comments:-", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              //     ],
              //   ),
              // ),
              _currentIndex == 1 ?
              viewComment(): SizedBox(),
            ],
          ),
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
                  child: Text(getTranslated(context, 'COMMENTS')!,style: TextStyle(color: _currentIndex == 1 ? colors.whiteTemp:colors.blackTemp,fontSize: 15)),
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
                    colors.primary : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)
                ),
                height: 40,
                width: 130,
                child: Center(
                  child: Text(getTranslated(context, 'FILES')!,style: TextStyle(color: _currentIndex == 2 ?colors.whiteTemp:colors.blackTemp, fontSize: 15)),
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
                getTranslated(context, 'UPLOADFILES')!,
                style: TextStyle(color: colors.whiteTemp),
              ),
            ),
          ),
        ),
        const SizedBox(
          height:5,
        ),
        Visibility(
            visible: isImages,
            child:  Column(
              children: [
                buildGridView(),
                SizedBox(height: 10),
               isImages == true ?
                InkWell(
                  onTap: () {
                    fileUpload();
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                    child: Center(
                      child: Text(getTranslated(context, 'SUBMIT_LBL')!, style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ): SizedBox(),
              ],
            ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: Card(
            child: GridView.builder(
                itemCount: fileModel?.data?.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                                  image: new NetworkImage("${imageUrl}${fileModel?.data}"),
                                  fit: BoxFit.cover))));
                }),
          ),
        ),
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
        // imagePathList.add(_imageFile?.path ?? "");
        isImages = true ;
      });
      //Navigator.pop(context);
    }
  }

  Widget buildGridView() {
    return Container(
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          height: MediaQuery.of(context).size.height / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.file(_imageFile!,
                fit: BoxFit.cover),
          ),
        ),
      ),
      // GridView.builder(
      //   itemCount: imagePathList.length,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      //   itemBuilder: (BuildContext context, int index) {
      //     return Stack(
      //       children: [
      //         Card(
      //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      //             child: Container(
      //               width: MediaQuery.of(context).size.width / 2.9,
      //               height: MediaQuery.of(context).size.height / 3,
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.all(Radius.circular(15)),
      //                 child: Image.file(_imageFile,
      //                     fit: BoxFit.cover),
      //               ),
      //             ),
      //         ),
      //         // Positioned(
      //         //   top: 0,
      //         //   right: 30,
      //         //   child: InkWell(
      //         //     onTap: () {
      //         //       setState(() {
      //         //         imagePathList.remove(imagePathList[index]);
      //         //       });
      //         //     },
      //         //     child: Icon(Icons.remove_circle,
      //         //         size: 30, color: Colors.red.withOpacity(0.7)),
      //         //   ),
      //         // ),
      //       ],
      //     );
      //   },
      // ),
    );
  }

  comment(BuildContext) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                 elevation: 4,
                 child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                    height: 60,
                    width: MediaQuery.of(context).size.width/1.1,
                    child: TextFormField(
                      controller: commentCtr,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                      hintText: getTranslated(context, 'ADD_COMMENT_LBL')!,
                      hintStyle: TextStyle(fontSize: 13),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  addComments();
                },
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                    child: Center(
                        child: Text(getTranslated(context, 'SUBMIT_LBL')!, style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  viewComment() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.model?.comments?.length ?? 0,
            itemBuilder: (BuildContext, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Card(
              elevation: 4,
              child: Container(
                height: 95,
                width: MediaQuery.of(context).size.width/1.1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(getTranslated(context, 'NAMEHINT_LBL')!),
                        Text("${widget.model?.comments?[index].username}"),
                      ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(getTranslated(context, 'COMMENTS')!),
                          Text("${widget.model?.comments?[index].comment}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  files(BuildContext) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: uploadMultiImage(),
        ),
      ],
    );
  }
}
