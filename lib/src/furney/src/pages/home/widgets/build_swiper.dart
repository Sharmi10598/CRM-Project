part of '../home_page.dart';

class _BuildSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: Screens.width(context),
      height: Screens.width(context) / 2,
      margin: const EdgeInsets.symmetric(horizontal: Const.margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // color: Colors.black,
      ),
      child: Swiper(
        itemCount: 2,
        autoplay: true,
        itemBuilder: (context, index) {
          //   final data = SwiperList.series[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // image: DecorationImage(
              //   fit: BoxFit.fitWidth,
              //   image: CachedNetworkImageProvider(data.images!.first),
              // ),

              // color: Colors.red
            ),
            // child: charts.BarChart(SwiperList.series,
            //     animate: true,
            //     animationDuration:const Duration(milliseconds: 500),
            //      barGroupingType: charts.BarGroupingType.stacked,
            //     ) ,
          );
        },
      ),
    );
  }
}
