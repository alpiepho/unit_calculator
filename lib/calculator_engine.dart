import 'dart:math';

import 'package:flutter/cupertino.dart';

class Unit {
  String labelSelect = '';
  String labelLeft = '';
  String labelRight = '';
  double rangeMin = 0.0;
  double rangeMax = 0.0;

  Unit(
      String labelSelect,
      String labelLeft,
      String labelRight,
      double rangeMin,
      double rangeMax,
  ) {
    this.labelSelect = labelSelect;
    this.labelLeft = labelLeft;
    this.labelRight = labelRight;
    this.rangeMin = rangeMin;
    this.rangeMax = rangeMax;
  }

}

double convertInchToCm(double valueLeft) {
  return valueLeft*2.54;
}

double convertCmToInch(double valueLeft) {
  return valueLeft/2.54;
}


List<Unit> allUnits = [
  Unit('inches to cm',    'INCHES', 'CM', 0.0, 100.0),
  Unit('cm tp inches',    'CM', 'INCHES', 0.0, 100.0),
];

class CalculatorEngine {
  CalculatorEngine();

  int maxUnits() {
    return allUnits.length;
  }

  List<String> getUnitTypeSelectList() {
    List<String> result = List.empty(growable: true);
    for (Unit item in allUnits) {
      result.add(item.labelSelect);
    }
    return result;
  }

  int decodeUnitTypeSelectString(String selectString) {
    int result = 0;
    for (Unit item in allUnits) {
      if (selectString == item.labelSelect) {
        break;
      }
      result += 1;
    }
    if (result >= allUnits.length) result = 0;

    return result;
  }

  String getLabelLeft(int unitType) {
    return allUnits[unitType].labelLeft;
  }

  String getLabelRight(int unitType) {
    return allUnits[unitType].labelRight;
  }

  double rangeMin(int unitType) {
    return allUnits[unitType].rangeMin;
  }

  double rangeMax(int unitType) {
    return allUnits[unitType].rangeMax;
  }

  double convert(int unitType, double valueLeft) {
    double result = valueLeft;
    switch (unitType) {
      case 0:
        {
          result = convertInchToCm(valueLeft);
        }
        break;
      case 1:
      {
        result = convertCmToInch(valueLeft);
      }
      break;
    }
    return result;
  }

}
