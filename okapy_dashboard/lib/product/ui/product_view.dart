import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/constants.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';
import 'package:okapy_dashboard/core/ui/component/heading_text.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:okapy_dashboard/core/ui/component/modal_sheets.dart';
import 'package:okapy_dashboard/core/ui/component/snack_bar.dart';
import 'package:okapy_dashboard/core/ui/component/text_input.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/product/controller/product_controller.dart';
import 'package:okapy_dashboard/product/data/product_model.dart';
import 'package:provider/provider.dart';

displayProductDetails(BuildContext context, ProductModel product) {
  return showSideSheet(
      context,
      ProductView(
        product: product,
      ));
}

class ProductView extends StatefulWidget {
  const ProductView({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  bool isEdit = false;

  setEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:
            Consumer<ProductController>(builder: (context, controller, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconTextButton(
                label: "Edit",
                icon: Icons.edit,
                onTap: () => setEdit(),
              ),
              const SizedBox(
                height: 30,
              ),
              controller.productDetails!.image ==null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 100,
                      child: Image.network(
                          "${NetworkConstant.serverAssets}${controller.productDetails!.image}"),
                    ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingText(text: "${controller.productDetails!.name}"),
                  !isEdit
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            Text(controller.productDetails!.isActive!
                                ? "Activated"
                                : "Deactivated"),
                            Switch(
                              value: controller.productDetails!.isActive!,
                              onChanged: (value) {
                                setState(() {
                                  controller.productDetails!.isActive = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            )
                          ],
                        )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextInputField(
                  title: "Name",
                  hint: controller.productDetails!.name,
                  icon: Icons.person,
                  isEnabled: isEdit,
                  textEditingController: controller.nameController),
              const SizedBox(
                height: 10,
              ),
              CustomTextInputField(
                  title: "Desciption",
                  hint: "${controller.productDetails!.description}",
                  isMultiline: true,
                  isEnabled: isEdit,
                  textEditingController: controller.descriptionController),
              const SizedBox(
                height: 10,
              ),
              CustomTextInputField(
                  title: "Price",
                  hint: "${controller.productDetails!.price}",
                  icon: Icons.price_change_outlined,
                  isEnabled: isEdit,
                  textEditingController: controller.priceController),
              const SizedBox(
                height: 10,
              ),
              const SubHeadingText(text: "Category"),
              const SizedBox(
                height: 10,
              ),
              isEdit
                  ? Wrap(
                      spacing: 10.0,
                      children: List<Widget>.generate(
                          controller.productCategories.length,
                          (int index) => ChoiceChip(
                                label: Text(
                                    '${controller.productCategories[index].name}'),
                                selected: controller.selectedCategory.name ==
                                    controller.productCategories[index].name,
                                onSelected: (isSelected) => {
                                  controller.setSelectedCategory(
                                      controller.productCategories[index]),
                                },
                                selectedColor: AppColors.primaryColor,
                              )),
                    )
                  : SubHeadingText(text: controller.selectedCategory.name!),
              const SizedBox(
                height: 30,
              ),
              isEdit
                  ? controller.isLoading
                      ? const LoadingWidget()
                      : PrimaryButton(
                          text: "Edit Product",
                          onPressed: () {
                            controller
                                .editProduct()
                                .then((value) {
                              if (value) {
                                controller.setTextControllersToNull();
                                controller.getProducts();
                                buildSnackbar(context, "Product edited",
                                    alignment: TextAlign.start);
                              } else {
                                buildSnackbar(context, controller.errorMessage,
                                    alignment: TextAlign.start);
                              }
                            });
                          })
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        }),
      ),
    );
  }
}
