import 'package:flutter/material.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/buttons/blaButton.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/LocationPicker.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/SeatPicker.dart';
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

/// Minimal local DatePicker widget to satisfy the usage in this file.
/// It provides the same constructor signature used below: (selectedDate, onDateSelected).
/// If you have a more fully featured DatePicker implementation, you can remove this
/// local widget or adjust accordingly.
class DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePicker({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Date'),
      subtitle: Text('${selectedDate.toLocal()}'.split(' ')[0]),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
    );
  }
}

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
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    }
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

  void _switchLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
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
            // Departure and Switch Location
            Stack(
              children: [
                Column(
                  children: [
                    // Departure LocationPicker
                    LocationPicker(
                      selectedLocation: departure,
                      onLocationSelected: _onDepartureSelected,
                    ),
                    const SizedBox(height: 1),
                    // Divider
                    Container(height: 1, color: Colors.grey[300]),
                    const SizedBox(height: 1),
                    // Arrival LocationPicker
                    LocationPicker(
                      selectedLocation: arrival,
                      onLocationSelected: _onArrivalSelected,
                    ),
                  ],
                ),
                // Switch Button
                Positioned(
                  right: 8,
                  top: 32,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: BlaColors.neutralLight),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.swap_vert),
                      onPressed: _switchLocations,
                      color: Colors.blue,
                      iconSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Divider
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 16),
            // Date Picker
            DatePicker(
              selectedDate: departureDate,
              onDateSelected: _onDateSelected,
            ),
            const SizedBox(height: 16),
            // Divider
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 16),
            // Seat Picker
            SeatPicker(
              selectedSeats: requestedSeats,
              onSeatChange: _onSeatsChanged,
            ),
            const SizedBox(height: 24),
            // Search Button
            BlaButton(
              text: 'Search',
              isPrimary: _isFormValid(),
              onPressed: _isFormValid() ? _onSearchPressed : () {},
            ),
          ],
        ),
      ),
    );
  }
}
