import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/features/login/views/name.dart';
import 'package:okoul_quizu/services/api_services.dart';
import 'package:okoul_quizu/services/shared_prefs_services.dart';
import 'package:pinput/pinput.dart';
import 'package:okoul_quizu/features/home/views/home_page_nav_bar.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  const OtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _hasValidOtp = false;

  Future checkOtp() async {
    var response = await ApiServices.login(controller.text, widget.phoneNumber);

    var data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      debugPrint(response.body);
      setState(
        () {
          _hasValidOtp = true;
        },
      );
      return data;
    } else {
      debugPrint(response.body);
      setState(
        () {
          _hasValidOtp = false;
        },
      );
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
                  SvgPicture.asset(
                    'assets/login.svg',
                    fit: BoxFit.contain,
                    width: 350,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to QuizU',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Please enter the OTP we sent to your mobile: ${widget.phoneNumber}',
                      style: theme.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
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
                        pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                        validator: (value) {
                          return _hasValidOtp ? null : 'Pin is incorrect';
                        },
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    onPressed: () async {
                      var result = await checkOtp();
                      bool isValidOtp = formKey.currentState!.validate();

                      if (isValidOtp && mounted) {
                        if (result['message'] == 'user created!') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const NamePage()),
                              (Route<dynamic> route) => false);
                        } else if (result['message'] == 'Token returning!') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePageNavBar()),
                              (Route<dynamic> route) => false);
                        }
                        SharedPrefsServices.setToken = result['token'];
                      }
                    },
                    label: const Text("Check"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
