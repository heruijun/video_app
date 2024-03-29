import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalTheme extends Model {
  static const _key = 'theme_index';
  int _index = 0;

  GlobalTheme() {
    SharedPreferences.getInstance().then((preference) {
      _index = preference.getInt(_key) ?? 0;
      if (_index < 0 || _index > all.length) {
        _index = 0;
      }
      notifyListeners();
    });
  }

  static GlobalTheme of(BuildContext context, {bool rebuildOnChange = true}) {
    return ScopedModel.of<GlobalTheme>(context,
        rebuildOnChange: rebuildOnChange);
  }

  MaterialColor get current => _swatchList[_index];

  List<MaterialColor> get all => _swatchList;

  void setTheme(int index) {
    _index = index;
    notifyListeners();
    SharedPreferences.getInstance().then((preference) {
      preference.setInt(_key, _index);
    });
  }
}

const _swatchNeteaseRed = const MaterialColor(0xFFe85951, {
  900: const Color(0xFFae2a20),
  800: const Color(0xFFbe332a),
  700: const Color(0xFFcb3931),
  600: const Color(0xFFdd4237),
  500: const Color(0xFFec4b38),
  400: const Color(0xFFe85951),
  300: const Color(0xFFdf7674),
  200: const Color(0xFFea9c9a),
  100: const Color(0xFFfcced2),
  50: const Color(0xFFfeebee),
});

const _swatchList = const [
  _swatchNeteaseRed,
  Colors.green,
  Colors.amber,
  Colors.teal
];