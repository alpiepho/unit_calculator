import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:unit_calculator/components/icon_content.dart';
import 'package:unit_calculator/components/reusable_card.dart';
import 'package:unit_calculator/constants.dart';
import 'package:unit_calculator/screens/results_page.dart';
import 'package:unit_calculator/components/bottom_button.dart';
import 'package:unit_calculator/components/round_icon_button.dart';
import 'package:unit_calculator/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  int unitType = 1;
  double valueLeft = 1.0;
  double valueRight = 2.54;
  double tenX = 1.0;
  double twoX = 1.0;
  CalculatorBrain calc = CalculatorBrain();


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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              calc.getLeftLabel(unitType),
                              style: kLabelTextStyle,
                            ),
                            Text(
                                (valueLeft * tenX * twoX).toStringAsFixed(2),
                              style: kNumberTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              calc.getRightLabel(unitType),
                              style: kLabelTextStyle,
                            ),
                            Text(
                              (valueRight * tenX * twoX).toStringAsFixed(2),
                              style: kNumberTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Color(0xFF8D8E98),
                          activeTrackColor: Colors.white,
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: valueLeft,
                          min: calc.rangeMin(unitType, tenX, twoX),
                          max: calc.rangeMax(unitType, tenX, twoX),
                          onChanged: (double newValue) {
                            setState(() {
                              valueLeft = newValue;
                              valueLeft = double.parse(valueLeft.toStringAsFixed(2));
                              valueRight = calc.convert(unitType, tenX, twoX, valueLeft);
                              valueRight = double.parse(valueRight.toStringAsFixed(2));
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            (tenX * twoX).toString(),
                            style: kNumberTextStyle,
                          ),
                          Text(
                            'X',
                            style: kLabelTextStyle,
                          )
                        ],
                      ),
                     ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '10X',
                              style: kLabelTextStyle,
                            ),
                            Text(
                              tenX.toString(),
                              style: kNumberTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                    icon: FontAwesomeIcons.minus,
                                    onPressed: () {
                                      setState(() {
                                        tenX /= 10;
                                      });
                                    }),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      tenX *= 10;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '2X',
                              style: kLabelTextStyle,
                            ),
                            Text(
                              twoX.toString(),
                              style: kNumberTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(
                                      () {
                                        twoX /= 2;
                                      },
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    onPressed: () {
                                      setState(() {
                                        twoX *=2;
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BottomButton(
                buttonTitle: 'SELECT UNITS',
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(
                          bmiResult: '3333',
                          resultText: 'adadf',
                          interpretation: 'adfasdfasdf',
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
