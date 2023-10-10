import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapy/screens/payment/addCard.dart';
import 'package:okapy/screens/utils/colors.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payments',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: const Text(
                    'Payment Methods',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/visaIcon.png',
                      height: 21,
                      width: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("*** 9625"),
                    ),
                  ],
                ),
                Radio(
                    value: "radio value",
                    groupValue: "group value",
                    toggleable: true,
                    onChanged: (value) {
                      print(value); //selected value
                    })
              ],
            ),

            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/credit.png',
                      height: 21,
                      width: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Add debit / credit card"),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AddCard(amount: 0,)),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: themeColorGreen,
                  ),
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
