import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Session.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import '../../Helper/String.dart';
import 'package:http/http.dart'as http;

import '../Model/PunchInModel.dart';


class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  var latitude;
  var longitude;

  var pinController = TextEditingController();
  var currentAddress = TextEditingController();
  bool isLoading = false;
  var finalResult;
  Future<void> checkInNow() async {

    var headers = {
      'Cookie': 'ci_session=3515d88c5cab45d32a201da39275454c5d051af2'
    };
    var request = http.MultipartRequest('POST', Uri.parse(checkInNowApi.toString()));
    request.fields.addAll({
      'user_id': CUR_USERID.toString(),
      'checkin_latitude': '${latitude}',
      'checkin_longitude': '${longitude}',
      'address': '${currentAddress.text}'
    });
    for (var i = 0; i < imagePathList.length; i++) {
      print('Imageeeeeeeeeeeeeeeeee${imagePathList}');
      imagePathList == null
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
          'checkinimages[]', imagePathList[i].toString()));
    }
    print("this is my check in request ${request.fields.toString()}");

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      var result = json.decode(str);
      finalResult = result['data'];
      setState(() {
        isLoading=false;
      });
      if(result['data']['error'] == false){
        Fluttertoast.showToast(msg: result['data']['msg']);
        Navigator.pop(context, true);
      }else{
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: result['data']['msg']);
      }
      // var finalResponse = GetUserExpensesModel.fromJson(result);
      // final finalResponse = CheckInModel.fromJson(json.decode(Response));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getCurrentLoc() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
   // var loc = Provider.of<LocationProvider>(context, listen: false);

    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    setState(() {
      longitude_Global=latitude;
      lattitudee_Global=longitude;
    });

    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(latitude!), double.parse(longitude!),
        localeIdentifier: "en");

    pinController.text = placemark[0].postalCode!;
    if (mounted) {
      setState(() {
        pinController.text = placemark[0].postalCode!;
        currentAddress.text =
            "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
       // loc.lng = position.longitude.toString();
        //loc.lat = position.latitude.toString();
        setState(() {
          currentlocation_Global=currentAddress.text.toString();
        });
        print('Latitude=============${latitude}');
        print('Longitude*************${longitude}');

        print('Current Addresssssss${currentAddress.text}');
      });
      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
        setState(() {
          // navigateToPage();
        });
      }
    }
  }

  navigateToPage() async {
    Future.delayed(Duration(milliseconds: 800), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false);
    });
  }

  ///MULTI IMAGE PICKER FROM GALLERY CAMERA
  ///
  ///
  List imagePathList = [];
  bool isImages = false;
  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      allowCompression: true,

    );
    if (result != null) {
      setState(() {
        isImages = true;
        // servicePic = File(result.files.single.path.toString());
      });
      imagePathList = result.paths.toList();
      // imagePathList.add(result.paths.toString()).toList();
      print("SERVICE PIC === ${imagePathList}");
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      // User canceled the picker
    }
  }
  Widget uploadMultiImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(


          height: 10,
        ),
        InkWell(
            onTap: () async {
              pickImageDialog(context, 1);

              // await pickImages();
            },
            child: Container(
                height: 40,
                width: 165,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.primary),
                child: Center(
                    child: Text(
                      "Upload Selfie",
                      style: TextStyle(color: colors.whiteTemp),
                    )))),
        const SizedBox(


          height: 10,
        ),
        Visibility(
            visible: isImages,
            child: imagePathList != null ? buildGridView() : SizedBox.shrink()
        )

      ],
    );
  }
  Widget buildGridView() {
    return Container(
      height: 200,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/2,
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
                  onTap: (){
                    setState((){
                      imagePathList.remove(imagePathList[index]);
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    size: 30,
                    color: Colors.red.withOpacity(0.7)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  void pickImageDialog(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  getFromGallery();
                },
                child:  Container(
                  child: ListTile(
                      title:  Text("Gallery"),
                      leading: Icon(
                        Icons.image,
                        color: colors.primary,
                      )),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  // getImage(ImgSource.Camera, context, i);
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Future getImage(ImgSource source, BuildContext context, int i) async {
  //
  //   var image = await ImagePickerGC.pickImage(
  //     imageQuality:40,
  //     context: context,
  //     source: source,
  //     cameraIcon: const Icon(
  //       Icons.add,
  //       color: Colors.red,
  //     ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
  //   );
  //   getCropImage(context, i, image);
  //   // back();
  // }

  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    Navigator.pop(context);
    if (i == 1) {
      imagePathList.add(croppedFile!.path);
      setState(() {
        isImages = true;
      });
      print("this is my camera image $imagePathList");
      // imageFile = File(croppedFile!.path);
    }
    back();
  }
  ///MULTI IMAGE PICKER FROM GALLERY CAMERA
  ///
  ///

  @override
  void initState() {
    // TODO: implement initState
    // getCurrentLoc();
    super.initState();
    convertDateTimeDispla();
   }

  String? monthly;
  var monthlyitem = [
    'On Leave',
    'Weekly Off',
    'Holiday',
    'Compensatory Holiday',
    'OnDuty'
  ];

  String? shift;
  var shiftItem = [
    'Day',
    'Night',
    'General'
  ];

  String? taskStatus;
  var taskItem = [
    'Done',
    'Not-Done'
  ];

  var dateFormate;
  String? formattedDate;
  String? timeData;

  convertDateTimeDispla() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
    print("datedetet${formattedDate}"); // 2016-01-25
    timeData = DateFormat("hh:mm:ss a").format(DateTime.now());
    print("timeeeeeeeeee${timeData}");
  }

  bool isCheckedIn = true;
  PunchInModel? punchInModel;
  punchIn(Status) async {
    var headers = {
      'Cookie': 'ci_session=c7229fd981f7b63597f01b3b6b126ef924a184d8'
    };
    var request = http.MultipartRequest('POST', Uri.parse(punchsIn.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'check_in': '${timeData}',
      'date': '${formattedDate}',
      'status': "${Status}",
      'shift': "${shift.toString()}"
    });
    print("punch in parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      // bool status = result['data'];
      var finalResponse = PunchInModel.fromJson(result);
      print("punch in paratetet ${finalResponse}");
      Fluttertoast.showToast(msg: "${finalResponse.message}");
      setState(() {
        // isCheckedIn = status;
        punchInModel = finalResponse;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(status: punchInModel?.data?.status.toString())));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  monthlyDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Card(
                  elevation: 3,
                  child: DropdownButtonFormField<String>(
                    value: monthly,
                    onChanged: (String? newValue) {
                      setState(() {
                        monthly = newValue!;
                        print("printttttt statusss ${monthly}");
                      });
                    },
                    items: monthlyitem.map((String avaliableitem) {
                      return DropdownMenuItem(
                        value: avaliableitem,
                        child: Text(avaliableitem.toString()),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: getTranslated(context, 'DUTY_STATUS')!,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 3,
                  child: DropdownButtonFormField<String>(
                    value: shift,
                    onChanged: (String? newValue) {
                      setState(() {
                        shift = newValue!;
                        print("printttttt statusss ${shift}");
                      });
                    },
                    items: shiftItem.map((String avaliableitem) {
                      return DropdownMenuItem(
                        value: avaliableitem,
                        child: Text(avaliableitem.toString()),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: getTranslated(context, 'SHIFT')!,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(getTranslated(context, 'CANCEL')!,
                  style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.lightBlack,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text(getTranslated(context, 'CONFIRM')!,
                  style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.lightBlack,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {});
                punchIn(monthly.toString());
                // getDoctors();
                // Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.white70,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/checkin.png",
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                    onPressed: () async {
                      // punchIn();
                      setState(() {
                        // isCheckedIn = true;
                      });
                      monthlyDialog();
                    }, child: Text(getTranslated(context, 'PUNCHIN')!,
                      ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: StadiumBorder(),
                        fixedSize: Size(170, 40),
                        backgroundColor: colors.primary
                    )
                ),
                //  SizedBox(height: 50),
                //  Container(
                //     height: 45,
                //     width: 220,
                //     child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //             elevation: 0,
                //             shape: StadiumBorder(),
                //             fixedSize: Size(350, 40),
                //             backgroundColor: colors.primary.withOpacity(0.8)
                //         ),
                //         onPressed: () {
                //           if(latitude == "" || latitude == 0 || latitude == null) {
                //             setSnackbar("Please wait fetching your current location...", context);
                //           }else{
                //             setState(() {
                //               isLoading = true;
                //             });
                //             checkInNow();
                //           }
                //     },
                //         child:isLoading? Center(child: CircularProgressIndicator(
                //           color: Colors.white,
                //         ))
                //     : Text('PUNCH IN NOW'))
                // ) // : SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
