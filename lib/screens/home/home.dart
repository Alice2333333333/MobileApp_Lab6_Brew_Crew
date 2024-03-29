import 'package:brew_crew/screens/home/settings_forms.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_forms.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DatabaseService(uid: '').brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
            title: Text('Brew Crew'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: const Icon(Icons.person, color: Colors.black),
                  label: const Text("Logout"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.brown[400],
                  )),
              TextButton.icon(
                  onPressed: () {
                    _showSettingPanel();
                  },
                  icon: const Icon(Icons.settings, color: Colors.black),
                  label: const Text("Settings"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.brown[400],
                  )),
            ]),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList()
        ),
      ),
    );
  }
}
