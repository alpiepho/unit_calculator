

import 'package:flutter/cupertino.dart';

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

/*
https://www.isa.org/getmedia/192f7bda-c77c-480a-8925-1a39787ed098/CCST-Conversions-document.pdf
Table 2 Length Units
Table 3 Area Units
Table 4 Volume Units
Table 5 Mass Units
Table 6 Density Units
Table 7 Volumetric Liquid Flow Units
Table 8 Volumetric Gas Flow Units
Table 9 Mass FlowUnits
Table 10 High Pressure Units
Table 11 Low Pressure Units
Table 12 Speed Units
Table 13 Torque Units
Table 14 Dynamic ViscosityUnits
Table 15 Kinematic Viscosity Units
Table 16 Temperature Conversion Formulas
*/
  
List<Unit> allUnits = [
  // TODO: verify cooking
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

  // fun
  Unit('fun: balls -> walks', 'balls', 'walks', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/4.0; }),
  Unit('fun: strikes -> outs', 'strikes', 'outs', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/3.0; }),

  // area
  Unit('area: in^2 -> ft^2',    'in^2', 'ft^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/144.0; }),
  Unit('area: ft^2 -> in^2',    'ft^2', 'in^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*144.0; }),

  Unit('area: ft^2 -> yd^2',    'ft^2', 'yd^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/9.0; }),
  Unit('area: yd^2 -> ft^2',    'yd^2', 'ft^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*9.0; }),

  Unit('area: in^2 -> yd^2',    'in^2', 'yd^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/(9.0*144.0); }),
  Unit('area: yd^2 -> in^2',    'yd^2', 'in^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*(9.0*144.0); }),

  Unit('area: yd^2 -> mi^2',    'yd^2', 'mi^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/(3.098*1000000); }),
  Unit('area: mi^2 -> yd^2',    'mi^2', 'yd^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*(3.098*1000000); }),

  Unit('area: ft^2 -> mi^2',    'ft^2', 'mi^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/(2.788*10000000); }),
  Unit('area: mi^2 -> ft^2',    'mi^2', 'ft^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*(2.788*10000000); }),

  Unit('area: ft^2 -> acre',    'ft^2', 'acre', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/43560.0; }),
  Unit('area: acre -> ft^2',    'acre', 'ft^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*43560.0; }),

  Unit('area: yd^2 -> acre',    'yd^2', 'acre', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/4840.0; }),
  Unit('area: acre -> yd^2',    'acre', 'yd^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*4840.0; }),

  Unit('area: mi^2 -> acre',    'mi^2', 'acre', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*640.0; }),
  Unit('area: acre -> mi^2',    'acre', 'mi^2', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/640.0; }),

  // acre sqyd
  // acre sqft



  // length
  Unit('length: inches -> cm',    'inches', 'cm', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*2.54; }),
  Unit('length: cm -> inches',    'cm', 'inches', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/2.54; }),

  Unit('length: inches -> ft',    'inches', 'ft', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/12.0; }),
  Unit('length: ft -> inches',    'ft', 'inches', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*12.0; }),

  Unit('length: ft -> yd',    'ft', 'yd', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/3.0; }),
  Unit('length: yd -> ft',    'yd', 'ft', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*3.0; }),

  Unit('length: ft -> mi',    'ft', 'mi', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/5280.0; }),
  Unit('length: mi -> ft',    'mi', 'ft', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*5280.0; }),

  Unit('length: yd -> mi',    'yd', 'mi', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/(5280.0/3.0); }),
  Unit('length: mi -> yd',    'yd', 'yd', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*(5280.0/3.0); }),

  Unit('length: yd -> m',    'yd', 'm', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/1.09361; }),
  Unit('length: m -> yd',    'm', 'yd', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*1.09361; }),

  Unit('length: m -> mi',    'yd', 'mi', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/1609.34; }),
  Unit('length: mi -> m',    'mi', 'm', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*1609.34; }),

  // SI units
  Unit('si: googol(10e100)', 'googol(10e100)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: yotta(10e18)',  'yotta(10e18)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: zetta(10e21)',  'zetta(10e21)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: exa(10e18)',    'exa(10e18)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: peta(10e15)',   'peta(10e15)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: tera(10e12)',   'tera(10e12)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: giga(10e9)',    'giga(10e9)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: mega(10e6)',    'mega(10e6)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: kilo(10e3)',    'kilo(10e3)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: hecto(10e2)',   'hecto(10e2)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: deca(10e1)',    'deca(10e1)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: deci(10e-1)',   'deci(10e-1)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: centi(10e-2)',  'centi(10e-2)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: milli(10e-3)',  'milli(10e-3)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: micro(10e-6)',  'micro(10e-6)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: nano(10e-9)',   'nano(10e-9)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: pico(10e-12)',  'pico(10e-12)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: femto(10e-15)', 'femto(10e-15)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: atto(10e-18)',  'atto(10e-18)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  //                               ^
  Unit('si: zepto(10e-21)', 'atto(10e-18)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),
  Unit('si: yocto(10e-24)', 'yocto(10e-24)', '', 0.0, 10.0, 1.0, (double valueLeft) { return valueLeft*1; }),


  // temperature
  Unit('temp: F -> C',    'F', 'C', -200.0, 300.0, 1.0, (double valueLeft) { return (5.0/9.0)*(valueLeft - 32.0); }),
  Unit('temp: C -> F',    'C', 'F', -100.0, 200.0, 1.0, (double valueLeft) { return (9.0/5.0)*(valueLeft) + 32.0; }),

  Unit('temp: C -> K',    'C', 'K', -100.0, 200.0, 1.0, (double valueLeft) { return valueLeft + 273.0; }),
  Unit('temp: K -> C',    'K', 'C', 0.0, 500.0, 1.0, (double valueLeft) { return valueLeft - 273.0; }),

  Unit('temp: F -> K',    'F', 'K', -200.0, 300.0, 1.0, (double valueLeft) { return (5.0/9.0)*(valueLeft - 32.0) + 273.0; }),
  Unit('temp: K -> F',    'K', 'F', 0.0, 500.0, 1.0, (double valueLeft) { return (9.0/5.0)*(valueLeft - 273) + 32.0; }),

  // volume
  Unit('volume: gallon -> liter',    'gallon', 'liter', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*3.78541; }),
  Unit('volume: liter -> gallon',    'liter', 'gallon', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/3.78541; }),

  // weight
  Unit('volume: lb -> kg',    'lb', 'kg', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft/2.205; }),
  Unit('volume: kg -> lb',    'kg', 'lb', 0.0, 100.0, 1.0, (double valueLeft) { return valueLeft*2.205; }),

  Unit('google',  'google', 'google', 0.0, 100.0, 1.0, (double valueLeft) { return 0; }),
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
