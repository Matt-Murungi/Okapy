import 'package:flutter/material.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:okapy_dashboard/core/ui/component/snack_bar.dart';
import 'package:okapy_dashboard/core/ui/table.dart';
import 'package:okapy_dashboard/product/controller/product_controller.dart';
import 'package:okapy_dashboard/product/ui/components/category_create.dart';
import 'package:okapy_dashboard/product/ui/product_create.dart';
import 'package:okapy_dashboard/product/ui/product_view.dart';
import 'package:provider/provider.dart';

class ProductTableDetails extends StatefulWidget {
  const ProductTableDetails({super.key});

  @override
  State<ProductTableDetails> createState() => _ProductTableDetailsState();
}

class _ProductTableDetailsState extends State<ProductTableDetails> {
  bool isLoading = false;
  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(builder: (context, controller, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          isLoading
              ? const LoadingWidget()
              : Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    PrimaryButton(
                        text: "Add Product",
                        onPressed: () =>
                            controller.getCategories().then((value) {
                              if (value != null) {
                                displayAddProduct(context);
                              } else {
                                buildSnackbar(context, controller.errorMessage);
                              }
                            })),
                    const SizedBox(
                      width: 10,
                    ),
                    PrimaryButton(
                      text: "Add Category",
                      onPressed: () => displayCreateCategory(context),
                      isOutlined: true,
                    )
                  ],
                ),
          const SizedBox(
            height: 10,
          ),
          controller.products.isEmpty
              ? const Center(
                  child: Text("You currently have no products"),
                )
              : SizedBox(
                  child: SingleChildScrollView(
                    child: Card(
                      child: DataTable(
                          columnSpacing: 20.0,
                          horizontalMargin: 10.0,
                          columns: [
                            buildTableHeader(""),
                            buildTableHeader("Product Name"),
                            buildTableHeader("Category"),
                            buildTableHeader("Price"),
                            buildTableHeader("Action"),
                          ],
                          rows: controller.products
                              .map((product) => DataRow(
                                    cells: [
                                      DataCell(Icon(Icons.circle,
                                          size: 10,
                                          color: product.isActive!
                                              ? Colors.green
                                              : Colors.red)),
                                      buildTableCell("${product.name}"),
                                      buildTableCell(
                                          "${product.category!.name}"),
                                      buildTableCell("${product.price}"),
                                      DataCell(
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ButtonWithIcon(
                                                icon: Icons
                                                    .remove_red_eye_outlined,
                                                tooltip: "View",
                                                onPressed: () {
                                                  controller
                                                      .getCategories()
                                                      .then((value) {
                                                    print("Value $value");
                                                    if (value != null) {
                                                      controller
                                                          .viewProduct(product);
                                                      controller
                                                              .selectedCategory =
                                                          product.category!;
                                                      displayProductDetails(
                                                          context, product);
                                                    }
                                                  });
                                                }),
                                            ButtonWithIcon(
                                              icon:
                                                  Icons.delete_outline_outlined,
                                              tooltip: "Delete",
                                              onPressed: () {
                                                setIsLoading(true);
                                                controller
                                                    .deleteProduct(product)
                                                    .then((value) {
                                                  if (value) {
                                                    controller.getProducts();
                                                    setIsLoading(false);
                                                    buildSnackbar(context,
                                                        "Product deleted",
                                                        alignment:
                                                            TextAlign.start);
                                                  } else {
                                                    setIsLoading(false);
                                                    buildSnackbar(context,
                                                        controller.errorMessage,
                                                        alignment:
                                                            TextAlign.start);
                                                  }
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList()),
                    ),
                  ),
                ),
        ],
      );
    });
  }
}
