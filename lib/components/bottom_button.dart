import 'package:flutter/material.dart';
import 'package:unit_calculator/constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.onTap, required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return GestureDetector(
        onTap: onTap as void Function()?,
        child: Container(
          child: Center(
            child: Text(
              buttonTitle,
              style: kLargeButtonTextStyle,
            ),
          ),
          color: kBottomContainerColour,
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.only(bottom: 20.0),
          width: double.infinity,
          height: kBottomContainerHeightPortrait,
        ),
      );
    }
    else {
      return GestureDetector(
        onTap: onTap as void Function()?,
        child: Container(
          child: Center(
            child: Text(
              buttonTitle,
              style: kLargeButtonTextStyle,
            ),
          ),
          color: kBottomContainerColour,
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.only(bottom: 10.0),
          width: double.infinity,
          height: kBottomContainerHeightLandscape,
        ),
      );
    }
   }
}
