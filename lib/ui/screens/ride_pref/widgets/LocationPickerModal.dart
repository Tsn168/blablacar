import 'package:flutter/material.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/ui/theme/theme.dart';

class LocationPickerModal extends StatefulWidget {
  final Location? selectedLocation;
  final ValueChanged<Location> onSelected;

  const LocationPickerModal({
    super.key,
    this.selectedLocation,
    required this.onSelected,
  });

  @override
  State<LocationPickerModal> createState() => _LocationPickerModalState();
}

class _LocationPickerModalState extends State<LocationPickerModal> {
  late TextEditingController _searchController;
  List<Location> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredLocations = fakeLocations;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onChange(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLocations = fakeLocations;
      } else {
        _filteredLocations = fakeLocations
            .where(
              (location) =>
                  location.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  void _onTab(Location location) {
    widget.onSelected(location);
    Navigator.pop(context);
  }

  void _onPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          // Header with TextField and close button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onChange,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _onPressed,
                ),
              ],
            ),
          ),
          const Divider(),
          // ListView with ListTile
          Expanded(
            child: _filteredLocations.isEmpty
                ? const Center(child: Text('No locations found'))
                : ListView.builder(
                    itemCount: _filteredLocations.length,
                    itemBuilder: (context, index) {
                      final location = _filteredLocations[index];
                      return ListTile(
                        title: Text(location.name),
                        subtitle: Text(location.country.name),
                        onTap: () => _onTab(location),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
