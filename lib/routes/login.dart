import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phone_number/phone_number.dart' as pn;
import 'package:okoul_quizu/routes/otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  String completeNumber = '';

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
                const SizedBox(height: 16),
                // const Divider(),
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
                      'Log in and start your journey now!',
                      style: theme.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
                Form(
                  key: formKey,
                  child: IntlPhoneField(
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (p0) async {
                      return await pn.PhoneNumberUtil()
                              .validate(p0!.completeNumber)
                          ? null
                          : 'Invalid Mobile Number';
                    },
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      counterText: '',
                      // counter: Offstage(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    showCursor: false,
                    onChanged: (phone) {
                      debugPrint(phone.completeNumber);
                      completeNumber = phone.completeNumber;
                    },
                  ),
                ),
                ElevatedButton.icon(
                    icon: const Icon(Icons.navigate_next),
                    onPressed: () async {
                      bool isValid = formKey.currentState!.validate();

                      if (isValid) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              OtpPage(phoneNumber: completeNumber),
                        ));
                      }
                    },
                    label: const Text("Start!")),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
