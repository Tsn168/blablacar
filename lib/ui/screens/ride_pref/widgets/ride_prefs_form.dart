import 'package:flutter/material.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/utils/date_time_utils.dart';
import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/ui/widgets/blaButton.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/LocationPicker.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/DatePicker.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/SeatPicker.dart';
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  DateTime departureDate = DateTime.now();
  Location? arrival;
  int requestedSeats = 1;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
  }

  void _onDepartureSelected(Location location) {
    setState(() => departure = location);
  }

  void _onArrivalSelected(Location location) {
    setState(() => arrival = location);
  }

  void _onDateSelected(DateTime date) {
    setState(() => departureDate = date);
  }

  void _onSeatsChanged(int seats) {
    setState(() => requestedSeats = seats);
  }

  bool _isFormValid() {
    return departure != null && arrival != null;
  }

  void _onSearchPressed() {
    if (_isFormValid()) {
      final ridePref = RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      );
      print('Search: $ridePref');
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // LocationPicker for departure
            LocationPicker(
              selectedLocation: departure,
              onLocationSelected: _onDepartureSelected,
            ),
            const SizedBox(height: 12),
            // LocationPicker for arrival
            LocationPicker(
              selectedLocation: arrival,
              onLocationSelected: _onArrivalSelected,
            ),
            const SizedBox(height: 12),
            DatePickerWidget(
              selectedDate: departureDate,
              onDateSelected: _onDateSelected,
            ),
            const SizedBox(height: 12),
            SeatPicker(
              selectedSeats: requestedSeats,
              onSeatChange: _onSeatsChanged,
            ),
            const SizedBox(height: 12),
            BlaButton(
              text: 'Search Rides',
              isPrimary: _isFormValid(),
              onPressed: _isFormValid() ? _onSearchPressed : () {},
            ),
          ],
        ),
      ),
    );
  }
}
