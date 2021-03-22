import 'dart:math';

class CalculatorBrain {
  CalculatorBrain();

  String getLeftLabel(int unitType) {
    return 'INCHES';
  }

  String getRightLabel(int unitType) {
    return 'CM';
  }

  double rangeMin(int unitType, double tenX, double twoX) {
    return 1.0;
  }

  double rangeMax(int unitType, double tenX, double twoX) {
    return 100.0;
  }

  double convert(int unitType, double tenX, double twoX, double valueLeft) {
    return valueLeft*2.54;
  }

  //
  // int height = 0;
  // int weight = 0;
  //
  // late double _bmi;
  //
  // void setHeight(int height) {
  //   this.height = height;
  // }
  //
  // void setWeight(int weight) {
  //   this.weight = weight;
  // }
  //
  // String calculateBMI() {
  //   _bmi = weight / pow(height / 100, 2);
  //   return _bmi.toStringAsFixed(1);
  // }
  //
  //
  // String getResult() {
  //   if (_bmi >= 25) {
  //     return 'Overweight';
  //   } else if (_bmi > 18.5) {
  //     return 'Normal';
  //   } else {
  //     return 'Underweight';
  //   }
  // }
  //
  // String getInterpretation() {
  //   if (_bmi >= 25) {
  //     return 'You have a higher than normal body weight. Try to exercise more.';
  //   } else if (_bmi >= 18.5) {
  //     return 'You have a normal body weight. Good job!';
  //   } else {
  //     return 'You have a lower than normal body weight. You can eat a bit more.';
  //   }
  // }
}
