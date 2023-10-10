// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:okapy_dashboard/core/routes/route_strings.dart';
// import 'package:okapy_dashboard/core/ui/component/card_list_tile.dart';
// import 'package:okapy_dashboard/core/ui/constants.dart';
// import 'package:okapy_dashboard/order/controller/order_controller.dart';
// import 'package:okapy_dashboard/product/controller/product_controller.dart';
// import 'package:provider/provider.dart';
//
// class OrderDetails extends StatelessWidget {
//   static const String route = orderDetailsRoute;
//
//   const OrderDetails({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     const headingTextStyle =
//         TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
//     const fontNormalTextStyle = TextStyle(
//       fontSize: 16,
//     );
//     return Scaffold(body:
//         Consumer<OrderController>(builder: (context, orderController, child) {
//       const cardPadding = EdgeInsets.all(10.0);
//       return Consumer<ProductController>(
//           builder: (context, productController, child) {
//         return SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               GestureDetector(
//                 onTap: () => context.go(homeRoute),
//                 child: Text(
//                   "Back",
//                   style: TextStyle(
//                     color: AppColors.primaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Booking",
//                     style: headingTextStyle,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: Text(
//                       "Status: ${orderController.getOrderStatusName(orderController.selectedOrder)}",
//                       style: fontNormalTextStyle,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Card(
//                 child: Padding(
//                   padding: cardPadding,
//                   child: Column(
//                     children: [
//                       CardListTile(
//                         title: "Booking ID",
//                         subtitle:
//                             '${orderController.receiver!.booking?.bookingId}',
//                       ),
//                       CardListTile(
//                         title: "Amount",
//                         subtitle: '${orderController.order!.amount}',
//                       ),
//                       CardListTile(
//                         title: "Created At",
//                         subtitle:
//                             '${orderController.receiver!.booking?.dateCreated}',
//                       ),
//                       CardListTile(
//                         title: "Scheduled For",
//                         subtitle:
//                             '${orderController.receiver!.booking?.scheduledDate}',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 "Receiver Information",
//                 style: headingTextStyle,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Card(
//                   child: Padding(
//                 padding: cardPadding,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CardListTile(
//                       title: "Full Name",
//                       subtitle: "${orderController.receiver!.name}",
//                     ),
//                     CardListTile(
//                       title: "Phone number",
//                       subtitle: "${orderController.receiver!.phonenumber}",
//                     ),
//                     CardListTile(
//                       title: "Location",
//                       subtitle: "${orderController.receiver!.formatedAddress}",
//                     ),
//                   ],
//                 ),
//               )),
//               const SizedBox(
//                 height: 20,
//               ),
//               // const Text(
//               //   "Product Information",
//               //   style: headingTextStyle,
//               // ),
//               // const SizedBox(
//               //   height: 10,
//               // ),
//               // Card(
//               //     child: Padding(
//               //   padding: cardPadding,
//               //   child: CardListTile.image(
//               //     image: "${productController.product!.image}",
//               //     title:
//               //         "${productController.getProductStatusName("${productController.product!.productType}")}",
//               //     subtitle: "${productController.product!.instructions}",
//               //   ),
//               // ))
//             ],
//           ),
//         );
//       });
//     }));
//   }
// }
