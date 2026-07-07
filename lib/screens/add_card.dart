

import 'package:fachin/components/custom_appbar.dart';
import 'package:fachin/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:gap/gap.dart';

import '../components/custom_button.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isshow = false;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBlackk: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(title: "Payment method"),
              Gap(13),
              ///visa
               CreditCardWidget(cardNumber: cardNumber,
                   expiryDate: expiryDate,
                   cardHolderName: cardHolderName,
                   cvvCode: cvvCode, showBackView: isshow,
                   cardBgColor: Colors.black,
                   obscureCardCvv: false,
                   obscureCardNumber: true,
                   isHolderNameVisible: true,
          
                   onCreditCardWidgetChange: (v){
                   },
          
          
                   ),
              /// form
              CreditCardForm(
                  formKey: _key,
                cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName, cvvCode: cvvCode,
                  onCreditCardModelChange: onCreditCardModelChange,
                isCardHolderNameUpperCase: true,
                obscureCvv: false,
          
          
          
              ),
              Gap(80),
              Button(isSvgg: true,title: "ADD CARD",onTap:(){
                final data = {
                  'number' : cardNumber,
                  'name' : cardHolderName,
                  'date' : expiryDate,
                  'cvv' : cvvCode
          
          
                };
                Navigator.pop(context,data);
          
              }),
              Gap(70),
          
          
          
          ]
          ),
        ),

      ),
    );
  }
  void onCreditCardModelChange(CreditCardModel data){
    setState(() {
      cardHolderName = data.cardHolderName;
      cardNumber = data.cardNumber;
      cvvCode = data.cvvCode;
      expiryDate = data.expiryDate;
      isshow = data.isCvvFocused;
    });

  }

}
