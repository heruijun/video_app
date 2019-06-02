import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_app/pages/main/page_main.dart';
import 'components/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalTheme>(
      model: GlobalTheme(),
      child:
          ScopedModelDescendant<GlobalTheme>(builder: (context, child, model) {
        return MaterialApp(
          title: '喜马拉雅',
          home: MainPage(),
          theme: ThemeData(
            primarySwatch: model.current,
            textTheme: TextTheme(
              body1: TextStyle(shadows: [
                Shadow(
                    offset: Offset(0.08, 0.08),
                    blurRadius: 0.1,
                    color: Colors.black54),
              ]),
              body2: TextStyle(shadows: [
                Shadow(
                    offset: Offset(0.1, 0.1),
                    blurRadius: 0.5,
                    color: Colors.black87)
              ]),
            ),
            dividerColor: Color(0xfff5f5f5),
            iconTheme: IconThemeData(color: Color(0xFFb3b3b3)),
          ),
        );
      }),
    );
  }
}
