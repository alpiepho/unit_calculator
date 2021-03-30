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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeightPortrait,
          title: Text('UNIT CALCULATOR'),
        ),
        body: Center(
          child: Container(
            width: kMainContainerWidthPortrait,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "A simple web applications written with Flutter as a PWA.\n  Version: " + kVersion + " \n https://github.com/alpiepho/unit_calculator \n Copyright 2021, Thatname Group.",
                            style: kLabelTextStyle,
                          ),
                        ),
                      ],
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
                          "Settings TBD",
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                BottomButton(
                  buttonTitle: 'UPDATE',
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
    else {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeightLandscape,
          title: Text('UNIT CALCULATOR'),
        ),
        body: Center(
          child: Container(
            width: kMainContainerWidthLandscape,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "A simple web applications written with Flutter as a PWA.\n  Version: " + kVersion + " \n https://github.com/alpiepho/unit_calculator \n Copyright 2021, Thatname Group.",
                            style: kLabelTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Settings Pending",
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                BottomButton(
                  buttonTitle: 'UPDATE',
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
}
