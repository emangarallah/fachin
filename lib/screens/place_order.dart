import 'package:fachin/components/address_info.dart';
import 'package:fachin/components/cart_widget.dart';
import 'package:fachin/components/custom_appbar.dart';
import 'package:fachin/components/custom_text.dart';

import 'package:fachin/screens/add_card.dart';
import 'package:fachin/screens/addadress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';


import '../components/custom_button.dart';
import '../components/dailog.dart';
import '../components/header.dart';
import '../components/shipping_method.dart';
import '../core/colors.dart';


class PlaceOrder extends StatefulWidget {
  const PlaceOrder({
    super.key,
    required this.imag,
    required this.qty,
    required this.descrp,
    required this.name,
    required this.total,
    required this.price,
  });
  final String imag;
  final int qty;
  final String descrp;
  final int price;

  final String name;
  final int total;

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  dynamic _saveAddrss;
  dynamic _savedCared;
  late int selectedQty;
  @override
  void initState() {
    selectedQty = widget.qty;
    super.initState();
  }

  void _openAddress(context) async {
    final adresData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => Addadress()),
    );
    if (adresData != null) {
      setState(() {
        _saveAddrss = adresData;
      });
    }
  }

  void _editaddress() async {
    final newaddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => Addadress(editData: _saveAddrss)),
    );
    setState(() {
      _saveAddrss = newaddress;
    });
  }

  void _openCard(context) async {
    final cardData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => AddCard()),
    );
    if (cardData != null) {
      setState(() {
        _savedCared = cardData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBlackk: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
        
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(title: "Checkout".toUpperCase()),
                CustomText(
                  text: "Shipping adress".toUpperCase(),
                  color: Colors.black38,
                  size: 16,
                ),
                Gap(19),
        
                /// address flo
                _savedCared != null && _saveAddrss != null
                    ? SizedBox.shrink()
                    : CustomText(
                        text: "Iris Watson".toUpperCase(),
                        color: Colors.black,
                        size: 20,
                      ),
                Gap(15),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _saveAddrss != null
                          ? AddressInfo(
                              savedAddress: _saveAddrss,
                              onTap: _editaddress,
                            )
                          : SizedBox.shrink(),
                      Gap(20),
                      _saveAddrss == null
                          ? GestureDetector(
                              onTap: () {
                                _openAddress(context);
                              },
        
                              child: custContainer(
                                "Add  shiping adress",
                                Icons.add,
                                false,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                Gap(30),
        
                //shiping method
                _savedCared != null && _saveAddrss != null
                    ? SizedBox.shrink()
                    : ShippingMethod(),
                //payment method
                _savedCared != null && _saveAddrss != null
                    ? SizedBox.shrink()
                    : CustomText(
                        text: "Payment Method".toUpperCase(),
                        color: Colors.black38,
                        size: 16,
                      ),
                Gap(20),
        
                _savedCared != null
                    ? Column(
                        children: [
                          Divider(color: Colors.grey.shade200),
                          Gap(20),
                          Divider(color: Colors.grey.shade200),
                          Gap(20),
        
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/Mastercard.svg",
                                width: 40,
                              ),
                              Gap(10),
                              CustomText(
                                text: "Master Card Ending",
                                color: Colors.black,
                              ),
                              Gap(10),
                              CustomText(
                                text:
                                    "....${_savedCared['number'].toString().substring(_savedCared['number'].length - 2)}",
                                color: Colors.black,
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/svgs/arrow.svg"),
                            ],
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          _openCard(context);
                        },
                        child: custContainer(
                          "Selected payment method",
                          Icons.keyboard_arrow_down_sharp,
                          false,
                        ),
                      ),
                Gap(40),
        
        
        
                CartWidget(
                  image: widget.imag,
                  name: widget.name,
                  descp: widget.descrp,
                  price: widget.price,
                  qty: widget.qty,
        
                  onChanged: (qty) {
                    setState(() {
                      selectedQty = qty;
                    });
                  },
                ),
        
        
        
        
        
        
        
                Gap(200),
                //Ending
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                  children: [
                    CustomText(text: "Total", color: AppColors.primary),
                    CustomText(
                      text: "\$ ${widget.total * selectedQty}",
                      color: Colors.red,
                    ),
                  ],
                ),
                Gap(20),
                Button(
                  isSvgg: true,
                  title: 'Place order',
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: CustomDailog(),
                        );
                      },
                    );
                  },
                ),
                Gap(70),
        
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget custContainer(text, icon, isFree) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey.shade100,
    ),
    width: double.infinity,
    child: Row(
      children: [
        CustomText(text: text, color: Colors.black),
        Spacer(),
        isFree
            ? CustomText(text: "FREE", color: Colors.black)
            : SizedBox.shrink(),
        Gap(15),
        Icon(icon),
      ],
    ),
  );
}
