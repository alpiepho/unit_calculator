

class Unit {
  String labelSelect = '';
  String labelLeft = '';
  String labelRight = '';
  double rangeMin = 0.0;
  double rangeMax = 0.0;
  double rangeDelta = 0.0;
  var func;

  Unit(
      String labelSelect,
      String labelLeft,
      String labelRight,
      double rangeMin,
      double rangeMax,
      double rangeDelta,
      var func,
  ) {
    this.labelSelect = labelSelect;
    this.labelLeft = labelLeft;
    this.labelRight = labelRight;
    this.rangeMin = rangeMin;
    this.rangeMax = rangeMax;
    this.rangeDelta = rangeDelta;
    this.func = func;
  }

}

List<Unit> allUnits = [
  //Unit('nop: nop -> nop', 'nop', 'nop', 0.0, 10.0, 0.1, (double valueLeft) {return valueLeft;}),

  // cooking
  //   1 tablespoon = 3 teaspoon
  //   2 tablespoon = 1 oz
  //   0.5 cup = 8 tablespoon
  //   1 cup = 8 oz
  //   1 cup = 0.5 pint
  //   1 pint = 2 cup
  //   1 quart = 4 cup
  //   1 quart = 2 pint
  //   1 gallon = 8 pint
  //   1 gallon = 4 quart
  //   1 stick butter = 7 tablespoon veg oil
  //   1 clove = 0.125 teaspoon powder
  Unit('cooking: tbsp -> tsp', 'tbsp', 'tsp', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft*3; }),
  Unit('cooking: tsp -> tbsp', 'tsp', 'tbsp', 0.0, 30.0, 0.1, (double valueLeft) { return valueLeft/3; }),

  Unit('cooking: cup -> tbsp', 'cup', 'tbsp', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft*16.0; }),
  Unit('cooking: tbsp -> cup', 'tbsp', 'cup', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/16.0; }),

  Unit('cooking: cup -> oz', 'cup', 'oz', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft*8.0; }),
  Unit('cooking: oz -> cup', 'oz', 'cup', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/8.0; }),

  Unit('cooking: cup -> pint', 'cup', 'pint', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft*0.5; }),
  Unit('cooking: pint -> cup', 'pint', 'cup', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft/0.5; }),

  Unit('cooking: cup -> quart', 'cup', 'quart', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft*0.25; }),
  Unit('cooking: quart -> cup', 'quart', 'cup', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft/0.25; }),

  Unit('cooking: pint -> quart', 'pint', 'quart', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft*0.5; }),
  Unit('cooking: quart -> pint', 'quart', 'pint', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft/0.5; }),

  Unit('cooking: pint -> gallon', 'pint', 'gallon', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft/8.0; }),
  Unit('cooking: gallon -> pint', 'gallon', 'pint', 0.0, 80.0, 1.0, (double valueLeft) { return valueLeft*8.0; }),

  Unit('cooking: quart -> gallon', 'quart', 'gallon', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft/4.0; }),
  Unit('cooking: gallon -> quart', 'gallon', 'quart', 0.0, 40.0, 1.0, (double valueLeft) { return valueLeft*4.0; }),

  Unit('cooking: stick -> tbsp oil', 'stick', 'tbsp oil', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft*7.0; }),
  Unit('cooking: tbsp oil -> stick', 'tbsp oil', 'stick', 0.0, 70.0, 1.0, (double valueLeft) { return valueLeft/7.0; }),

  Unit('cooking: clove -> powder', 'clove', 'powder', 0.0, 10.0, 0.1, (double valueLeft) { return valueLeft/8.0; }),
  Unit('cooking: powder -> clove', 'powder', 'clove', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*8.0; }),

  // length
  Unit('length: inches -> cm',    'inches', 'cm', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*2.54; }),
  Unit('length: cm -> inches',    'cm', 'inches', 0.0, 300.0, 1.0, (double valueLeft) { return valueLeft/2.54; }),

  // volume

  // weight

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

  double rangeDelta(int unitType) {
    return allUnits[unitType].rangeDelta;
  }

  double rangeDeltaAdjust(int unitType, double direction, double valueLeft) {
    double delta = allUnits[unitType].rangeDelta;
    double result = valueLeft + (direction * delta);

    // need to adjust by /delta, .floorToDouble(), then *delta to 'snap' to next delta
    result = result/delta;
    result = result.roundToDouble();
    result = result*delta;

    if (result < allUnits[unitType].rangeMin) result = allUnits[unitType].rangeMin;
    if (result > allUnits[unitType].rangeMax) result = allUnits[unitType].rangeMax;
    return result;
  }

  double convert(int unitType, double valueLeft) {
    return allUnits[unitType].func(valueLeft);
  }
}
