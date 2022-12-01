import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:okoul_quizu/routes/home/home.dart';
import 'package:okoul_quizu/routes/home/leaderboard.dart';
import 'package:okoul_quizu/routes/home/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

int selectedIndex = 0;

class _NavBarState extends State<NavBar> {
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
