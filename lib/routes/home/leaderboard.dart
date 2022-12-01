import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:okoul_quizu/main.dart';
import 'package:okoul_quizu/constants.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  Future getLeaderboard() async {
    var response = await http.get(Uri.parse(Constants.apiTopScores), headers: {
      'Authorization':
          "Bearer ${preferences.getString(Constants.prefsTokenKey)}"
    });

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    List colors = [
      const Color.fromARGB(252, 232, 183, 7),
      const Color.fromARGB(251, 172, 183, 173),
      const Color.fromARGB(250, 95, 55, 17),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 32),
            Text(
              "Leaderboard",
              style: TextStyle(fontSize: 34, color: theme.colorScheme.primary),
            ),
            FutureBuilder(
              future: getLeaderboard(),
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Column(
                      children: const [
                        SizedBox(height: 250),
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError || snapshot.data is! List) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(height: 500),
                          Text("Problem has occurred please try again later"),
                        ],
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: index >= 3
                                    ? Text("${index + 1}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500))
                                    : Icon(Icons.workspace_premium,
                                        color: colors[index]),
                                title: Text(
                                    snapshot.data[index]['name'].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400)),
                                trailing: Text(
                                  snapshot.data[index]['score'].toString(),
                                  style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              index == 2
                                  ? const Divider(thickness: 2.5)
                                  : const Divider()
                            ],
                          );
                        },
                      );
                    } else {
                      return const Text('No data');
                    }
                }
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
