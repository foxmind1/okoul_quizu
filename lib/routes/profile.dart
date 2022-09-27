import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:okoul_quizu/home_page.dart';
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
    double inc = 0;
    List listOfScores = [];
    for (var scoreItem in scoreData) {
      listOfScores.add(jsonDecode(scoreItem));
    }

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
                        preferences.remove('show_home');
                        selectedIndex = 0;
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"))
                ],
              ),
              const SizedBox(height: 8),
              Icon(Icons.account_circle_rounded,
                  size: 100, color: theme.colorScheme.primary),
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
                                  color: theme.colorScheme.primary),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${snapshot.data['mobile']}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: theme.colorScheme.primary),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: Text('No data'));
                      }
                  }
                },
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 2.5),
              const SizedBox(height: 16),
              Text('Your scores',
                  style: TextStyle(
                      fontSize: 24, color: theme.colorScheme.primary)),
              const SizedBox(height: 24),
              if (scoreData.isNotEmpty && scoreData.length > 1)
                SizedBox(
                  width: 500,
                  height: 200,
                  child: LineChart(LineChartData(
                    minY: 0,
                    maxY: 30,
                    clipData: FlClipData(
                        top: true, bottom: true, left: true, right: true),
                    backgroundColor:
                        theme.colorScheme.tertiary.withOpacity(0.15),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            axisNameWidget: const Text(""),
                            sideTitles: SideTitles(showTitles: false))),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: theme.colorScheme.tertiary.withOpacity(0.2),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    lineBarsData: [
                      LineChartBarData(
                          spots: [
                            ...listOfScores.map((item) {
                              inc++;
                              return FlSpot(
                                  inc, int.parse(item['score']).toDouble());
                            }).toList()
                          ],
                          isCurved: true,
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.tertiary,
                              theme.colorScheme.secondary
                            ],
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.tertiary.withOpacity(0.25),
                                theme.colorScheme.secondary.withOpacity(0.25)
                              ],
                            ),
                          ),
                          dotData: FlDotData(show: false)),
                    ],
                  )),
                ),
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
                          const ListTile(
                            title: Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              'Score',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        ListTile(
                            title: Text(scoreDataItems['date'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            trailing: Text(scoreDataItems['score'],
                                style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600))),
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
