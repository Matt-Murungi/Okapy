import 'package:flutter/material.dart';
import 'package:okapy/screens/createbooking/getaDriver.dart';
import 'package:okapy/screens/home/home.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/state/payment.dart';
import 'package:okapy/utils/KeyboardUtil.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class AddCard extends StatefulWidget {
   AddCard({Key? key,required this.amount}) : super(key: key);
  double amount;
  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final _formKey = GlobalKey<FormState>();
  bool busy = false;

  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: themeColorAmber,
      width: 2.0,
    ),
  );

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      // cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Card',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<Payment>(
        builder: (context, paymentController, child) => Consumer<Bookings>(
          builder: (context, bookingsController, child) => SafeArea(
            child: Column(
              children: [
                CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: '',
                  cvvCode: cvvCode,
                  bankName: '',
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: themeColorAmber,
                  backgroundImage:
                      useBackgroundImage ? 'assets/card_bg.png' : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: _formKey,
                          obscureCvv: true,
                          obscureNumber: false,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: false,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: '',
                          expiryDate: expiryDate,
                          themeColor: themeColorAmber,
                          textColor: Colors.black,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 49,
                      width: 326,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(themeColorAmber)),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          if (bookingsController.bookingActiveModel == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("No current booking")));
                            return;
                          }

                          setState(() {
                            busy = true;
                          });


                          _formKey.currentState!.save();
                          KeyboardUtil.hideKeyboard(context);
                          paymentController
                              .initiatePayment(
                                  cardNo: cardNumber.replaceAll(' ', ''),
                                  user:
                                      "${bookingsController.bookingActiveModel!.booking!.owner!.id!}",
                                  expirationDate: expiryDate,
                                  amount: widget.amount.toString(),
                                  orderId:
                                      "${bookingsController.activeModel?.booking!.bookingId}",
                                  cardCode: cvvCode)
                              .then((value) {
                                Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Payment was successful"),
                            ));
                          }).catchError((onError) {
                            setState(() {
                              busy = false;
                            });
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const GetADriver()),
                            // );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Payment was unsuccessful. An Error occured"),
                            ));
                          });
                        },
                        child: busy
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Add card',
                                style: TextStyle(
                                    color: themeColorGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
