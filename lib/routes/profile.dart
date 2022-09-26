import 'package:flutter/material.dart';
import 'package:okoul_quizu/main.dart';
import 'package:okoul_quizu/routes/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false);
              preferences.remove('token');
            },
            icon: Icon(Icons.logout, color: theme.colorScheme.primary),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.account_circle_rounded,
                      size: 100, color: theme.colorScheme.primary),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe', style: theme.textTheme.headline5),
                      const SizedBox(height: 4),
                      const Text('+966-536558233')
                    ],
                  )
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),
              Text('Your scores', style: theme.textTheme.headline4),
              ListTile(
                title: Text('Date', style: theme.textTheme.bodyText2),
                trailing: Text('Score', style: theme.textTheme.bodyText2),
              ),
              const ListTile(
                leading: Text('10 Mins ago'),
                // title: Text('John doe'),
                trailing: Text('10'),
              ),
              const Divider(),
              const ListTile(
                leading: Text('10 Hours ago'),
                // title: Text('John doe'),
                trailing: Text('9'),
              ),
              const Divider(),
              const ListTile(
                leading: Text('2 Days ago'),
                // title: Text('John doe'),
                trailing: Text('9'),
              ),
              const Divider(),
              const ListTile(
                leading: Text('2 Days ago'),
                // title: Text('John doe'),
                trailing: Text('9'),
              ),
              const Divider(),
              const ListTile(
                leading: Text('2 Days ago'),
                // title: Text('John doe'),
                trailing: Text('9'),
              ),
              const Divider(),
              const ListTile(
                leading: Text('2 Days ago'),
                // title: Text('John doe'),
                trailing: Text('9'),
              ),
              const Divider(),
              const ListTile(
                leading: Text('2 Days ago'),
                // title: Text('John doe'),
                trailing: Text('9'),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
