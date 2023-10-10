import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapy/screens/outgoin/outgoing.dart';
import 'package:okapy/screens/utils/colors.dart';

Column ongoingDummy(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 25),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/1.png",
                        ),
                      )),
                ),
              ),
              Positioned(
                right: 35,
                top: 15,
                child: Container(
                  height: 20,
                  width: 99,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      'From Naivas',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff1A411D),
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/2.png"),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: const [
                  Text(
                    "KCB 3470K",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Peter Glitex",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: const [
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star_half_rounded,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffF2C110),
                    ),
                  )
                ],
              )
            ],
          ),
          trailing: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xff1A411D),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '20',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'MIN',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              children: [
                Image.asset('assets/From.png'),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                  child: Text(
                    'From',
                    style: TextStyle(fontSize: 8, color: themeColorGrey),
                  ),
                ),
                const Text(
                  'NBO',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/dots.png'),
                ),
                Image.asset('assets/location-icon.png'),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                  child: Text(
                    'To',
                    style: TextStyle(fontSize: 8, color: themeColorGrey),
                  ),
                ),
                const Text(
                  'MSA',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: '1',
              backgroundColor: const Color(0xffF7E3E0),
              elevation: 0,
              onPressed: () {},
              child: const Icon(
                Icons.close_rounded,
                size: 35,
                color: Color(0xffBB1600),
              ),
            ),
            FloatingActionButton(
              heroTag: '2',
              backgroundColor: const Color(0xffFFF6DC),
              elevation: 0,
              onPressed: () {},
              child: const Icon(
                Icons.chat_outlined,
                size: 30,
                color: Color(0xff1A411D),
              ),
            ),
            FloatingActionButton(
              heroTag: '3',
              backgroundColor: const Color(0xffFFF6DC),
              elevation: 0,
              onPressed: () {},
              child: Image.asset(
                'assets/phone-green.png',
                height: 30,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 326,
          height: 49,
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColorAmber)),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  Outgoing(bookingDetailsModel: book,)),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Create bookings',
                    style: TextStyle(color: Color(0xff1A411D), fontSize: 14),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 1.2) / 3,
                    child: const Center(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Color(0xff1A411D),
                      ),
                    ),
                  )
                ],
              )),
        ),
      )
    ],
  );
}

Column scheduledDummy(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 25),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/1.png",
                        ),
                      )),
                ),
              ),
              Positioned(
                right: 35,
                top: 15,
                child: Container(
                  height: 20,
                  width: 99,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      'From walmart',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff1A411D),
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/2.png"),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: const [
                  Text(
                    "KCB 3470K",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Muhu Njenga",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: const [
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Icon(
                    Icons.star_half_rounded,
                    size: 18,
                    color: Color(0xffF2C110),
                  ),
                  Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffF2C110),
                    ),
                  )
                ],
              )
            ],
          ),
          trailing: Column(
            children: [
              Image.asset('assets/clock-icon.png'),
              const Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Text(
                  '12:30 PM',
                  style: TextStyle(fontSize: 11),
                ),
              ),
              const Text(
                '22/07/2022',
                style: TextStyle(fontSize: 11),
              )
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset('assets/From.png'),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                      child: Text(
                        'Pickup',
                        style: TextStyle(fontSize: 12, color: themeColorGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Dubai',
                        style: TextStyle(
                            color: themeColorGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Image.asset('assets/location-icon.png'),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                      child: Text(
                        'Destination',
                        style: TextStyle(fontSize: 12, color: themeColorGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Turkey',
                        style: TextStyle(
                            color: themeColorGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
                elevation: 0,
                heroTag: 'cancel',
                backgroundColor: Colors.transparent,
                onPressed: () {},
                label: Row(
                  children: const [
                    Icon(
                      Icons.close_rounded,
                      size: 35,
                      color: Color(0xffBB1600),
                    ),
                    Text('Cancel')
                  ],
                )),
            FloatingActionButton.extended(
                elevation: 0,
                heroTag: 'chat',
                backgroundColor: Colors.transparent,
                onPressed: () {},
                label: Row(
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      size: 30,
                      color: themeColorAmber,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        color: themeColorGreen,
                      ),
                    )
                  ],
                )),
            FloatingActionButton.extended(
                elevation: 0,
                heroTag: 'call',
                backgroundColor: Colors.transparent,
                onPressed: () {},
                label: Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 30,
                      color: themeColorAmber,
                    ),
                    Text(
                      'Call',
                      style: TextStyle(
                        color: themeColorGreen,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 326,
          height: 49,
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColorAmber)),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  Outgoing()),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Create bookings',
                    style: TextStyle(color: Color(0xff1A411D), fontSize: 14),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 1.2) / 3,
                    child: const Center(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Color(0xff1A411D),
                      ),
                    ),
                  )
                ],
              )),
        ),
      )
    ],
  );
}
