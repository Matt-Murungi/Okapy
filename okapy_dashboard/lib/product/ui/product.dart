import 'package:flutter/material.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/ui/component/information_card.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:okapy_dashboard/core/ui/component/no_data_widget.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/product/controller/product_controller.dart';
import 'package:okapy_dashboard/product/ui/components/product_table_details.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ProductController>(context, listen: false)
            .getProducts(),
        builder: (context, snapshot) {
          print("Snapshot ${snapshot.data}");
          return Consumer<AuthController>(
              builder: (context, authController, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ProductController>(
                  builder: (context, controller, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Products",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.themeColorGreen,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    controller.products.isEmpty
                        ? const SizedBox.shrink()
                        : snapshot.hasData
                            ? Row(
                                children: [
                                  InformationCard(
                                      title: "Number of Products",
                                      information:
                                          "${controller.products.length}",
                                      iconColor: AppColors.primaryColor),
                                  InformationCard(
                                      title: "Active Products",
                                      information:
                                          "${controller.getAllActiveProducts()}",
                                      iconColor: AppColors.themeColorGreen),
                                  InformationCard(
                                      title: "Inactive Products",
                                      information:
                                          "${controller.getAllInactiveProducts()}",
                                      iconColor: AppColors.themeColorRed),
                                ],
                              )
                            : const NoDataWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const ProductTableDetails()
                  ],
                );
              }),
            );
          });
        });
  }
}
