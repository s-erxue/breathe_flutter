import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'stars.dart';

class Sessions extends StatefulWidget {
  const Sessions({Key? key}) : super(key: key);

  @override
  State<Sessions> createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  List<int> _data = [];
  int _removedStars = 0;

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    final sessions =
        (await SharedPreferences.getInstance()).getString('sessions') ?? '';
    setState(() => _data = sessions.split('').map(int.parse).toList());
    for (var i = 0; i < _data.length; i++) {
      _listKey.currentState!.insertItem(i, duration: Duration.zero);
    }
  }

  Future<void> deleteData(int index, BuildContext context) async {
    _removedStars = _data[index];
    setState(() => _data.removeAt(index));
    AnimatedList.of(context).removeItem(
      index,
      (context, animation) => FadeTransition(
        opacity: animation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stars(_removedStars),
            const IconButton(
              onPressed: null,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
    var prefs = await SharedPreferences.getInstance();
    var sessions = prefs.getString('sessions')!;
    var list = sessions.split('');
    list.removeAt(index);
    sessions = list.join();
    prefs.setString('sessions', sessions);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: AnimatedList(
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: animation,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stars(_data.length > index ? _data[index] : 5),
                IconButton(
                  onPressed: () => deleteData(index, context),
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
