import 'package:course_hotel/config/app_asset.dart';
import 'package:course_hotel/config/app_format.dart';
import 'package:course_hotel/config/app_route.dart';
import 'package:course_hotel/widget/button_custom.dart';
import 'package:flutter/material.dart';

import '../model/hotel.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> receivedData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Hotel hotel = receivedData['hotel'];
    int totalPayment = receivedData['totalPayment'];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 6, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                hotel.cover,
                width: 190,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 46),
          Text(
            'Total Payment',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            AppFormat.currency(totalPayment.toDouble()),
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Container(
            height: 100,
            width: 300,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              border: Border.all(width: 6, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Teks
      Column(
        children: [
          SizedBox(height: 12),
          Text(
            'Please Transfer to\nPT. Mudah Inap\n123 00 45 67 0000',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      SizedBox(width: 12),
      Image.asset(
                  AppAsset.iconMandiri,
                  width: 70,
                ),
    ],
  ),
          ),
          const SizedBox(height: 46),
          ButtonCustom(
            label: 'I Have Completed Payment',
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoute.checkoutSuccess,
                arguments: hotel,
              );
            },
          ),
        ],
      ),
    );
  }
}
