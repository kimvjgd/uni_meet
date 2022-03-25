import 'package:flutter/cupertino.dart';

class AgeBottomSheet extends StatelessWidget {
  final int age;
  const AgeBottomSheet({
    required this.age,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
        itemExtent: 30,
        onSelectedItemChanged: (int value) {
        },
        children: [
          Text('20'),
          Text('21'),
          Text('22'),
          Text('23'),
          Text('24'),
          Text('25'),
          Text('26'),
          Text('27'),
          Text('28'),
          Text('29'),
        ]);
  }
}
