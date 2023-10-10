import 'package:flutter/material.dart';
import 'package:okapy/core/ui/components/app_bar.dart';
import 'package:okapy/core/utils/logger.dart';
import 'package:okapy/screens/partners/partner_checkout.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/utils/constants.dart';
import 'package:provider/provider.dart';

class PartnerProduct extends StatelessWidget {
  static const String route = "partner_product";

  const PartnerProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Bookings>(builder: (context, bookingsController, child) {
      return Scaffold(
        appBar: buildAppBar(
          "${bookingsController.selectedPartner!.name}",
        ),
        body: bookingsController.partnerProducts.isEmpty
            ? const Center(
                child: Text("No products available"),
              )
            : Column(
                children: [
                  const Divider(
                    height: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: bookingsController.partnerProducts.length,
                        itemBuilder: (context, index) {
                          var partnerProduct =
                              bookingsController.partnerProducts[index];
                          return InkWell(
                            onTap: () {
                              logger.d(
                                  "Booking selected ${bookingsController.selectedPartner!.id}");

                              bookingsController.partnerCartItems.isNotEmpty &&
                                      bookingsController.selectedPartner!.id !=
                                          bookingsController
                                              .partnerCartItems.first.partner
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text(
                                          "You can only order from one partner"),
                                    ))
                                  : bookingsController
                                      .addToCart(partnerProduct);
                            },
                            child: ListTile(
                              isThreeLine: true,
                              leading: partnerProduct.image == null
                                  ? Image.asset("assets/addal.png")
                                  : Image.network(
                                      "$serverUrlAssets${partnerProduct.image}"),
                              title: InkWell(
                                  child: Text("${partnerProduct.name}")),
                              subtitle: Text("${partnerProduct.description}"),
                              trailing:
                                  Text("Ksh ${partnerProduct.price!.toInt()}"),
                            ),
                          );
                        }),
                  )
                ],
              ),
        floatingActionButton: bookingsController.partnerCartItems.isEmpty
            ? const SizedBox.shrink()
            : FloatingActionButton.extended(
                onPressed: () {
                  bookingsController.convertToCheckout();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PartnerCheckout(),
                    ),
                  );
                },
                label: Text(
                    "Checkout ${bookingsController.partnerCartItems.length} items")),
      );
    });
  }
}
