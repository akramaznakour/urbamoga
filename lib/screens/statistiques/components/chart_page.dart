import 'package:equinox/equinox.dart' hide Colors;
import 'package:flutter/material.dart';

import 'package:urbamoga/models/Canvas.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class ChartPage extends StatelessWidget {
  final Canvas canvas;

  const ChartPage({
    Key key,
    @required this.canvas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EqLayout(
      appBar: EqAppBar(
        title: MediaQuery.of(context).size.width < 400
            ? ''
            : canvas.title.toString().replaceAll("\\", ""),
      ),
      child: Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: EqCard(
            child: Column(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: charts.TimeSeriesChart(
                      _createData(),
                      animate: true,
                      behaviors: [
                        new charts.ChartTitle(canvas.xAxesLabel,
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle(canvas.yAxesLabel,
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                        new charts.SeriesLegend(
                          position: charts.BehaviorPosition.bottom,
                          showMeasures: true,
                          desiredMaxColumns: 1,
                        ),
                      ],
                      dateTimeFactory: const charts.LocalDateTimeFactory(),
                    )),
                Container()
              ],
            ),
            status: EqWidgetStatus.primary,
            shape: EqWidgetShape.semiRound),
      )),
    );
  }

  DateTime _dateMyFormating(String my) {
    String yyyy = "20" + my.substring(3);

    var mounths = {
      "Jan": "01",
      "Feb": "02",
      "Mar": "03",
      "Apr": "04",
      "May": "05",
      "Jun": "06",
      "Jul": "07",
      "Aug": "08",
      "Sep": "09",
      "Oct": "10",
      "Nov": "11",
      "Dec": "12",
    };

    String mm = mounths[my.substring(0, 3)];

    return DateTime(int.parse(yyyy), int.parse(mm));
  }

  List<charts.Series<TimeSeries, DateTime>> _createData() {
    List mychartcolors = [
      charts.MaterialPalette.blue.shadeDefault,
      charts.MaterialPalette.pink.shadeDefault,
      charts.MaterialPalette.purple.shadeDefault,
      charts.MaterialPalette.deepOrange.shadeDefault
    ];

    List lines = new List();

    for (var i = 0; i < canvas.datasets.length; i++) {
      List<TimeSeries> data = List();

      for (var j = 0; j < canvas.labels.length; j++) {
        if (canvas.id == "evolutionInstruction") {
          data.add(
            TimeSeries(
                _dateMyFormating(canvas.labels[j]), canvas.datasets[i].data[j]),
          );
        } else {
          data.add(
            TimeSeries(DateTime(int.parse(canvas.labels[j])),
                canvas.datasets[i].data[j]),
          );
        }
      }

      lines.add({
        'id': canvas.datasets[i].label,
        'color': mychartcolors[i],
        'data': data
      });
    }

    return lines
        .map((line) => new charts.Series<TimeSeries, DateTime>(
              id: line['id'],
              colorFn: (_, __) => line['color'],
              domainFn: (TimeSeries sales, _) => sales.time,
              measureFn: (TimeSeries sales, _) => sales.sales,
              data: line['data'],
            ))
        .toList();
  }
}

/// Sample time series data type.
class TimeSeries {
  final DateTime time;
  final int sales;

  TimeSeries(this.time, this.sales);
}
