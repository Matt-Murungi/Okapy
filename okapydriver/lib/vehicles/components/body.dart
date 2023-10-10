import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/addvehicle/addvehcle.dart';
import 'package:okapydriver/state/vehicles.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VehiclesController>(
      builder: (context, vehiclesController, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text('My vehicles'),
        ),
        body: vehiclesController.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                ...vehiclesController.vehicleList
                    .map(
                      (vehicle) => ListTile(
                        leading: SizedBox(
                            child: vehicle.vehicleType == 4
                                ? Image.asset('assets/truck.png', height: 76)
                                : vehicle.vehicleType == 3
                                    ? Image.asset('assets/van.png', height: 76)
                                    : vehicle.vehicleType == 2
                                        ? Image.asset('assets/vehicle.png',
                                            height: 76)
                                        : vehicle.vehicleType == 1
                                            ? Image.asset(
                                                'assets/motorcycle.png',
                                                height: 76,
                                              )
                                            : const SizedBox()),
                        title: Text(' ${vehicle.regNumber} ${vehicle.vehicleType}'),

                        trailing: Container(
                          height: 25,
                          width: 57,
                          child: const Center(
                              child: Text(
                            'Active',
                            style: TextStyle(color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green),
                        ),
                      ),
                    )
                    .toList(),
                const Divider(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AddVehicle.routerName);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Icon(
                          Icons.add,
                          color: themeColorAmber,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Add vehicle',
                          style: TextStyle(color: themeColorAmber),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
      ),
    );
  }
}
