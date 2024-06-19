import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config/app_route.dart';
import '../config/app_color.dart';
import '../controller/c_user.dart';
import '../model/booking.dart';
import '../model/hotel.dart';
import '../source/booking_source.dart';
import '../widget/button_custom.dart';

class HotelBookingForm extends StatefulWidget {
  @override
  _HotelBookingFormState createState() => _HotelBookingFormState();
}

class _HotelBookingFormState extends State<HotelBookingForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();

  String _includeBreakfast = 'Included'; // default value
  List<String> _includeBreakfastOptions = ['Included', 'Not Included'];

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Hotel hotel = ModalRoute.of(context)!.settings.arguments as Hotel;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotel Booking Form',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start Date',
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _startDateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  hintText: 'Select Start Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColor.secondary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a start date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Duration (Night)',
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  hintText: 'Enter duration',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColor.secondary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the duration';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Number of Guest(s)',
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _guestsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  hintText: 'Enter number of guests (max 2 per room)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColor.secondary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of guest(s)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Number of Room(s)',
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _roomsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  hintText: 'Enter number of room(s)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColor.secondary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of room(s)';
                  } else {
                    int guests = int.tryParse(_guestsController.text) ?? 0;
                    int rooms = int.tryParse(value) ?? 0;
                    if (rooms > guests) {
                      return 'Number of room(s) cannot be more than \nthe number of guest(s)';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Breakfast',
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _includeBreakfast,
                onChanged: (String? newValue) {
                  setState(() {
                    _includeBreakfast = newValue ?? '';
                  });
                },
                items: _includeBreakfastOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              ButtonCustom(
                label: 'Booking Now',
                isExpand: true,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    int night = int.tryParse(_durationController.text) ?? 0;
                    int room = int.tryParse(_roomsController.text) ?? 0;
                    int guest = int.tryParse(_guestsController.text) ?? 1;
                    int totalPayment = (hotel.price * night * room) + 100000 + 150000;
                    int nightPrice = hotel.price * night;
                    int roomPrice = hotel.price * room;
                    String breakfast = _includeBreakfast;
                    String startDate = _startDateController.text;

                    final cUser = Get.put(CUser());
                    BookingSource.addBooking(
                      cUser.data.id!,
                      Booking(
                        id: '',
                        idHotel: hotel.id,
                        cover: hotel.cover,
                        name: hotel.name,
                        location: hotel.location,
                        date: _startDateController.text,
                        guest: guest,
                        breakfast: breakfast,
                        checkInTime: '14.00 WIB',
                        night: night,
                        room: room,
                        serviceFee: 100000,
                        activities: 150000,
                        totalPayment: totalPayment,
                        roomPrice: roomPrice,
                        nightPrice: nightPrice,
                        status: 'PAID',
                        isDone: false,
                      ),
                    );
                    Navigator.pushNamed(
                      context,
                      AppRoute.checkout,
                      arguments: {
                        'hotel': hotel,
                        'night': night,
                        'room': room,
                        'totalPayment': totalPayment,
                        'breakfast': breakfast,
                        'startDate': startDate,
                        'guest': guest,
                        'nightPrice': nightPrice,
                        'roomPrice': roomPrice,
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
