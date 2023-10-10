import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';
import 'package:okapy_dashboard/core/ui/component/heading_text.dart';
import 'package:okapy_dashboard/core/ui/component/loader.dart';
import 'package:okapy_dashboard/core/ui/component/modal_sheets.dart';
import 'package:okapy_dashboard/core/ui/component/snack_bar.dart';
import 'package:okapy_dashboard/core/ui/component/text_input.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/product/controller/product_controller.dart';
import 'package:provider/provider.dart';

displayAddProduct(BuildContext context) {
  return showSideSheet(context, const ProductCreate());
}

class ProductCreate extends StatefulWidget {
  const ProductCreate({
    super.key,
  });

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  bool isLoading = false;
  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Consumer<ProductController>(builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const HeadingText(text: "Add Product"),
            const SizedBox(
              height: 30,
            ),
            CustomTextInputField(
                title: "Name",
                icon: Icons.person,
                textEditingController: controller.nameController),
            const SizedBox(
              height: 10,
            ),
            CustomTextInputField(
                title: "Desciption",
                isMultiline: true,
                textEditingController: controller.descriptionController),
            const SizedBox(
              height: 10,
            ),
            CustomTextInputField(
                title: "Price",
                icon: Icons.price_change_outlined,
                textEditingController: controller.priceController),
            const SizedBox(
              height: 10,
            ),
            const SubHeadingText(text: "Category"),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10.0,
              children: List<Widget>.generate(
                  controller.productCategories.length,
                  (int index) => ChoiceChip(
                        label:
                            Text('${controller.productCategories[index].name}'),
                        selected: controller.selectedCategory.name ==
                            controller.productCategories[index].name,
                        onSelected: (isSelected) => {
                          print(
                            controller.selectedCategory.name ==
                                controller.productCategories[index].name,
                          ),
                          print(controller.selectedCategory.name),
                          print(
                            controller.productCategories[index].name,
                          ),
                          controller.selectedCategory =
                              controller.productCategories[index]
                        },
                        selectedColor: AppColors.primaryColor,
                      )),
            ),
            const SizedBox(
              height: 30,
            ),
            isLoading
                ? const LoadingWidget()
                : PrimaryButton(
                    text: "Add Product",
                    onPressed: () => {
                          setIsLoading(true),
                          controller.createProduct().then((value) {
                            controller.setTextControllersToNull();
                            if (value) {
                              setIsLoading(false);
                              buildSnackbar(context, "Product created",
                                  alignment: TextAlign.start);
                              controller.getProducts();
                            } else {
                              setIsLoading(false);

                              buildSnackbar(context, controller.errorMessage,
                                  alignment: TextAlign.start);
                            }
                          }),
                        })
          ],
        );
      }),
    );
  }
}
