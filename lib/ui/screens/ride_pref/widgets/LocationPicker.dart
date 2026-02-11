import 'package:blabla/model/ride/locations.dart';
import 'package:flutter/material.dart';
import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/ui/theme/theme.dart';

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
      builder: (context) => (fakeLocations.isEmpty)
          ? const Center(child: Text('No locations available'))
          : ListView.builder(
              itemCount: fakeLocations.length,
              itemBuilder: (context, index) {
                final location = fakeLocations[index];
                return ListTile(
                  title: Text(location.name),
                  onTap: () {
                    setState(() => currentLocation = location);
                    widget.onLocationSelected(location);
                    Navigator.pop(context);
                  },
                );
              },
            ),
    );
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
