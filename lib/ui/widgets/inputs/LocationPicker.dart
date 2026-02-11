import 'package:flutter/material.dart';
import 'package:blabla/model/ride/locations.dart';

class LocationPicker extends StatelessWidget {
  final Location? selectedLocation;
  final void Function(Location) onLocationSelected;

  const LocationPicker({
    Key? key,
    required this.selectedLocation,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Show bottom sheet or dialog to pick location
        final Location? location = await showModalBottomSheet<Location>(
          context: context,
          builder: (_) {
            return ListView(
              children: [
                ListTile(
                  title: Text('Dijon, France'),
                  onTap: () => Navigator.pop(
                    context,
                    Location(name: 'Dijon', country: Country.france),
                  ),
                ),
                ListTile(
                  title: Text('Paris, France'),
                  onTap: () => Navigator.pop(
                    context,
                    Location(name: 'Paris', country: Country.france),
                  ),
                ),
              ],
            );
          },
        );
        if (location != null) onLocationSelected(location);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedLocation?.name ?? 'Select location'),
            Icon(Icons.location_on),
          ],
        ),
      ),
    );
  }
}
