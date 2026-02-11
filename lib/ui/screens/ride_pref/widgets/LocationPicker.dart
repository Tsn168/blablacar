import 'package:blabla/model/ride/locations.dart';
import 'package:flutter/material.dart';
import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/LocationPickerModal.dart';

class LocationPicker extends StatefulWidget {
  final Location? selectedLocation;
  final ValueChanged<Location> onLocationSelected;

  const LocationPicker({
    super.key,
    this.selectedLocation,
    required this.onLocationSelected,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  Location? currentLocation;

  @override
  void initState() {
    super.initState();
    currentLocation = widget.selectedLocation;
  }

  void _openLocationPickerModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LocationPickerModal(
        selectedLocation: currentLocation,
        onSelected: (location) {
          currentLocation = location;
          widget.onLocationSelected(location);
        },
      ),
    );
  }

  void didUpdateWidget(LocationPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedLocation != oldWidget.selectedLocation) {
      setState(() => currentLocation = widget.selectedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openLocationPickerModal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: BlaColors.neutralDark),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, color: BlaColors.neutralLight),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                currentLocation?.name ?? 'Select location',
                style: BlaTextStyles.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
