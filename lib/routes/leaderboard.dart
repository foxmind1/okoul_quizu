import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:okoul_quizu/main.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  Future getLeaderboard() async {
    var response = await http.get(
        Uri.parse('https://quizu.okoul.com/TopScores'),
        headers: {'Authorization': preferences.getString('token') as String});

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    List colors = [
      const Color.fromARGB(252, 232, 183, 7),
      const Color.fromARGB(251, 172, 183, 173),
      const Color.fromARGB(250, 95, 55, 17)
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 32),
            Text("Leaderboard", style: theme.textTheme.headline4),
            // const SizedBox(height: 16),
            // ListTile(
            //   title: Row(
            //     children: [
            //       Expanded(child: Text('#', style: theme.textTheme.bodyText2)),
            //       Expanded(
            //           child: Text('Name', style: theme.textTheme.bodyText2)),
            //       const Expanded(child: Text('')),
            //       const Expanded(child: Text('')),
            //     ],
            //   ),
            //   trailing: Text('Score', style: theme.textTheme.bodyText2),
            // ),
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
                      if (snapshot.hasError) {
                        return const Text("ERROR");
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
                                      ? Text("${index + 1}")
                                      : Icon(Icons.workspace_premium,
                                          color: colors[index]),
                                  title: Text(
                                      snapshot.data[index]['name'].toString()),
                                  trailing: Text(
                                      snapshot.data[index]['score'].toString()),
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
                })),
          ]),
        ),
      ),
    );
  }
}
