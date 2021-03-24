import 'dart:math';

class Unit {
  String labelLeft = '';
  String labelRight = '';
  double rangeMin = 0.0;
  double rangeMax = 0.0;

  Unit(String labelLeft,
    String labelRight,
    double rangeMin,
    double rangeMax,
  ) {
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
  Unit('INCHES', 'CM', 0.0, 100.0),
  Unit('CM', 'INCHES', 0.0, 100.0),
];

class CalculatorBrain {
  CalculatorBrain();

  int maxUnits() {
    return allUnits.length;
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
