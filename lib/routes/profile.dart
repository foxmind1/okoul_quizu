import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okoul_quizu/main.dart';
import 'package:okoul_quizu/routes/login.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future getUserInfo() async {
    var response = await http.get(Uri.parse("https://quizu.okoul.com/UserInfo"),
        headers: {'Authorization': 'Bearer ${preferences.getString('token')}'});

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var scoreData = preferences.getStringList('user_scores') ?? [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false);
                        preferences.remove('token');
                        preferences.remove('user_scores');
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"))
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.account_circle_rounded,
                      size: 110, color: theme.colorScheme.primary),
                  FutureBuilder(
                    future: getUserInfo(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        case ConnectionState.done:
                        default:
                          if (snapshot.hasError ||
                              snapshot.data['mobile'] == null) {
                            return const Center(
                                child: Text("Problem loading user data"));
                          } else if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${snapshot.data['name']}",
                                    style: theme.textTheme.headline5),
                                const SizedBox(height: 4),
                                Text("${snapshot.data['mobile']}")
                              ],
                            );
                          } else {
                            return const Center(child: Text('No data'));
                          }
                      }
                    },
                  )
                ],
              ),
              // const Divider(),
              const SizedBox(height: 32),
              Text('Your scores', style: theme.textTheme.headline4),
              if (scoreData.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: scoreData.length,
                  itemBuilder: (context, index) {
                    var scoreDataItems = jsonDecode(preferences
                        .getStringList('user_scores')!
                        .reversed
                        .toList()[index]);
                    return Column(
                      children: [
                        if (index == 0)
                          ListTile(
                            title:
                                Text('Date', style: theme.textTheme.bodyText2),
                            trailing:
                                Text('Score', style: theme.textTheme.bodyText2),
                          )
                        else
                          const SizedBox.shrink(),
                        ListTile(
                            title: Text(scoreDataItems['date']),
                            trailing: Text(scoreDataItems['score'])),
                        const Divider()
                      ],
                    );
                  },
                )
              else
                Column(
                  children: const [SizedBox(height: 200), Text('No scores')],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
