import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:http/http.dart'as http;
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Model/work_allotment_model.dart';

import '../../Helper/Session.dart';
import '../../Model/PerformanceTrackingModel.dart';

class PerformaceTracking extends StatefulWidget {
  const PerformaceTracking({Key? key}) : super(key: key);

  @override
  State<PerformaceTracking> createState() => _PerformaceTrackingState();
}

class _PerformaceTrackingState extends State<PerformaceTracking> {

  PerformanceTrackingModel? performancedata;

  Future<void> performance() async {
    var headers = {
      'Cookie': 'ci_session=7ae8b4f267c403c6776ef6271edd089e3b1a17c4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}task_report'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'start_date': '${dateController.text}',
      'end_date': '${dateCtrTwo.text}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = PerformanceTrackingModel.fromJson(json.decode(Result));
      setState(() {
        performancedata = finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }
  }

  TextEditingController dateController = TextEditingController();
  TextEditingController dateCtrTwo = TextEditingController();

  String _dateValue = '';
  var dateFormate;


  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Future _selectDateStart() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        dateController = TextEditingController(text: _dateValue);
      });
  }


  Future _selectDateend() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        dateCtrTwo = TextEditingController(text: _dateValue);
      });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  performanceView() {
    return performancedata?.data == null || performancedata?.data==''? Center(
        child:Text('Data not found',style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)))
        : Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
        height: 180,
        child: Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            // height:330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left:10.0, right: 0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated(context, 'TITLE')!,style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold)),
                          SizedBox(height:10),
                          Text(getTranslated(context, 'TOTALTASK')!,style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold)),
                          SizedBox(height:10),
                          Text(getTranslated(context, 'COMPLETETASK')!,style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold)),
                          SizedBox(height:10),
                          Text(getTranslated(context, 'PENDINGTASK')!, style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold)),
                          SizedBox(height:10),
                        ],
                      ),
                      SizedBox(width: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${performancedata?.message}',overflow: TextOverflow.ellipsis,maxLines:1),
                            SizedBox(height: 10),
                            Text('${performancedata?.data?.totalTasks}',overflow: TextOverflow.ellipsis,maxLines: 2),
                            SizedBox(height: 10),
                            Text('${performancedata?.data?.completedTask}',overflow: TextOverflow.ellipsis,maxLines: 2),
                            SizedBox(height: 10),
                            Text('${performancedata?.data?.pendingTask}',overflow: TextOverflow.ellipsis,maxLines:3),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: colors.blackTemp,)),
        backgroundColor: colors.whiteTemp,
        elevation: 0,
        title: Text(getTranslated(context, 'PERFORMANCE')!,style: TextStyle(color: colors.blackTemp, fontSize: 19),),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
           Container(
             height: 190,
             width: MediaQuery.of(context).size.width/1.1,
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
             child: Card(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
               elevation: 2,
               child: Padding(
                 padding: const EdgeInsets.only(top: 10),
                 child: Column(
                   children: [
                     Container(
                       height: 50,
                       width: MediaQuery.of(context).size.width/1.5,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                       child: TextFormField(
                         readOnly: true,
                         onTap: () {
                           _selectDateStart();
                         },
                         controller: dateController,
                         decoration: InputDecoration(
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             counterText: "",
                             hintText: getTranslated(context, 'SELECTSTARTLBL')!,
                             contentPadding: EdgeInsets.only(left: 10)
                         ),
                         validator: (v) {
                           if (v!.isEmpty) {
                             return getTranslated(context, 'DATEWARNING')!;
                           }
                         },
                       ),
                     ),
                     SizedBox(height: 10,),
                     Container(
                       height: 50,
                       width: MediaQuery.of(context).size.width/1.5,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                       child: TextFormField(
                         readOnly: true,
                         onTap: () {
                           _selectDateend();
                         },
                         controller: dateCtrTwo,
                         decoration: InputDecoration(
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             counterText: "",
                             hintText: getTranslated(context, 'SELECTENDDATE')!,
                             contentPadding: EdgeInsets.only(left: 10)
                         ),
                         validator: (v) {
                           if (v!.isEmpty) {
                             return getTranslated(context, 'DATEWARNING')!;
                           }
                         },
                       ),
                     ),
                     SizedBox(height: 10),
                     InkWell(
                       onTap: () {
                         if(dateController.text.isEmpty && dateCtrTwo.text.isEmpty) {
                           Fluttertoast.showToast(msg: getTranslated(context, 'DATEWARNING')!);
                         }
                         else {
                           performance();
                         }
                       },
                       child: Container(
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
                          height: 40,
                           width: 100,
                           child: Center(child: Text(getTranslated(context, 'SUBMIT_LBL')!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)))),
                     ),
                   ],
                 ),
               ),
             ),
           ),
          SizedBox(height: 10),
          performanceView(),
        ],
      ),
    );
  }
}
