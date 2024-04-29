// ignore_for_file: cascade_invocations, unnecessary_new, prefer_single_quotes, prefer_const_constructors, prefer_int_literals, sized_box_for_whitespace, prefer_if_elements_to_conditional_expressions, unnecessary_string_interpolations

import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/InPaymentChartapi/IncomingPaymentApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/SalesChartapi/SalesChartApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/VolumeChartapi/VolumeChartApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/InPaymentChartModal/InPaymentChartModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/SalesChart_modal/SalesChart_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/VolumeChartModal/VolumeChartModal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

class DepotPerformance extends StatefulWidget {
  final String title;

  const DepotPerformance({required this.title, Key? key}) : super(key: key);

  @override
  State<DepotPerformance> createState() => _DepotPerformanceState();
}

class _DepotPerformanceState extends State<DepotPerformance> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<SalesChartData> salesdetails = [];
  List<SalesChartData> salesdata = [];
  List<InPaymentChartData> collectiondetails = [];
  List<InPaymentChartData> collectiondata = [];
  List<VolumeChartData> volumedetails = [];
  List<VolumeChartData> volumedata = [];
  bool isLoading = true;
  int count = 0;
  String? salesexp;
  String? collectionexp;
  String? volumeexp;
  @override
  void initState() {
    saleschartapi();
    Collectionchartapi();
    Volumechartapi();
  }

  void saleschartapi() {
    GetSalesChartApi.getSalesChartData().then((value) {
      count++;
      setState(() {
        if (value.statuscode <= 210 && value.statuscode >= 200) {
          if (value.CustomerData != null) {
            setState(() {
              salesdetails = value.CustomerData!;
              salesdata = salesdetails;
              isLoading = false;
              generateChart(salesdata);
            });
          } else if (value.CustomerData == null) {
            setState(() {
              print("Api not connectted");
              // isLoading = false;
              salesexp = "No data found";
            });
          }
        } else {
          print(" not connectted");
          print(value.statuscode);
          salesexp = "something went wrong..";
        }
      });
    });
  }

  void Collectionchartapi() {
    GetInPaymentChartApi.getInPaymentChartData().then((value) {
      count++;
      setState(() {
        if (value.statusCode <= 210 && value.statusCode >= 200) {
          if (value.CustomerData != null) {
            setState(() {
              collectiondetails = value.CustomerData!;
              collectiondata = collectiondetails;
              isLoading = false;
              generateCollectionChart(collectiondata);
            });
          } else if (value.CustomerData == null) {
            setState(() {
              // isLoading = false;
              collectionexp = "No data found";
            });
          }
        } else {
          collectionexp = "something went wrong..";
        }
      });
    });
  }

  void Volumechartapi() {
    GetVolumeChartApi.getVolumeChartData().then((value) {
      count++;
      setState(() {
        if (value.statuscode <= 210 && value.statuscode >= 200) {
          if (value.CustomerData != null) {
            setState(() {
              volumedetails = value.CustomerData!;
              volumedata = volumedetails;
              isLoading = false;
              generateVolumeChart(volumedata);
            });
          } else if (value.CustomerData == null) {
            setState(() {
              // isLoading = false;
              volumeexp = "No data found";
            });
          }
        } else {
          volumeexp = "Something Went Wrong";
        }
      });
    });
  }

  List<ChartRecord> targetsales = [];
  List<ChartRecord> achsales = [];

  List<CollectionChartRecord> col_targetsales = [];
  List<CollectionChartRecord> col_achsales = [];

  List<VolumeChartRecord> vol_targetsales = [];
  List<VolumeChartRecord> vol_achsales = [];
  double s = 1.4;
  double c = 1.4;
  double v = 1.4;
  void generateChart(List<SalesChartData> chartslist) {
    targetsales.clear();
    achsales.clear();
    setState(() {
      for (var i = 0; i < chartslist.length; i++) {
        targetsales.add(
          ChartRecord(
            name: chartslist[i].slpname,
            sales: chartslist[i].targetSales,
            barColor: Colors.red,
          ),
        );
        achsales.add(
          ChartRecord(
            name: chartslist[i].slpname,
            sales: chartslist[i].achSales,
            barColor: Colors.red.shade200,
          ),
        );
      }
    });
  }

  void generateCollectionChart(List<InPaymentChartData> chartslist) {
    col_targetsales.clear();
    col_achsales.clear();
    setState(() {
      for (var i = 0; i < chartslist.length; i++) {
        col_targetsales.add(
          CollectionChartRecord(
            name: chartslist[i].slpname,
            collection: chartslist[i].targetSales,
            barColor: Colors.blue,
          ),
        );
        col_achsales.add(
          CollectionChartRecord(
            name: chartslist[i].slpname,
            collection: chartslist[i].achSales,
            barColor: Colors.blue.shade200,
          ),
        );
      }
    });
  }

  void generateVolumeChart(List<VolumeChartData> chartslist) {
    vol_targetsales.clear();
    vol_achsales.clear();
    setState(() {
      for (var i = 0; i < chartslist.length; i++) {
        vol_targetsales.add(
          VolumeChartRecord(
            name: chartslist[i].slpname,
            volume: chartslist[i].targetSales,
            barColor: Colors.green,
          ),
        );
        vol_achsales.add(
          VolumeChartRecord(
            name: chartslist[i].slpname,
            volume: chartslist[i].achSales,
            barColor: Colors.green.shade200,
          ),
        );
      }
    });
  }

  List<charts.Series<ChartRecord, String>> cretaedChart() {
    return [
      new charts.Series<ChartRecord, String>(
        // domainFormatterFn: ,

        id: 'Desktop',
        domainFn: (ChartRecord sales, _) => sales.name,
        measureFn: (ChartRecord sales, _) => sales.sales,
        data: targetsales,

        colorFn: (ChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        labelAccessorFn: (ChartRecord sales, _) =>
            '${sales.sales.toStringAsFixed(0)}',
      ),
      new charts.Series<ChartRecord, String>(
        id: 'Tablet',
        domainFn: (ChartRecord sales, _) => sales.name,
        measureFn: (ChartRecord sales, _) => sales.sales,
        data: achsales,
        colorFn: (ChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        labelAccessorFn: (ChartRecord sales, _) =>
            '${sales.sales.toStringAsFixed(0)}',
      ),
    ];
  }

  List<charts.Series<CollectionChartRecord, String>> CollectionChart() {
    return [
      new charts.Series<CollectionChartRecord, String>(
        id: 'Desktop',
        domainFn: (CollectionChartRecord sales, _) => sales.name,
        measureFn: (CollectionChartRecord sales, _) => sales.collection,
        data: col_targetsales,
        colorFn: (CollectionChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        labelAccessorFn: (CollectionChartRecord sales, _) =>
            '${sales.collection.toStringAsFixed(0)}',
      ),
      new charts.Series<CollectionChartRecord, String>(
        id: 'Tablet',
        domainFn: (CollectionChartRecord sales, _) => sales.name,
        measureFn: (CollectionChartRecord sales, _) => sales.collection,
        colorFn: (CollectionChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        data: col_achsales,
        labelAccessorFn: (CollectionChartRecord sales, _) =>
            '${sales.collection.toStringAsFixed(0)}',
      ),
    ];
  }

  List<charts.Series<VolumeChartRecord, String>> VolumeChart() {
    return [
      new charts.Series<VolumeChartRecord, String>(
        id: 'Desktop',
        domainFn: (VolumeChartRecord sales, _) => sales.name,
        measureFn: (VolumeChartRecord sales, _) => sales.volume,
        colorFn: (VolumeChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        data: vol_targetsales,
        labelAccessorFn: (VolumeChartRecord sales, _) =>
            '${sales.volume.toStringAsFixed(0)}',
      ),
      new charts.Series<VolumeChartRecord, String>(
        id: 'Tablet',
        domainFn: (VolumeChartRecord sales, _) => sales.name,
        colorFn: (VolumeChartRecord sales, _) =>
            charts.ColorUtil.fromDartColor(sales.barColor),
        measureFn: (VolumeChartRecord sales, _) => sales.volume,
        data: vol_achsales,
        labelAccessorFn: (VolumeChartRecord sales, _) =>
            '${sales.volume.toStringAsFixed(0)}',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: (salesdata.isEmpty &&
              collectiondata.isEmpty &&
              volumedata.isEmpty &&
              count < 3)
          ? Center(
              child: Center(child: CircularProgressIndicator()),
            )
          : (salesdata.isEmpty &&
                  collectiondata.isEmpty &&
                  volumedata.isEmpty &&
                  count == 3)
              ? Center(
                  child: Text("No data found"),
                )
              : Container(
                  height: Screens.heigth(context),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        salesdata.isEmpty
                            ? Container(
                                // color: theme.primaryColor.withOpacity(0.5),
                                width: Screens.width(context),
                                height: Screens.heigth(context) * 0.28,
                                child: Center(
                                  child: Text("$salesexp"),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Sales",
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      // scrollDirection: Axis.horizontal,
                                      child: Container(
                                        // color: theme.primaryColor.withOpacity(0.5),
                                        width: targetsales.length <= 3
                                            ? Screens.width(context)
                                            : Screens.width(context) * s,
                                        height: Screens.heigth(context),
                                        child: Center(
                                          child: charts.BarChart(
                                            cretaedChart(),
                                            animate: true,
                                            vertical: false,
                                            barGroupingType:
                                                charts.BarGroupingType.grouped,
                                            barRendererDecorator:
                                                new charts.BarLabelDecorator(
                                              insideLabelStyleSpec:
                                                  new charts.TextStyleSpec(
                                                      fontSize: 10),
                                              outsideLabelStyleSpec:
                                                  new charts.TextStyleSpec(
                                                      fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Screens.heigth(context) * 0.015,
                                    ),
                                    Container(
                                      width: Screens.width(context),
                                      // color: Colors.red,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.05,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.03,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.01,
                                              ),
                                              Text("Target Sales")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.05,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.03,
                                                color: Colors.red.shade200,
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.01,
                                              ),
                                              Text("Ach Sales")
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        //
                        //
                        //
                        collectiondata.isEmpty
                            ? Container(
                                // color: theme.primaryColor.withOpacity(0.5),
                                width: Screens.width(context),
                                height: Screens.heigth(context) * 0.28,
                                child: Center(
                                  child: Text("$collectionexp"),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Collection",
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      // scrollDirection: Axis.horizontal,
                                      child: Container(
                                        // color: theme.primaryColor.withOpacity(0.5),
                                        width: targetsales.length <= 3
                                            ? Screens.width(context)
                                            : Screens.width(context) * s,
                                        height: Screens.heigth(context),
                                        child: Center(
                                          child: charts.BarChart(
                                            CollectionChart(),
                                            animate: true,
                                            vertical: false,
                                            barGroupingType:
                                                charts.BarGroupingType.grouped,
                                            barRendererDecorator: new charts
                                                .BarLabelDecorator(
                                                outsideLabelStyleSpec:
                                                    new charts.TextStyleSpec(
                                                        fontSize: 10),
                                                insideLabelStyleSpec:
                                                    new charts.TextStyleSpec(
                                                        fontSize: 10)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Screens.heigth(context) * 0.015,
                                    ),
                                    Container(
                                      width: Screens.width(context),
                                      // color: Colors.red,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.05,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.03,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.01,
                                              ),
                                              Text("Target Collection")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.05,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.03,
                                                color: Colors.blue.shade200,
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.01,
                                              ),
                                              Text("Ach Collection")
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        //
                        //
                        //
                        volumedata.isEmpty
                            ? Container(
                                // color: theme.primaryColor.withOpacity(0.5),
                                width: Screens.width(context),
                                height: Screens.heigth(context) * 0.28,
                                child: Center(
                                  child: Text("$volumeexp"),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Volume",
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      // scrollDirection: Axis.horizontal,
                                      child: Container(
                                        // color: theme.primaryColor.withOpacity(0.5),
                                        width: targetsales.length <= 3
                                            ? Screens.width(context)
                                            : Screens.width(context) * s,
                                        height: Screens.heigth(context),
                                        child: Center(
                                          child: charts.BarChart(
                                            VolumeChart(),
                                            animate: true,
                                            vertical: false,
                                            barGroupingType:
                                                charts.BarGroupingType.grouped,
                                            barRendererDecorator: new charts
                                                .BarLabelDecorator(
                                                outsideLabelStyleSpec:
                                                    new charts.TextStyleSpec(
                                                        fontSize: 10),
                                                insideLabelStyleSpec:
                                                    new charts.TextStyleSpec(
                                                        fontSize: 10)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Screens.heigth(context) * 0.015,
                                    ),
                                    Container(
                                      width: Screens.width(context),
                                      // color: Colors.red,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.05,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.03,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.01,
                                              ),
                                              Text("Target Volume")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.05,
                                                height:
                                                    Screens.heigth(context) *
                                                        0.03,
                                                color: Colors.green.shade200,
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.01,
                                              ),
                                              Text("Ach Volume")
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class ChartRecord {
  String name;
  double sales;
  final Color barColor;

  ChartRecord({
    required this.name,
    required this.sales,
    required this.barColor,
  });
}

class VolumeChartRecord {
  String name;
  double volume;
  final Color barColor;

  VolumeChartRecord({
    required this.name,
    required this.volume,
    required this.barColor,
  });
}

class CollectionChartRecord {
  String name;
  double collection;
  final Color barColor;

  CollectionChartRecord({
    required this.name,
    required this.collection,
    required this.barColor,
  });
}
