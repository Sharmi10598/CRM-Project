
import 'dart:ui';

import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SwiperList {
  // static List<ProductModel> swiperList = [
  //   ProductModel(
  //     name: 'Lycksele HÅavet',
  //     price: 400,
  //     description:
  //         // ignore: lines_longer_than_80_chars
  //         "This sofa quickly and easily turns into a bed for two. It's easy to keep fresh as the mattress and sofa cover can be removed and washed. Change out a few covers to give the sofa and space a new look.",
  //     rating: 0,
  //     categories: ['Sofa', 'Chair'],
  //     tags: ['#Furniture', '#Chair', '#Sofa'],
  //     images: [
  //       'https://d2xjmi1k71iy2m.cloudfront.net/dairyfarm/id/images/292/0829242_PE600355_S4.jpg',
  //       'https://d2xjmi1k71iy2m.cloudfront.net/dairyfarm/id/images/338/0833873_PE600246_S4.jpg',
  //       'https://d2xjmi1k71iy2m.cloudfront.net/dairyfarm/id/images/292/0829243_PE602974_S4.jpg',
  //     ],
  //   ),
  //   ProductModel(
  //     name: 'Helmer',
  //     price: 60,
  //     rating: 0,
  //     categories: ['Drawers', 'Cupboard'],
  //     tags: ['#Furniture', '#Drawers', '#Cupboard'],
  //         // ignore: lines_longer_than_80_chars
  //     description: "Easy to move where you want it because it has wheels. Place for labels in each drawer so you can easily keep things organized and find what you're looking for. Drawer stops prevent the drawers from being pulled out too far.",
  //     images: [
  //       'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80',
  //       'https://d2xjmi1k71iy2m.cloudfront.net/dairyfarm/id/images/988/0398853_PE563023_S4.jpg',
  //       'https://d2xjmi1k71iy2m.cloudfront.net/dairyfarm/id/images/738/0973803_PH154271_S4.jpg',
  //     ]
  //   ),
    
  //   ProductModel(
  //     name: 'Hauga',
  //     price: 80,
  //     rating: 0,
  //     categories: ['Table', 'TV', 'Cupboard'],
  //     tags: ['#Furniture', '#Table', '#Cupboard'],
  //         // ignore: lines_longer_than_80_chars
  //     description: "The receptacle on the back of the TV bench makes it easy to collect and organize all the cables.\nOf course your home should be a safe place for the whole family. That's why safety equipment is included so you can mount the TV bench on the wall.\nTwo drawers make it easy for you to store remote controls, game controllers and other TV accessories.",
  //     images: [
  //       'https://d2xjmi1k71iy2m.cloudfront.net/dairyfarm/id/images/759/0975956_PE812906_S4.jpg',
  //       'https://d2xjmi1k71iy2m.cloudfront.net/dairyfarm/id/images/394/0939483_PE794578_S4.jpg',
  //       'https://d2xjmi1k71iy2m.cloudfront.net/dairyfarm/id/images/395/0939513_PE794597_S4.jpg',
  //     ]
  //   ),
  // ];

 static final List<IndianGrowth> grouthData = [
   IndianGrowth('2010',20, const Color(0xFFFF0303)),
   IndianGrowth('2011',30, const Color(0xFFFF0303)),
   IndianGrowth('2012',40,const Color(0xFFFF0303)),
   IndianGrowth('2013',50,const Color(0xFFFF0303)),
   IndianGrowth('2014',60,const Color(0xFFFF0303)),
 ];


 static final List<IndianGrowth> grouthData2 = [
   IndianGrowth('2010',2,const Color(0xFF1c305d)),
   IndianGrowth('2011',3,const Color(0xFF294689)),
   IndianGrowth('2012',4,const Color(0xFF1c305d)),
   IndianGrowth('2013',5,const Color(0xFF294689)),
   IndianGrowth('2014',10,const Color(0xFF1c305d)),
 ];

 static List<charts.Series<IndianGrowth,String>> series =[
    // charts.Series(id: "Indian Growth", data: grouthData,
    //  domainFn: (IndianGrowth grow,_)=>grow.year, 
    //  measureFn:(IndianGrowth grow,_)=>grow.growth,
    //  colorFn: (IndianGrowth grow,_)=>charts.ColorUtil.fromDartColor(grow.barColor)
    //  ),

     charts.Series(id: 'Indian Growth', data: grouthData2,
     domainFn: (IndianGrowth grow,_)=>grow.year, 
     measureFn:(IndianGrowth grow,_)=>grow.growth,
     colorFn: (IndianGrowth grow,_)=>charts.ColorUtil.fromDartColor(grow.barColor),
     )
  ];

}

class IndianGrowth{
  final String year;
  final int growth;
  final Color barColor;

  IndianGrowth(this.year, this.growth, this.barColor); 
}