import 'package:flutter/material.dart';
import 'package:unit_calculator/screens/input_page.dart';
import 'package:flutter/services.dart';

void main() {
  //runApp(UnitCalculator());

  // We need to call it manually,
  // because we going to call setPreferredOrientations()
  // before the runApp() call
  WidgetsFlutterBinding.ensureInitialized();

  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(UnitCalculator()));

}

class UnitCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Unit Calculator",
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        accentColor: Color(0xFFEB1555),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        backgroundColor: Color(0xFF0A0E21),
      ),
      home: InputPage(),
    );
  }
}
