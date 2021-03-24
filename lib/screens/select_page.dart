import 'package:flutter/material.dart';
import 'package:unit_calculator/constants.dart';
import 'package:unit_calculator/components/reusable_card.dart';
import 'package:unit_calculator/components/bottom_button.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SelectPage extends StatelessWidget {
  SelectPage(
      {required this.unitType});

  // final String bmiResult;
  // final String resultText;
  final int unitType;

  // static const List<String> currenciesList = [
  //   'AUD',
  //   'BRL',
  //   'CAD',
  //   'CNY',
  //   'EUR',
  //   'GBP',
  //   'HKD',
  //   'IDR',
  //   'ILS',
  //   'INR',
  //   'JPY',
  //   'MXN',
  //   'NOK',
  //   'NZD',
  //   'PLN',
  //   'RON',
  //   'RUB',
  //   'SEK',
  //   'SGD',
  //   'USD',
  //   'ZAR'
  // ];
  // String selectedCurrency = 'AUD';
  //
  // DropdownButton<String> androidDropdown() {
  //   List<DropdownMenuItem<String>> dropdownItems = [];
  //   for (String currency in currenciesList) {
  //     var newItem = DropdownMenuItem(
  //       child: Text(currency),
  //       value: currency,
  //     );
  //     dropdownItems.add(newItem);
  //   }
  //
  //   return DropdownButton<String>(
  //     value: selectedCurrency,
  //     items: dropdownItems,
  //     onChanged: (value) {
  //       setState(() {
  //         selectedCurrency = value;
  //         //2: Call getData() when the picker/dropdown changes.
  //         getData();
  //       });
  //     },
  //   );
  // }
  //
  // CupertinoPicker iOSPicker() {
  //   List<Text> pickerItems = [];
  //   for (String currency in currenciesList) {
  //     pickerItems.add(Text(currency));
  //   }
  //
  //   return CupertinoPicker(
  //     backgroundColor: Colors.lightBlue,
  //     itemExtent: 32.0,
  //     onSelectedItemChanged: (selectedIndex) {
  //       print(selectedIndex);
  //       setState(() {
  //         //1: Save the selected currency to the property selectedCurrency
  //         selectedCurrency = currenciesList[selectedIndex];
  //         //2: Call getData() when the picker/dropdown changes.
  //         getData();
  //       });
  //     },
  //     children: pickerItems,
  //   );
  // }


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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Pick Unit',
                    style: kTitleTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        unitType.toString().toUpperCase(),
                        style: kResultTextStyle,
                      ),
                      // Text(
                      //   bmiResult,
                      //   style: kBMITextStyle,
                      // ),
                      // Text(
                      //   interpretation,
                      //   textAlign: TextAlign.center,
                      //   style: kBodyTextStyle,
                      // ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                buttonTitle: 'SELECT',
                onTap: () {
                  Navigator.pop(context, this.unitType+1);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
