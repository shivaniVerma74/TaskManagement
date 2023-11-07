import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Helper/cropped_container.dart';
import 'package:omega_employee_management/Provider/SettingProvider.dart';
import 'package:omega_employee_management/Provider/UserProvider.dart';
import 'package:omega_employee_management/Screen/SendOtp.dart';
import 'package:omega_employee_management/Screen/SignUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../Helper/Session.dart';
import 'check_In_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPagePageState createState() => new _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  String? countryName;
  FocusNode? passFocus, monoFocus = FocusNode();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool visible = false;
  String? password,
      mobile,
      username,
      email,
      id,
      mobileno,
      city,
      area,
      pincode,
      address,
      latitude,
      longitude,
      image;
  bool _isNetworkAvail = true;
  Animation? buttonSqueezeanimation;

  AnimationController? buttonController;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    buttonSqueezeanimation = new Tween(
      begin: deviceWidth! * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController!,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
   getToken();
  }

  String? fcmToken;
  getToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      fcmToken = value;
      print('____sdsdsdfsdf______${fcmToken}_________');
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    buttonController!.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      checkNetwork();
    }
  }

  Future<void> checkNetwork() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      getLoginUser();
    } else {
      Future.delayed(Duration(seconds: 2)).then((_) async {
        await buttonController!.reverse();
        if (mounted)
          setState(() {
            _isNetworkAvail = false;
          });
      });
    }
  }

  bool validateAndSave() {
    final form = _formkey.currentState!;
    form.save();
    if (form.validate()) {
      return true;
    }
    return false;
  }

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.fontColor),
      ),
      backgroundColor: Theme.of(context).colorScheme.lightWhite,
      elevation: 1.0,
    ));
  }

  Widget noInternet(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(top: kToolbarHeight),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          noIntImage(),
          noIntText(context),
          noIntDec(context),
          AppBtn(
            title: getTranslated(context, 'TRY_AGAIN_INT_LBL'),
            btnAnim: buttonSqueezeanimation,
            btnCntrl: buttonController,
            onBtnSelected: () async {
              _playAnimation();

              Future.delayed(Duration(seconds: 2)).then((_) async {
                _isNetworkAvail = await isNetworkAvailable();
                if (_isNetworkAvail) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                } else {
                  await buttonController!.reverse();
                  if (mounted) setState(() {});
                }
              });
            },
          )
        ]),
      ),
    );
  }

  Future<void> getLoginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {USERNAME: emailController.text, PASSWORD: password, "web_fcm": '${fcmToken}'};
    print("parameter ${data}");
    Response response = await post(getUserLoginApi, body: data, headers: headers).timeout(Duration(seconds: timeOut));
    print("bodyyy ${response.body}");
    var getdata = json.decode(response.body);
    bool error = getdata["error"];
    String? msg = getdata["message"];
    await buttonController!.reverse();
    if (error == false) {
      setSnackbar(msg!);
      var i = getdata["data"][0];
      id = i[ID];
      username = i[USERNAME];
      email = i[EMAIL];
      // mobile = getdata["data"][MOBILE];
      city = i[CITY];
      area = i[AREA];
      address = i[ADDRESS];
      pincode = i[PINCODE];
      latitude = i[LATITUDE];
      longitude = i[LONGITUDE];
      image = i[IMAGE];
      CUR_USERID = id;
      prefs.setString('user_id', id!);
      // CUR_USERNAME = username;
      UserProvider userProvider = Provider.of<UserProvider>(this.context, listen: false);
      userProvider.setName(username ?? "");
      userProvider.setEmail(email ?? "");
      userProvider.setProfilePic(image ?? "");
      SettingProvider settingProvider = Provider.of<SettingProvider>(context, listen: false);
      settingProvider.saveUserDetail(id!, username, email, mobile, city, area, address, pincode, latitude, longitude, image, context);
      // setPrefrenceBool(ISFIRSTTIME, false);
      // Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckInScreen()));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtp(mobileNumber: mobile.toString(), otp: otp.toString())));
    }
    else {
      setSnackbar(msg!);
    }
  }

  _subLogo() {
    return Expanded(
      flex: 4,
      child: Center(
        child: Image.asset(
          'assets/images/.png',
        ),
      ),
    );
  }

  signInTxt() {
    return Padding(
        padding: EdgeInsetsDirectional.only(
          top: 30.0,
        ),
        child: Align(
          alignment: Alignment.center,
          child: new Text(
            getTranslated(context, 'SIGNIN_LBL')!,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Theme.of(context).colorScheme.fontColor,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  setMobileNo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.only(
        top: 30.0,
      ),
      child: TextFormField(
        // onFieldSubmitted: (v) {
        //   FocusScope.of(context).requestFocus(passFocus);
        // },
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        style: TextStyle(
          color: Theme.of(context).colorScheme.fontColor,
          fontWeight: FontWeight.normal,
        ),
        focusNode: monoFocus,
        textInputAction: TextInputAction.next,
       // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
       //  validator: (val) => validateMob(val!,
       //      getTranslated(context, 'MOB_REQUIRED'),
       //      getTranslated(context, 'VALID_MOB')),
        onSaved: (String? value) {
          email = value;
        },
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.fontColor,
            size: 20,
          ),
          hintText: "UserName",
          hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
              color: Theme.of(context).colorScheme.fontColor,
              fontWeight: FontWeight.normal),
          filled: true,
          fillColor: Theme.of(context).colorScheme.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.primary),
            borderRadius: BorderRadius.circular(7.0),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40,
            maxHeight: 20,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.lightBlack2),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );

    return Container(
      width: deviceWidth! * 0.7,
      padding: EdgeInsetsDirectional.only(
        top: 30.0,
      ),
      child: TextFormField(
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(passFocus);
        },
        keyboardType: TextInputType.number,
        controller: mobileController,
        style: TextStyle(
            color: Theme.of(context).colorScheme.fontColor,
            fontWeight: FontWeight.normal),
        focusNode: monoFocus,
        textInputAction: TextInputAction.next,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (val) => validateMob(
            val!,
            getTranslated(context, 'MOB_REQUIRED'),
            getTranslated(context, 'VALID_MOB')),
        onSaved: (String? value) {
          mobile = value;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.call_outlined,
            color: Theme.of(context).colorScheme.fontColor,
            size: 17,
          ),
          hintText: getTranslated(context, 'MOBILEHINT_LBL'),
          hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
              color: Theme.of(context).colorScheme.fontColor,
              fontWeight: FontWeight.normal),
          filled: true,
          fillColor: Theme.of(context).colorScheme.lightWhite,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.fontColor),
            borderRadius: BorderRadius.circular(7.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.lightWhite),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }

  setPass() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: TextFormField(
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(passFocus);
        },
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: passwordController,
        style: TextStyle(
            color: Theme.of(context).colorScheme.fontColor,
            fontWeight: FontWeight.normal),
        focusNode: passFocus,
        textInputAction: TextInputAction.next,
        validator: (val) => validatePass(
            val!,
            getTranslated(context, 'PWD_REQUIRED'),
            getTranslated(context, 'PWD_LENGTH')),
        onSaved: (String? value) {
          password = value;
        },
        decoration: InputDecoration(
          prefixIcon: SvgPicture.asset(
            "assets/images/password.svg",
            color: Theme.of(context).colorScheme.fontColor,
          ),

          suffixIcon: InkWell(
            onTap: () {
              // SettingProvider settingsProvider =
              // Provider.of<SettingProvider>(this.context, listen: false);
              //
              // settingsProvider.setPrefrence(ID, id!);
              // settingsProvider.setPrefrence(MOBILE, mobile!);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                            // title: getTranslated(context, 'FORGOT_PASS_TITLE'),
                          )));
            },
            child: Text(
              getTranslated(context, "FORGOT_LBL")!,
              style: TextStyle(
                color: colors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          hintText: getTranslated(context, "PASSHINT_LBL")!,
          hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
              color: Theme.of(context).colorScheme.fontColor,
              fontWeight: FontWeight.normal),
          //filled: true,
          fillColor: Theme.of(context).colorScheme.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          suffixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
          prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
          // focusedBorder: OutlineInputBorder(
          //     //   borderSide: BorderSide(color: fontColor),
          //     // borderRadius: BorderRadius.circular(7.0),
          //     ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.primary),
            borderRadius: BorderRadius.circular(7.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.lightBlack2),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }

  forgetPass() {
    return Padding(
        padding: EdgeInsetsDirectional.only(start: 25.0, end: 25.0, top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                SettingProvider settingsProvider =
                    Provider.of<SettingProvider>(this.context, listen: false);

                settingsProvider.setPrefrence(ID, id!);
                settingsProvider.setPrefrence(MOBILE, mobile!);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(
                              // title:
                              //     getTranslated(context, 'FORGOT_PASS_TITLE'),
                            )));
              },
              child: Text(getTranslated(context, 'FORGOT_PASSWORD_LBL')!,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.normal)),
            ),
          ],
        ));
  }

  termAndPolicyTxt() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          bottom: 20.0, start: 25.0, end: 25.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(getTranslated(context, 'DONT_HAVE_AN_ACC')!,
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Theme.of(context).colorScheme.fontColor,
                  fontWeight: FontWeight.normal)),
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(
                    // title: getTranslated(context, 'SEND_OTP_TITLE'),
                  ),
                ));
              },
              child: Text(
                getTranslated(context, 'SIGN_UP_LBL')!,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Theme.of(context).colorScheme.fontColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal),
              ))
        ],
      ),
    );
  }

  loginBtn() {
    return AppBtn(
      title: getTranslated(context, 'SIGNIN_LBL'),
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () async {
        validateAndSubmit();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: _isNetworkAvail
            ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: back(),
                  ),
                  Image.asset(
                    'assets/images/doodle.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  getLoginContainer(),
                  getLogo(),
                ],
              )
            : noInternet(context));
  }

  getLoginContainer() {
    return Positioned.directional(
      start: MediaQuery.of(context).size.width * 0.025,
      // end: width * 0.025,
      // top: width * 0.45,
      top: MediaQuery.of(context).size.height * 0.2, //original
      //    bottom: height * 0.1,
      textDirection: Directionality.of(context),
      child: ClipPath(
        clipper: ContainerClipper(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.8),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.95,
          color: Theme.of(context).colorScheme.white,
          child: Form(
            key: _formkey,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                      setSignInLabel(),
                      setMobileNo(),
                      setPass(),
                      loginBtn(),
                      // termAndPolicyTxt(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLogo() {
    return Positioned(
      // textDirection: Directionality.of(context),
      left: (MediaQuery.of(context).size.width / 2) - 50,
      // right: ((MediaQuery.of(context).size.width /2)-55),

      top: (MediaQuery.of(context).size.height * 0.2) - 50,
      //  bottom: height * 0.1,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset(
          'assets/images/loginlogo.png',
          scale: 4,
        ),
      ),
    );
  }

  Widget setSignInLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslated(context, 'SIGNIN_LBL')!,
          style: const TextStyle(
            color: colors.primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
