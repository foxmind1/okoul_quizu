import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okoul_quizu/home_page.dart';
import 'package:okoul_quizu/main.dart';
import 'package:http/http.dart' as http;
import 'package:okoul_quizu/constants.dart' as constants;

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
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
                  children: [
                    Text(
                      'Welcome to QuizU',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: theme.colorScheme.primary),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text("What's your name?",
                            style: theme.textTheme.bodyText1,
                            textAlign: TextAlign.center))
                  ],
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value!.trim() == '' ? 'Name can\'t be empty' : null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                ),
                ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward_rounded),
                    onPressed: () {
                      bool isNotEmpty = formKey.currentState!.validate();
                      if (isNotEmpty) {
                        http.post(Uri.parse(constants.apiName), body: {
                          "name": controller.text
                        }, headers: {
                          'Authorization':
                              'Bearer ${preferences.getString(constants.prefsTokenKey)}'
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    label: const Text("Lets Go!")),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
