import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Model/GetUserProfileModel.dart';
import 'HomePage.dart';

class ViewProfile extends StatefulWidget {
  ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();

}

class _ViewProfileState extends State<ViewProfile> {
  String firstName = '';

  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController DobC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController alternatenumC = TextEditingController();
  TextEditingController bloodgroupC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController shiftC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  GetUserProfileModel? userdataModel;

  void getData() async {
    print("get profile apiiii");
    try{
      Response response = await post(Uri.parse(getProfile.toString()),
          body: {
            'user_id': '$CUR_USERID',
          });
       print("get profileee paremeter ${response.body}");
       if (response.statusCode == 200) {
        var data = await jsonDecode(response.body.toString());
        if(data['error'] == false) {
          userdataModel = GetUserProfileModel.fromJson(data);
          firstNameC.text = userdataModel?.data?.firstName ?? '';
          lastNameC.text = userdataModel?.data?.lastName ?? '';
          DobC.text = userdataModel?.data?.dob ?? '';
          emailC.text=userdataModel?.data?.email ??'';
          phoneC.text=userdataModel?.data?.phone ??'';
          alternatenumC.text=userdataModel?.data?.alternateNumber ??'';
          bloodgroupC.text=userdataModel?.data?.bludGroup ??'';
          addressC.text=userdataModel?.data?.address ??'';
          shiftC.text = userdataModel?.data?.shift ?? '';
          setState(() {});
        }
      }
      else {
        print('Failed');
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  var url;
  final picker = ImagePicker();
  File? _imageFile ;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }
  
  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library,color: Colors.black,),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  // ImagePicker imagepicker =  ImagePicker();
                  //  imagepicker.pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                  leading: const Icon(Icons.photo_camera,color: Colors.black,),
                  title: const Text('Camera'),
                  onTap: () async {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  }
              ),
            ],
          ),
        );
      },
    );
  }
  
  
  bool isLodding = false;

  updateProfile() async {
    setState(() {
      isLodding =  true;
    });
    var headers = {
      'Cookie': 'ci_session=460df0c029308dfe3a2efd49ba9a7759757f72ad'
    };
    var request = http.MultipartRequest('POST', Uri.parse(updatePrfile.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'first_name': firstNameC.text,
      'last_name': lastNameC.text,
      'dob': DobC.text,
      'blud_group': bloodgroupC.text,
      'alternate_number': alternatenumC.text,
      'address': addressC.text,
      'phone': phoneC.text,
      'email': emailC.text
    });
    print("update profile parameterrr ${request.fields}");
    request.files.add(await http.MultipartFile.fromPath('image', _imageFile?.path ?? ""));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("qqqqqqqqqqqqqqq ${response.statusCode}");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = json.decode(result);
      print("11111111111111111${finalResult['error']}");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      setState(() {
        isLodding =  false;
      });
    }
    else {
      setState(() {
        isLodding =  false;
      });
      print(response.reasonPhrase);
    }
  }

  // updateProfile() async {
  //   var headers = {
  //     'Cookie': 'ci_session=ace961be64c0cff7dc6172ede9e9aeca3f1a399c'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/task_management_new/app/api/update_profile'));
  //   request.fields.addAll({
  //     'user_id': '32',
  //     'first_name': firstNameC.text.toString(),
  //     'last_name': lastNameC.text.toString(),
  //     'dob': DobC.text.toString(),
  //     'blud_group': bloodgroupC.text.toString(),
  //     'alternate_number': alternatenumC.text.toString(),
  //     'address': addressC.text.toString(),
  //     'phone': phoneC.text.toString(),
  //     'email': emailC.text.toString(),
  //
  //   });
  //   print("Update Profile Parameter ${request.fields}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print("workingggggg");
  //     print(await response.stream.bytesToString());
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  String? shift;
  var shiftItem = [
    'Week Day',
    'Night',
    'General'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.primary,
        centerTitle: true,
        title: Text(getTranslated(context, 'VIEWPROFILE')!, style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: _imageFile!= null ? Image.file(_imageFile!.absolute)
                        : Image.asset('assets/images/person.png', scale: 4),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 22,
                  child: InkWell(
                    onTap: () {
                      _showImagePicker(context);
                    },
                    child: Icon(
                      Icons.edit,color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 20,left: 20, top: 20),
            //   child: Container(
            //     color: Colors.white,
            //     child: Card(
            //       elevation: 3,
            //       child: Container(
            //         color: Colors.white,
            //         child: DropdownButtonFormField<String>(
            //           value: shift,
            //           onChanged: (String? newValue) {
            //             setState(() {
            //               shift = newValue!;
            //               print("printttttt statusss ${shift}");
            //             });
            //           },
            //           items: shiftItem.map((String avaliableitem) {
            //             return DropdownMenuItem(
            //               value: avaliableitem,
            //               child: Text(avaliableitem.toString()),
            //             );
            //           }).toList(),
            //           decoration: const InputDecoration(
            //             border: InputBorder.none,
            //             hintText: 'Status',
            //             filled: true,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20, top: 20),
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                      controller: firstNameC,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          // hintText: "first_name:${firstName}",
                          labelText: getTranslated(context, 'FIRSTNAME')!,
                          hintText: getTranslated(context, 'FIRSTNAME')!,
                      ),
                  ),      //First_name
                  SizedBox(height: 12),
                  TextFormField(
                      controller: lastNameC,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: getTranslated(context, 'LASTNAME')!,
                          labelText: getTranslated(context, 'LASTNAME')!
                      ),
                  ),//Last_name
                  SizedBox(height: 12),
                  TextFormField(
                    readOnly: true,
                    controller: emailC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: getTranslated(context, 'EMAILHINT_LBL')!,
                        labelText: getTranslated(context, 'EMAILHINT_LBL')!
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: phoneC,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Phone Number",
                        labelText: "Phone"
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                      controller: DobC,
                      keyboardType: TextInputType.datetime,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter DOB",
                          labelText: "Date of Birth"
                      ),
                  ),    //DOB
                  SizedBox(height: 12),
                  TextFormField(
                      controller: bloodgroupC,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Blood Group",
                          labelText: "Blood Group"
                      ),
                  ),    //bloodgroup
                  SizedBox(height: 12,),
                  TextFormField(
                      controller:alternatenumC ,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Alternate Number",
                          labelText: "Alternate Number"
                      ),
                  ),    //AlternateNumber
                  SizedBox(height: 12),
                  TextFormField(
                      controller: addressC,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Address",
                          labelText: "Address"
                      ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: shiftC,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Shift",
                        labelText: "Shift"
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      updateProfile();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(color: colors.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text("Update",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
