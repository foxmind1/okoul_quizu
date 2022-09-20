import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/home_page.dart';
import 'package:okoul_quizu/routes/home.dart';
import 'package:okoul_quizu/routes/name.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                      'Please enter the OTP we sent to your mobile +966-536558233',
                      style: theme.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
                SizedBox(
                    child: Form(
                  key: formKey,
                  child: Pinput(
                    length: 4,
                    controller: controller,
                    onCompleted: (value) => print(value),
                    validator: (value) =>
                        value == '0000' ? null : 'Pin is Incorrect',
                  ),
                )),
                ElevatedButton(
                    onPressed: () {
                      bool isCorrect = formKey.currentState!.validate();
                      if (isCorrect) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const NamePage()),
                            (Route<dynamic> route) => false);
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
