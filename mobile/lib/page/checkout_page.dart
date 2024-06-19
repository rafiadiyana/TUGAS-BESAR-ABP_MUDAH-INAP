import 'package:course_hotel/config/app_format.dart';
import 'package:course_hotel/widget/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../config/app_route.dart';
import '../controller/c_user.dart';
import '../model/hotel.dart';

class CheckoutPage extends StatelessWidget {
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> receivedData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Hotel hotel = receivedData['hotel'];
    int totalPayment = receivedData['totalPayment'];
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(hotel, context),
          const SizedBox(height: 16),
          roomDetails(context),
          const SizedBox(height: 16),
          paymentMethod(context),
          const SizedBox(height: 20),
          ButtonCustom(
            label: 'Proceed to Payment',
            isExpand: true,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoute.payment,
                arguments: {'hotel': hotel, 'totalPayment': totalPayment},
              );
            },
          ),
        ],
      ),
    );
  }

  Container paymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  AppAsset.iconMandiri,
                  width: 50,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mandiri',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Bank Transfer',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.check_circle, color: AppColor.secondary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container roomDetails(BuildContext context) {
    Map<String, dynamic> receivedData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    int night = receivedData['night'];
    int guest = receivedData['guest'];
    int room = receivedData['room'];
    int totalPayment = receivedData['totalPayment'];
    int roomPrice = receivedData['roomPrice'];
    int nightPrice = receivedData['nightPrice'];
    String breakfast = receivedData['breakfast'];
    String startDate = receivedData['startDate'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Details',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          itemRoomDetail(
            context,
            'Start Date',
            startDate,
          ),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Guest', '${guest} Guest'),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Breakfast', breakfast),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Check-in Time', '14.00 WIB'),
          const SizedBox(height: 8),   
          itemRoomDetail(context, '${night} night', AppFormat.currency((nightPrice.toDouble()))),
          const SizedBox(height: 8),
          itemRoomDetail(context, '${room} room', AppFormat.currency((roomPrice.toDouble()))),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Service fee', AppFormat.currency(100000.toDouble())),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Activities', AppFormat.currency(150000.toDouble())),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Total Payment', AppFormat.currency(totalPayment.toDouble())),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Row itemRoomDetail(BuildContext context, String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Container header(Hotel hotel, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              hotel.cover,
              fit: BoxFit.cover,
              height: 70,
              width: 90,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  hotel.location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
