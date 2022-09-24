import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 32),
            Text("Leaderboard", style: theme.textTheme.headline4),
            const SizedBox(height: 16),
            ListTile(
              title: Row(
                children: [
                  Expanded(child: Text('#', style: theme.textTheme.bodyText2)),
                  Expanded(
                      child: Text('Name', style: theme.textTheme.bodyText2)),
                  const Expanded(child: Text('')),
                  const Expanded(child: Text('')),
                ],
              ),
              trailing: Text('Score', style: theme.textTheme.bodyText2),
            ),
            const ListTile(
              leading: Icon(
                Icons.workspace_premium,
                color: Color.fromARGB(252, 232, 183, 7),
              ),
              title: Text('John doe'),
              trailing: Text('10'),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.workspace_premium,
                  color: Color.fromARGB(251, 172, 183, 173)),
              title: Text('John doe'),
              trailing: Text('9'),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.workspace_premium,
                  color: Color.fromARGB(250, 95, 55, 17)),
              title: Text('John doe'),
              trailing: Text('9'),
            ),
            const Divider(thickness: 2.5),
            const ListTile(
              leading: Text('4'),
              title: Text('John doe'),
              trailing: Text('8'),
            ),
            const Divider(),
            const ListTile(
              leading: Text('5'),
              title: Text('John doe'),
              trailing: Text('7'),
            ),
            const Divider(),
            const ListTile(
              leading: Text('6'),
              title: Text('John doe'),
              trailing: Text('7'),
            ),
            const Divider(),
            const ListTile(
              leading: Text('7'),
              title: Text('John doe'),
              trailing: Text('7'),
            ),
            const Divider(),
            const ListTile(
              leading: Text('8'),
              title: Text('John doe'),
              trailing: Text('6'),
            ),
            const Divider(),
            const ListTile(
              leading: Text('9'),
              title: Text('John doe'),
              trailing: Text('6'),
            ),
            const Divider(),
            const ListTile(
              leading: Text('10'),
              title: Text('John doe'),
              trailing: Text('6'),
            ),
            const Divider(),
          ]),
        ),
      ),
    );
  }
}
