import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okoul_quizu/features/login/views/login.dart';
import 'package:okoul_quizu/features/home/views/home_page_nav_bar.dart';
import 'package:okoul_quizu/features/home/widgets/score_chart_widget.dart';
import 'package:okoul_quizu/services/api_services.dart';
import 'package:okoul_quizu/services/shared_prefs_services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future getUserInfo() async {
    var response = await ApiServices.getUserInfo();
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var scoreData = SharedPrefsServices.getUserScore;

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

                      SharedPrefsServices.resetPrefs();
                      selectedIndex = 0;
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.account_circle_rounded,
                size: 100,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: getUserInfo(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasError ||
                          snapshot.data['mobile'] == null) {
                        return const Center(
                            child: Text("Problem loading user data"));
                      } else if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${snapshot.data['name']}",
                              style: TextStyle(
                                fontSize: 32,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${snapshot.data['mobile']}",
                              style: TextStyle(
                                fontSize: 14,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text('No data'),
                        );
                      }
                  }
                },
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 2.5),
              const SizedBox(height: 16),
              Text(
                'Your scores',
                style: TextStyle(
                  fontSize: 24,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              if (scoreData.isNotEmpty && scoreData.length > 1)
                const SizedBox(
                  width: 500,
                  height: 200,
                  child: ScoreChart(),
                ),
              if (scoreData.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: scoreData.length,
                  itemBuilder: (context, index) {
                    var scoreDataItems = jsonDecode(
                      SharedPrefsServices.getUserScore.reversed.toList()[index],
                    );
                    return Column(
                      children: [
                        if (index == 0)
                          const ListTile(
                            title: Text(
                              'Date',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              'Score',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ListTile(
                          title: Text(
                            scoreDataItems['date'],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: Text(
                            scoreDataItems['score'],
                            style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  },
                )
              else
                Column(
                  children: const [
                    SizedBox(height: 200),
                    Text('No scores'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
