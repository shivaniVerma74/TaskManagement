import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Model/TermConditionModel.dart';

class TermCondition extends StatefulWidget {
  final String? title;
  const TermCondition({Key? key, this.title}) : super(key: key);

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  @override


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =

  GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getTermsConditionsDataApi();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getTermsConditionsDataApi();
  }

  TermConditionModel? settingModel;
  var termsConditions;
  var termsConditionsTitle;

  getTermsConditionsDataApi() async {
    var headers = {
      'Cookie': 'ci_session=0972dd56b7dcbe1d24736525bf2ee593c03d46de'
    };
    var request = http.Request('GET', Uri.parse(termConditions.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('_____termconditionss${response.statusCode}');
      final result =  await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      print('______asdsadsa____${result}');
      setState(() {
        termsConditions = jsonResponse['terms_conditions']['data'];
        termsConditionsTitle = jsonResponse['terms_conditions']['type'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: getSimpleAppBar(widget.title!, context),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8,top: 5),
              child: Text("${termsConditionsTitle}",style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.bold),),
            ),
            termsConditions == null || termsConditions == "" ? Center(child: CircularProgressIndicator(color: colors.secondary))
                : Html(
                data: termsConditions
            ),
          ],
        ),
      ),
    );
  }
}
