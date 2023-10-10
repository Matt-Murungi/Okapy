import 'package:flutter/material.dart';
import 'package:okapy/core/ui/components/app_bar.dart';
import 'package:okapy/core/ui/components/input.dart';
import 'package:okapy/core/ui/components/loading_widget.dart';
import 'package:okapy/core/ui/components/snackbar.dart';
import 'package:okapy/screens/partners/partner_product.dart';
import 'package:okapy/screens/utils/colors.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/utils/constants.dart';
import 'package:provider/provider.dart';

class Patners extends StatefulWidget {
  static const String route = "partners";
  const Patners({Key? key}) : super(key: key);

  @override
  State<Patners> createState() => _PatnersState();
}

class _PatnersState extends State<Patners> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    setState(() {
      searchController.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: buildAppBar('Partners'),
      body: Consumer<Bookings>(
          builder: (context, bookingsController, child) => bookingsController
                  .isLoading
              ? const LoadingWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      height: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Search(
                        searchController: searchController,
                        onChanged: (value) => bookingsController
                            .searchPartner(searchController.text)),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: bookingsController
                                  .filteredPartnerSearch.isEmpty
                              ? const Center(
                                  child: Text(
                                      "Your search is not available. Try another"),
                                )
                              : GridView.count(
                                  crossAxisCount: 2,
                                  children: List.generate(
                                      bookingsController
                                          .filteredPartnerSearch.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: InkWell(
                                                      onTap: bookingsController
                                                              .filteredPartnerSearch[
                                                                  index]
                                                              .isPartnerAvailable!
                                                          ? () {
                                                              bookingsController
                                                                  .getPartnerProduct(
                                                                      bookingsController
                                                                              .filteredPartnerSearch[
                                                                          index])
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            if (value ==
                                                                                true)
                                                                              {
                                                                                bookingsController.setSelectedPartner(bookingsController.filteredPartnerSearch[index]),
                                                                                Navigator.of(context).push(
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => const PartnerProduct(),
                                                                                  ),
                                                                                ),
                                                                              }
                                                                            else
                                                                              {
                                                                                buildToast(bookingsController.errorMessage)
                                                                              }
                                                                          });
                                                            }
                                                          : () {},
                                                      child: Stack(
                                                        children: [
                                                          bookingsController
                                                                      .filteredPartnerSearch[
                                                                          index]
                                                                      .image !=
                                                                  null
                                                              ? Image.network(
                                                                  "$serverUrlAssets${bookingsController.filteredPartnerSearch[index].image}",
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                )
                                                              : Image.asset(
                                                                  "assets/addal.png",
                                                                  width: double
                                                                          .infinity /
                                                                      2,
                                                                ),
                                                          !bookingsController
                                                                  .filteredPartnerSearch[
                                                                      index]
                                                                  .isPartnerAvailable!
                                                              ? Positioned.fill(
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .black54,
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        'Closed',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox
                                                                  .shrink()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${bookingsController.filteredPartnerSearch[index].name}",
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  bookingsController.calculateDistance(
                                                              bookingsController
                                                                  .filteredPartnerSearch[
                                                                      index]
                                                                  .latitude,
                                                              bookingsController
                                                                  .filteredPartnerSearch[
                                                                      index]
                                                                  .longitude) !=
                                                          0
                                                      ? "About ${bookingsController.calculateDistance(bookingsController.filteredPartnerSearch[index].latitude, bookingsController.filteredPartnerSearch[index].longitude)} km"
                                                      : "Near you",
                                                  style: TextStyle(
                                                      color: themeColorGrey,
                                                      fontSize: 12),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          )),
                                )),
                    )
                  ],
                )),
    );
  }
}
