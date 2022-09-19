import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:okoul_quizu/routes/home.dart';
import 'package:okoul_quizu/routes/leaderboard.dart';
import 'package:okoul_quizu/routes/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

int _selectedIndex = 0;

class _HomeState extends State<Home> {
  final List<Widget> _pages = [
    const HomePage(),
    const LeaderboardPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: GNav(
          backgroundColor: Colors.white,
          color: Theme.of(context).primaryColorLight,
          activeColor: Theme.of(context).primaryColorDark,
          tabBackgroundColor: Theme.of(context).highlightColor,
          padding: const EdgeInsets.all(16),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.leaderboard,
              text: 'Leaderboards',
            ),
            GButton(
              icon: Icons.account_circle,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

Widget home(BuildContext context) {
  return Scaffold(
      body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome to QuizU',
              style: Theme.of(context).primaryTextTheme.bodyText1),
        ],
      ),
    ],
  ));
}
