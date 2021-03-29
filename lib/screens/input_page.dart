import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:unit_calculator/components/icon_content.dart';
import 'package:unit_calculator/components/reusable_card.dart';
import 'package:unit_calculator/constants.dart';
import 'package:unit_calculator/screens/settings_page.dart';
import 'package:unit_calculator/components/bottom_button.dart';
import 'package:unit_calculator/components/round_icon_button.dart';
import 'package:unit_calculator/calculator_engine.dart';

import 'package:flutter_material_pickers/flutter_material_pickers.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  int unitType = 0;
  double valueLeft = 1.0;
  double valueRight = 2.54;
  double tenX = 1.0;
  double twoX = 1.0;
  CalculatorEngine calc = CalculatorEngine();

  var selectedUnitSelect = "";
  List<String> allUnitSelects = CalculatorEngine().getUnitTypeSelectList();

  void openUnitTypeDialog() async {
    showMaterialScrollPicker(
      backgroundColor: kActiveCardColour,
      headerColor: kActiveCardColour,
      showDivider: false,
      context: context,
      title: "Pick Unit Type",
      items: allUnitSelects,
      selectedItem: selectedUnitSelect,
      onChanged: (value) {
        setState(() {
          selectedUnitSelect = value;
          unitType = this.calc.decodeUnitTypeSelectString(selectedUnitSelect);
          //TODO Save to persistent storage
          // _incrementCounter() async {
          //   SharedPreferences prefs = await SharedPreferences.getInstance();
          //   int counter = (prefs.getInt('counter') ?? 0) + 1;
          //   await prefs.setInt('counter', counter);
          // }
          if (valueRight < this.calc.rangeMin(unitType)) valueRight = this.calc.rangeMin(unitType);
          if (valueRight > this.calc.rangeMax(unitType)) valueRight = this.calc.rangeMax(unitType);

          //TODO refactor
          valueLeft = valueRight;
          valueLeft = double.parse(valueLeft.toStringAsFixed(2));
          valueRight = calc.convert(unitType, valueLeft);
          valueRight = double.parse(valueRight.toStringAsFixed(2));
        });
      },
    );
  }

  void moveToSettingsPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          unitType: unitType,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        unitType = (result < calc.maxUnits() ? result : 0);
        valueLeft = valueRight;
        valueLeft = double.parse(valueLeft.toStringAsFixed(2));
        valueRight = calc.convert(unitType, valueLeft);
        valueRight = double.parse(valueRight.toStringAsFixed(2));
      });
    }
  }

  @override
  initState() {
    super.initState();
    setState(() {
      unitType = 0;
      //TODO get initial state from persistant storage
    });
  }

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ReusableCard(
                          onPress: openUnitTypeDialog,
                          colour: kActiveCardColour,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                calc.getLabelLeft(unitType),
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
                          onPress: openUnitTypeDialog,
                          colour: kActiveCardColour,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                calc.getLabelRight(unitType),
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
                            min: calc.rangeMin(unitType),
                            max: calc.rangeMax(unitType),
                            onChanged: (double newValue) {
                              setState(() {
                                valueLeft = newValue;
                                valueLeft = double.parse(valueLeft.toStringAsFixed(2));
                                valueRight = calc.convert(unitType, valueLeft);
                                valueRight = double.parse(valueRight.toStringAsFixed(2));
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    valueLeft = calc.rangeDeltaAdjust(unitType, -1.0, valueLeft);
                                    valueLeft = double.parse(valueLeft.toStringAsFixed(2));
                                    valueRight = calc.convert(unitType, valueLeft);
                                    valueRight = double.parse(valueRight.toStringAsFixed(2));
                                  });
                                }),
                            SizedBox(
                              width: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  (tenX * twoX).toString(),
                                  style: kNumberTextStyle,
                                ),
                                Text(
                                  'X',
                                  style: kLabelTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    valueLeft = calc.rangeDeltaAdjust(unitType, 1.0, valueLeft);
                                    valueLeft = double.parse(valueLeft.toStringAsFixed(2));
                                    valueRight = calc.convert(unitType, valueLeft);
                                    valueRight = double.parse(valueRight.toStringAsFixed(2));
                                  });
                                }),
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
                  buttonTitle: 'SETTINGS',
                  onTap: () {
                    moveToSettingsPage();
                  },
                ),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ReusableCard(
                          onPress: openUnitTypeDialog,
                          colour: kActiveCardColour,
                          cardChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                calc.getLabelLeft(unitType),
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
                          onPress: openUnitTypeDialog,
                          colour: kActiveCardColour,
                          cardChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                calc.getLabelRight(unitType),
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
                  flex: 2,
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
                            min: calc.rangeMin(unitType),
                            max: calc.rangeMax(unitType),
                            onChanged: (double newValue) {
                              setState(() {
                                valueLeft = newValue;
                                valueLeft = double.parse(valueLeft.toStringAsFixed(2));
                                valueRight = calc.convert(unitType, valueLeft);
                                valueRight = double.parse(valueRight.toStringAsFixed(2));
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    valueLeft = calc.rangeDeltaAdjust(unitType, -1.0, valueLeft);
                                    valueLeft = double.parse(valueLeft.toStringAsFixed(2));
                                    valueRight = calc.convert(unitType, valueLeft);
                                    valueRight = double.parse(valueRight.toStringAsFixed(2));
                                  });
                                }),
                            SizedBox(
                              width: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  (tenX * twoX).toString(),
                                  style: kNumberTextStyle,
                                ),
                                Text(
                                  'X',
                                  style: kLabelTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    valueLeft = calc.rangeDeltaAdjust(unitType, 1.0, valueLeft);
                                    valueLeft = double.parse(valueLeft.toStringAsFixed(2));
                                    valueRight = calc.convert(unitType, valueLeft);
                                    valueRight = double.parse(valueRight.toStringAsFixed(2));
                                  });
                                }),
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
                          cardChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                '10X',
                                style: kLabelTextStyle,
                              ),
                              Text(
                                tenX.toString(),
                                style: kNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          colour: kActiveCardColour,
                          cardChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                '2X',
                                style: kLabelTextStyle,
                              ),
                              Text(
                                twoX.toString(),
                                style: kNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BottomButton(
                  buttonTitle: 'SETTINGS',
                  onTap: () {
                    moveToSettingsPage();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
