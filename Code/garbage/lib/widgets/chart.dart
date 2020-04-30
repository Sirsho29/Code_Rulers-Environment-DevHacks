import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:garbage/models/waste_items.dart';

class HomeChart extends StatelessWidget {
  final List<WasteItems> data;

  final String title;

  HomeChart({this.data, this.title});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<WasteItems, String>> items = [
      charts.Series(
        id: 'wastes',
        data: data,
        domainFn: (WasteItems items, _) => items.date,
        measureFn: (WasteItems items, _) => items.countWasteItems,
      )
    ];

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: charts.BarChart(items),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(child: Text(title)),
          ),
        ],
      ),
    );
  }
}
