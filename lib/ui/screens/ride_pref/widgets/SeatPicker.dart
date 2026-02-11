import 'package:flutter/material.dart';

class SeatPicker extends StatefulWidget {
  final int selectedSeats;
  final ValueChanged<int> onSeatChange;

  const SeatPicker({
    super.key,
    required this.selectedSeats,
    required this.onSeatChange,
  });

  @override
  State<SeatPicker> createState() => _SeatPickerState();
}

class _SeatPickerState extends State<SeatPicker> {
  late int seats;

  @override
  void initState() {
    super.initState();
    seats = widget.selectedSeats;
  }

  void increase() {
    setState(() {
      seats++;
    });
    widget.onSeatChange(seats);
  }

  void decrease() {
    if (seats > 1) {
      setState(() {
        seats--;
      });
      widget.onSeatChange(seats);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.remove), onPressed: decrease),
        Text('$seats'),
        IconButton(icon: const Icon(Icons.add), onPressed: increase),
      ],
    );
  }
}
