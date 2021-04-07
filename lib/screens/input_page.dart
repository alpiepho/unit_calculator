import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unit_calculator/calculator_engine.dart';
import 'package:unit_calculator/components/bottom_button.dart';
import 'package:unit_calculator/components/reusable_card.dart';
import 'package:unit_calculator/components/round_icon_button.dart';
import 'package:unit_calculator/constants.dart';
import 'package:unit_calculator/screens/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  int _unitType = 0;
  double _valueLeft = 1.0;
  double _valueRight = 2.54;
  double _tenX = 1.0;
  double _twoX = 1.0;
  CalculatorEngine _calc = CalculatorEngine();

  var selectedUnitSelect = "";
  List<String> allUnitSelects = CalculatorEngine().getUnitTypeSelectList();

  _readPersistentData() async {
    final prefs = await SharedPreferences.getInstance();
    final unitType = prefs.getInt('unitType') ?? 0;
    final valueLeft = prefs.getDouble('valueLeft') ?? 1.0;
    final valueRight = prefs.getDouble('valueRight') ?? 2.54;
    final tenX = prefs.getDouble('tenX') ?? 1.0;
    final twoX = prefs.getDouble('twoX') ?? 1.0;
    //print('_readPersistentData: $unitType');
    //print('_readPersistentData: valueLeft');
    //print('_readPersistentData: valueRight');
    //print('_readPersistentData: tenX');
    //print('_readPersistentData: twoX');
    setState(() {
      _unitType = unitType;
      _valueLeft = valueLeft;
      _valueRight = valueRight;
      _tenX = tenX;
      _twoX = twoX;
    });
  }

  _savePersistentData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('unitType', _unitType);
    prefs.setDouble('valueLeft', _valueLeft);
    prefs.setDouble('valueRight', _valueRight);
    prefs.setDouble('tenX', _tenX);
    prefs.setDouble('twoX', _twoX);
    //print('_savePersistentData $_unitType');
    //print('_savePersistentData _valueLeft');
    //print('_savePersistentData _valueRight');
    //print('_savePersistentData _tenX');
    //print('_savePersistentData _twoX');
  }


  void _updateValueLeftEtc(double newValue) {
    _valueLeft = newValue;
    _valueLeft = double.parse(_valueLeft.toStringAsFixed(2));
    _valueRight = _calc.convert(_unitType, _valueLeft);
    _valueRight = double.parse(_valueRight.toStringAsFixed(2));
    _savePersistentData();
  }
  
  void _openUnitTypeDialog() async {
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
          _unitType = this._calc.decodeUnitTypeSelectString(selectedUnitSelect);
          if (_valueRight < this._calc.rangeMin(_unitType)) _valueRight = this._calc.rangeMin(_unitType);
          if (_valueRight > this._calc.rangeMax(_unitType)) _valueRight = this._calc.rangeMax(_unitType);
          _updateValueLeftEtc(_valueRight);
        });
      },
    );
  }

  void _moveToSettingsPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          unitType: _unitType,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _unitType = (result < _calc.maxUnits() ? result : 0);
        _updateValueLeftEtc(_valueRight);
      });
    }
  }

  @override
  initState() {
    super.initState();
    _readPersistentData();
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeightPortrait,
          title: Text(kToolbarTitle),
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
                          onPress: _openUnitTypeDialog,
                          colour: kActiveCardColour,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _calc.getLabelLeft(_unitType),
                                style: kLabelTextStyle,
                              ),
                              Text(
                                (_valueLeft * _tenX * _twoX).toStringAsFixed(2),
                                style: kNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          onPress: _openUnitTypeDialog,
                          colour: kActiveCardColour,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _calc.getLabelRight(_unitType),
                                style: kLabelTextStyle,
                              ),
                              Text(
                                (_valueRight * _tenX * _twoX).toStringAsFixed(2),
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
                            value: _valueLeft,
                            min: _calc.rangeMin(_unitType),
                            max: _calc.rangeMax(_unitType),
                            onChanged: (double newValue) {
                              setState(() {
                                _updateValueLeftEtc(newValue);
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
                                    _updateValueLeftEtc(_calc.rangeDeltaAdjust(_unitType, -1.0, _valueLeft));
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
                                  (_tenX * _twoX).toString(),
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
                                    _updateValueLeftEtc(_calc.rangeDeltaAdjust(_unitType, 1.0, _valueLeft));
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
                                _tenX.toString(),
                                style: kNumberTextStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RoundIconButton(
                                      icon: FontAwesomeIcons.minus,
                                      onPressed: () {
                                        setState(() {
                                          _tenX /= 10;
                                        });
                                      }),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    onPressed: () {
                                      setState(() {
                                        _tenX *= 10;
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
                                _twoX.toString(),
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
                                          _twoX /= 2;
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
                                          _twoX *=2;
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
                    _moveToSettingsPage();
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
          title: Text(kToolbarTitle),
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
                          onPress: _openUnitTypeDialog,
                          colour: kActiveCardColour,
                          cardChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _calc.getLabelLeft(_unitType),
                                style: kLabelTextStyle,
                              ),
                              Text(
                                (_valueLeft * _tenX * _twoX).toStringAsFixed(2),
                                style: kNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          onPress: _openUnitTypeDialog,
                          colour: kActiveCardColour,
                          cardChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _calc.getLabelRight(_unitType),
                                style: kLabelTextStyle,
                              ),
                              Text(
                                (_valueRight * _tenX * _twoX).toStringAsFixed(2),
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
                            value: _valueLeft,
                            min: _calc.rangeMin(_unitType),
                            max: _calc.rangeMax(_unitType),
                            onChanged: (double newValue) {
                              setState(() {
                                _updateValueLeftEtc(newValue);
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
                                    _updateValueLeftEtc(_calc.rangeDeltaAdjust(_unitType, -1.0, _valueLeft));
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
                                  (_tenX * _twoX).toString(),
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
                                    _updateValueLeftEtc(_calc.rangeDeltaAdjust(_unitType, 1.0, _valueLeft));
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
                                          _tenX /= 10;
                                        });
                                      }),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    onPressed: () {
                                      setState(() {
                                        _tenX *= 10;
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
                                _tenX.toString(),
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
                                          _twoX /= 2;
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
                                          _twoX *=2;
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
                                _twoX.toString(),
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
                    _moveToSettingsPage();
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
