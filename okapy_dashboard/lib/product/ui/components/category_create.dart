import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/ui/component/buttons.dart';
import 'package:okapy_dashboard/core/ui/component/heading_text.dart';
import 'package:okapy_dashboard/core/ui/component/modal_sheets.dart';
import 'package:okapy_dashboard/core/ui/component/snack_bar.dart';
import 'package:okapy_dashboard/core/ui/component/text_input.dart';
import 'package:okapy_dashboard/product/controller/product_controller.dart';
import 'package:provider/provider.dart';

displayCreateCategory(BuildContext context) {
  return showSideSheet(context, CategoryCreate());
}

class CategoryCreate extends StatefulWidget {
  const CategoryCreate({super.key});

  @override
  State<CategoryCreate> createState() => _CategoryCreateState();
}

class _CategoryCreateState extends State<CategoryCreate> {
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            const HeadingText(text: "Add Category"),
            const SizedBox(
              height: 100,
            ),
            CustomTextInputField(
                title: "Category Name",
                icon: Icons.person,
                textEditingController: controller.nameController),
            const SizedBox(
              height: 30,
            ),
            PrimaryButton(
                text: "Add Category",
                onPressed: () => controller.createCategory().then((value) {
                      if (value) {
                        controller.setTextControllersToNull();
                        buildSnackbar(context, "Category created", alignment: TextAlign.start);
                      } else {
                        buildSnackbar(context, controller.errorMessage, alignment: TextAlign.start);
                      }
                    })),
          ],
        );
      }),
    );
  }
}
