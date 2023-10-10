import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:okapy/core/ui/components/app_bar.dart';
import 'package:okapy/core/ui/components/buttons.dart';
import 'package:okapy/core/ui/components/loading_widget.dart';
import 'package:okapy/core/ui/components/text.dart';
import 'package:okapy/screens/createbooking/whereuSending.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/utils/SharedPreferenceHelpers.dart';
import 'package:okapy/utils/constants.dart';
import 'package:provider/provider.dart';

class PartnerCheckout extends StatefulWidget {
  const PartnerCheckout({Key? key}) : super(key: key);

  @override
  State<PartnerCheckout> createState() => _PartnerCheckoutState();
}

class _PartnerCheckoutState extends State<PartnerCheckout> {
  @override
  Widget build(BuildContext context) {
    final booking = context.read<Bookings>();
    final auth = context.read<Auth>();
    bool isLoading = context.watch<Bookings>().isLoading;
    return Scaffold(
        appBar: buildAppBar("Checkout"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              HeadingText(text: "${booking.selectedPartner!.name}"),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: booking.checkoutItems.entries.map((item) {
                    final partnerProduct = item.key;
                    final quantity = item.value;

                    return ListTile(
                      leading: partnerProduct!.image == null
                          ? Image.asset("assets/addal.png")
                          : Image.network(
                              "$serverUrlAssets${partnerProduct.image}"),
                      title: Text("${partnerProduct.name}"),
                      subtitle: Text("Quantity: $quantity"),
                      trailing: SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallIconButton(
                                icon: Icons.add,
                                onTap: () =>
                                    booking.addToCheckout(partnerProduct)),
                            SmallIconButton(
                                icon: Icons.remove,
                                onTap: () =>
                                    booking.removeFromCheckout(partnerProduct)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  const HeadingText(text: "Total"),
                  const SizedBox(
                    width: 20,
                  ),
                  HeadingText(text: "${booking.calculateTotalPrice()}")
                ],
              )
            ],
          ),
        ),
        floatingActionButton: isLoading
            ? const LoadingWidget()
            : FloatingActionButton.extended(
                onPressed: () => booking.initializeBooking(data: {
                  'owner': auth.userModel!.id,
                  'partner': booking.selectedPartner!.id,
                  'latitude': booking.selectedPartner!.latitude,
                  'longitude': booking.selectedPartner!.longitude
                }).then((value) {
                  if (value) {
                    booking.attachPartnerProductToBooking().then((value) {
                      if (value) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WhereUSending(),
                          ),
                        );
                        booking.clearCheckout();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(booking.errorMessage),
                        ));
                      }
                    });
                  }
                }),
                label: const Text("Checkout"),
              ));
  }
}
