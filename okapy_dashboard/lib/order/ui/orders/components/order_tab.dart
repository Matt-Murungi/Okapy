import 'package:flutter/material.dart';
import 'package:okapy_dashboard/order/controller/order_controller.dart';
import 'package:okapy_dashboard/order/utils/constants.dart';
import 'package:provider/provider.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({super.key});

  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  int selectedChipIndex = 0;
  bool isLoading = false;
  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  setSelectedChipIndex(int value) {
    setState(() {
      selectedChipIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(builder: (context, controller, child) {
      return Wrap(
        spacing: 10.0,
        children: [
          ChoiceChip(
            label: Text("data1"),
            selected: selectedChipIndex == 0,
            onSelected: (isSelected) {
              setIsLoading(true);
              setSelectedChipIndex(0);
              selectedChipIndex = 0;
            },
          ),
          ChoiceChip(
            label: Text("data2"),
            selected: selectedChipIndex == 1,
            onSelected: (isSelected) {
              setIsLoading(true);
              setSelectedChipIndex(1);
              selectedChipIndex = 1;

              controller.getOrderByStatus(OrderStatus.arrived).then((value) {
                if (value) {
                  print("Value is $value");
                  setIsLoading(false);
                  
                }
              });
            },
          ),
          ChoiceChip(
            label: Text("data3"),
            selected: selectedChipIndex == 2,
            onSelected: (isSelected) {
              setIsLoading(true);
              setSelectedChipIndex(2);
              selectedChipIndex = 2;
            },
          ),
        ],
      );
    });
  }
}
