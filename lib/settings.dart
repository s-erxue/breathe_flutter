import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _storeData = true;
  var _duration = 2500;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      _storeData = prefs.getBool('record') ?? true;
      _duration = prefs.getInt('time') ?? 2500;
    });
  }

  Future<void> setStoreData(bool record) async {
    (await SharedPreferences.getInstance()).setBool('record', record);
  }

  Future<void> setDuration(int duration) async {
    (await SharedPreferences.getInstance()).setInt('time', duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathe'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Store data'),
                value: _storeData,
                onChanged: (v) {
                  setState(() => _storeData = v);
                  setStoreData(v);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Breath duration'),
                  DropdownButton<int>(
                    value: _duration,
                    onChanged: (v) {
                      setState(() => _duration = v ?? _duration);
                      setDuration(_duration);
                    },
                    items: const [
                      DropdownMenuItem(value: 2000, child: Text('2')),
                      DropdownMenuItem(value: 2500, child: Text('2.5')),
                      DropdownMenuItem(value: 3000, child: Text('3')),
                      DropdownMenuItem(value: 4000, child: Text('4')),
                      DropdownMenuItem(value: 5000, child: Text('5')),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      applicationName: 'Breathe',
                      applicationVersion: '1.0.0'
                  );
                },
                child: const Text('About'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
