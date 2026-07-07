import 'package:fachin/components/custom_text.dart';
import 'package:fachin/core/colors.dart';
import 'package:fachin/screens/place_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../components/cart_widget.dart';
import '../components/custom_appbar.dart';

import '../components/custom_button.dart';
import '../components/header.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.descp,
  });
  final String image;
  final String name;
  final int price;
  final String descp;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int selectedQty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBlackk: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Header(title: "Checkout".toUpperCase()),

            CartWidget(
              image: widget.image,
              name: widget.name,
              descp: widget.descp,
              price: widget.price,
              qty: selectedQty,
              onChanged: (v) {
                setState(() {
                  selectedQty = v;
                });
              },
            ),
            Gap(20),
            Divider(),
            Gap(20),
            promo(),

            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                CustomText(text: "Es. Total", color: AppColors.primary),
                CustomText(text: "\$ ${widget.price * selectedQty}", color: Colors.red),
              ],
            ),
            Gap(20),
            Button(isSvgg: true, title: 'Address', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c){
                return PlaceOrder(imag: widget.image,
                    qty: selectedQty,
                    descrp: widget.descp,
                    name: widget.name,
                    total:widget.price * selectedQty,
                price: widget.price );

              }));
            }
            ),
            Gap(70),

          ],
        ),
      ),
    );
  }
}

Widget promo() {
  return Column(
    children: [
      Row(
        children: [
          SvgPicture.asset("assets/svgs/promo.svg", width: 28),
          Gap(20),
          CustomText(text: "Add Promo Code", color: AppColors.primary),
        ],
      ),
      Divider(),
      Gap(20),
      Row(
        children: [
          SvgPicture.asset("assets/svgs/delivery.svg", width: 25),
          Gap(20),
          CustomText(text: "Delivery", color: AppColors.primary),
          Spacer(),
          CustomText(text: "Free", color: AppColors.primary),
        ],
      ),
      Gap(10),
      Divider(),
      Gap(10),
    ],
  );
}
