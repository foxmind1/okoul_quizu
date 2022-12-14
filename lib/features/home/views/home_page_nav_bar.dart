import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:okoul_quizu/features/home/views/home.dart';
import 'package:okoul_quizu/features/home/views/leaderboard.dart';
import 'package:okoul_quizu/features/home/views/profile.dart';

class HomePageNavBar extends StatefulWidget {
  const HomePageNavBar({Key? key}) : super(key: key);

  @override
  State<HomePageNavBar> createState() => _HomePageNavBarState();
}

int selectedIndex = 0;

class _HomePageNavBarState extends State<HomePageNavBar> {
  final List<Widget> _pages = [
    const HomePage(),
    const LeaderboardPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: _pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: GNav(
          backgroundColor: theme.colorScheme.background,
          color: theme.primaryColor.withAlpha(200),
          activeColor: theme.primaryColor,
          tabBackgroundColor: theme.highlightColor,
          padding: const EdgeInsets.all(16),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.leaderboard,
              text: 'Leaderboard',
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
