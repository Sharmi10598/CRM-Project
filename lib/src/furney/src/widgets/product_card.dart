import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_bundle/helpers/constants.dart';

import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/models/product_model.dart';

enum ProductCardType { horizontal, vertical, grid }

class ProductCard extends StatelessWidget {
  final ProductModel? product;
  final ProductModel2? product2;
  final ProductCardType cardType;

  const ProductCard({
    Key? key,
    this.product,
    this.cardType = ProductCardType.horizontal,
    this.product2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatelessWidget typeCard(ProductCardType type) {
      switch (type) {
        case ProductCardType.horizontal:
          return _HorizontalType(product2: product2);
        case ProductCardType.vertical:
          return _VerticalType(product: product);
        case ProductCardType.grid:
          return _GridType(product: product);
        default:
          return _HorizontalType(product2: product2);
      }
    }

    return typeCard(cardType);
  }
}

class _HorizontalType extends StatelessWidget {
  const _HorizontalType({
    required this.product2,
    Key? key,
  }) : super(key: key);

  final ProductModel2? product2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(right: Screens.width(context) * 0.05),
      child: InkWell(
        onTap: () {
          // print("helloooo");
          //  showbottomsheet(context);
        },
        //=> Get.toNamed<dynamic>(FurneyRoutes.product, arguments: product),
        borderRadius: BorderRadius.circular(Const.radius),
        child: Container(
          width: 170,
          //height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Const.radius),
            color: theme.cardColor,
          ),
          padding: EdgeInsets.only(
            top: Screens.width(context) * 0.03,
            left: Screens.width(context) * 0.05,
            right: Screens.width(context) * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomNetworkImage(
              //   image: product!.images!.first,
              //   width: Screens.width(context),
              //   height: 120,
              // ),
              const SizedBox(height: Const.space25),
              SizedBox(
                // color: Colors.redAccent,
                child: Text(
                  product2!.name!,
                  style: theme.textTheme.headlineMedium!.copyWith(height: 1.2),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ),
              //  const  Spacer(),
              AutoSizeText(
                product2!.description!,
                maxLines: 1,
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showbottomsheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (builder) {
        return Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            // key: formkey[2],
            child: SizedBox(
              height: Screens.heigth(context) * 0.2,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.015,
                    ),
                    Text(
                      'Description ....',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Reject'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Approve'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _VerticalType extends StatelessWidget {
  const _VerticalType({
    required this.product,
    Key? key,
  }) : super(key: key);

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          // print("object");
          // showbottomsheet(context);
        },
        // => Get.toNamed<dynamic>(FurneyRoutes.product, arguments: product),
        borderRadius: BorderRadius.circular(Const.radius),
        child: Container(
          width: Screens.width(context),
          height: Screens.heigth(context) * 0.11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Const.radius),
            color: theme.cardColor,
          ),
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomNetworkImage(
                  //   image: product!.images!.first,
                  //   width: Screens.width(context) / 3.3,
                  //   height: Screens.width(context) / 3.3,
                  //   fit: BoxFit.contain,
                  // ),
                  SizedBox(width: Screens.width(context) / 35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.7,
                        // color: Colors.redAccent,
                        child: Text(
                          product!.name!,
                          style: theme.textTheme.headlineMedium!
                              .copyWith(height: 1.2),
                          // textAlign: TextAlign.left,
                          // maxLines: 1,
                        ),
                      ),
                      AutoSizeText(
                        product!.description!,
                        maxLines: 1,
                        style:
                            theme.textTheme.titleSmall!.copyWith(fontSize: 10),
                      ),
                      const Spacer(),
                      // AutoSizeText(
                      //   NumberFormat.currency(
                      //     symbol: r'$',
                      //     decimalDigits: 0,
                      //   ).format(product!.price),
                      //   maxLines: 1,
                      //   style: theme.textTheme.headline3!
                      //       .copyWith(color: theme.primaryColor),
                      // ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: Screens.width(context) / 20.0,
                  backgroundColor: theme.primaryColor,
                  child: IconButton(
                    icon:
                        const Icon(FeatherIcons.arrowRight), //arrowRightCircle
                    iconSize: Screens.width(context) / 18.0,
                    color: Colors.white,
                    onPressed: () {
                      //showbottomsheet(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showbottomsheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (builder) {
        return Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            // key: formkey[2],
            child: SizedBox(
              height: Screens.heigth(context) * 0.2,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Approvals',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.015,
                    ),
                    Text(
                      'Description ....',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: Screens.heigth(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Reject'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Approve'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GridType extends StatelessWidget {
  final ProductModel? product;

  const _GridType({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () =>
          Get.toNamed<dynamic>(FurneyRoutes.product, arguments: product),
      borderRadius: BorderRadius.circular(Const.radius),
      child: Column(
        children: [
          // CustomNetworkImage(
          //   image: product!.images!.first,
          //   fit: BoxFit.fitWidth,
          //   // height: 9,
          //   // width: 9,
          // ),
          const SizedBox(height: Const.space15),
          AutoSizeText(
            product!.name!,
            style: theme.textTheme.displaySmall,
          ),
          const SizedBox(height: Const.space12),
          AutoSizeText(
            NumberFormat.currency(symbol: r'$').format(product!.price),
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
