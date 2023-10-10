import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:okapy_dashboard/core/routes/route_strings.dart';
import 'package:okapy_dashboard/core/ui/constants.dart';
import 'package:okapy_dashboard/order/controller/order_controller.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedSection = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: true,
      selectedIconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
      selectedLabelTextStyle: TextStyle(color: AppColors.primaryColor),
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.shopping_bag_outlined),
          label: Row(
            children: [
              const Text("Bookings"),
              const SizedBox(
                width: 10,
              ),
              context.watch<OrderController>().isNewBookingAvailable
                  ? Icon(
                      Icons.circle,
                      size: 15,
                      color: AppColors.themeColorRed,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.document_scanner_outlined),
          label: Text("Orders"),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.inventory_2_outlined),
          label: Text("Products"),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.bar_chart),
          label: Text("Payments"),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.manage_history_outlined),
          label: Text("Order Management"),
        ),
      ],
      selectedIndex: _selectedSection,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedSection = index;
        });
        context.go(getNavRoute(index));
      },
    );
  }

  String getNavRoute(navIndex) {
    switch (navIndex) {
      case 0:
        return bookingRoute;
      case 1:
        return orderRoute;
      case 2:
        return productRoute;
      case 3:
        return paymentRoute;
      default:
        return history;
    }
  }
}
