import 'package:flutter/material.dart';

class SeatPicker extends StatelessWidget {
  final int selectedSeats;
  final void Function(int) onSeatChange;

  const SeatPicker({
    Key? key,
    required this.selectedSeats,
    required this.onSeatChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Seats: $selectedSeats'),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: selectedSeats > 1
              ? () => onSeatChange(selectedSeats - 1)
              : null,
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => onSeatChange(selectedSeats + 1),
        ),
      ],
    );
  }
}
