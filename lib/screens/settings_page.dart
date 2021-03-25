import 'package:flutter/material.dart';
import 'package:unit_calculator/constants.dart';
import 'package:unit_calculator/components/reusable_card.dart';
import 'package:unit_calculator/components/bottom_button.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage(
      {required this.unitType});

  final int unitType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UNIT CALCULATOR'),
      ),
      body: Center(
        child: Container(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Settings',
                    style: kTitleTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        unitType.toString().toUpperCase(),
                        style: kResultTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                buttonTitle: 'SELECT',
                onTap: () {
                  Navigator.pop(context, this.unitType); //NOTE: return left in as example
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
