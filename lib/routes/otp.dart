import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/main.dart';
import 'package:okoul_quizu/routes/name.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  const OtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hasValidOtp = false;
  // late SharedPreferences preferences;

  // @override
  // void initState() {
  //   super.initState();
  //   // init();
  // }

  // Future init() async {
  //   preferences = await SharedPreferences.getInstance();
  // }

  Future checkOtp() async {
    var response = await http.post(Uri.parse("https://quizu.okoul.com/Login"),
        body: {"OTP": controller.text, "mobile": '0555555555'});

    //TODO: UNCOMMENT THIS

    // var response = await http.post(Uri.parse("https://quizu.okoul.com/Login"),
    //     body: {"OTP": controller.text, "mobile": widget.phoneNumber});

    var data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      debugPrint(response.body);
      setState(() {
        hasValidOtp = true;
      });
      return data;
    } else {
      debugPrint(response.body);
      setState(() {
        hasValidOtp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        children: [
          Flexible(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset('assets/login.svg',
                    fit: BoxFit.contain, width: 350),
                const SizedBox(height: 8),
                const Divider(),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Welcome to QuizU',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      'Please enter the OTP we sent to your mobile ${widget.phoneNumber}',
                      style: theme.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
                SizedBox(
                    child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: formKey,
                  child: Pinput(
                      length: 4,
                      controller: controller,
                      autofocus: true,
                      closeKeyboardWhenCompleted: true,
                      // onCompleted: (value) => debugPrint(value),
                      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                      validator: (value) {
                        return hasValidOtp ? null : 'Pin is incorrect';
                      }),
                )),
                ElevatedButton(
                    onPressed: () async {
                      var result = await checkOtp();
                      bool isCorrect = formKey.currentState!.validate();

                      if (isCorrect && mounted) {
                        if (result['message'] == 'user created!') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const NamePage()),
                              (Route<dynamic> route) => false);
                        } else if (result['message'] == 'Token returning!') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                              (Route<dynamic> route) => false);
                        }
                        preferences.setString('token', result['token']);
                      }
                    },
                    child: const Text("Check")),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
