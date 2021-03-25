import 'dart:math';

import 'package:flutter/cupertino.dart';

class Unit {
  String labelSelect = '';
  String labelLeft = '';
  String labelRight = '';
  double rangeMin = 0.0;
  double rangeMax = 0.0;
  var func;

  Unit(
      String labelSelect,
      String labelLeft,
      String labelRight,
      double rangeMin,
      double rangeMax,
      var func,
  ) {
    this.labelSelect = labelSelect;
    this.labelLeft = labelLeft;
    this.labelRight = labelRight;
    this.rangeMin = rangeMin;
    this.rangeMax = rangeMax;
    this.func = func;
  }

}

double convertNop(double valueLeft) {
  return valueLeft;
}

double convertInchToCm(double valueLeft) {
  return valueLeft*2.54;
}

double convertCmToInch(double valueLeft) {
  return valueLeft/2.54;
}

double convertTablespoonToTeaspoon(double valueLeft) {
  return valueLeft*3;
}

double convertTeaspoonToTablespoon(double valueLeft) {
  return valueLeft/3;
}


/*
1 tablespoon = 3 teaspoon
2 tablespoon = 1 oz
0.5 cup = 8 tablespoon
1 cup = 8 oz
1 cup = 0.5 pint
1 pint = 2 cup
1 quart = 4 cup
1 quart = 2 pint
1 gallon = 4 quart
1 gallon = 8 pint
0.5 cup = 4 tablespoon
1 stick butter = 7 tablespoon veg oil
1 clove = 0.125 teaspoon powder
 */

List<Unit> allUnits = [
  // length
  Unit('length: inches -> cm',    'inches', 'cm', 0.0, 100.0, convertInchToCm),
  Unit('length: cm -> inches',    'cm', 'inches', 0.0, 100.0, convertCmToInch),

  // volume

  // weight

  // cooking
  Unit('cooking: tbp -> tsp', 'tablespoon(tbp)', 'teaspoon(tsp)', 0.0, 10.0, convertTablespoonToTeaspoon),
  Unit('cooking: tsp -> tbp', 'teaspoon(tsp)', 'tablespoon(tbp)', 0.0, 10.0, convertTeaspoonToTablespoon),


  //Unit('AAA to BBB', 'aaa', 'bbb', 0.0, 10.0, convertNop),
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
    return allUnits[unitType].func(valueLeft);
  }
}
