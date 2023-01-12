import 'package:flutter/material.dart';

class SwitchLandscape extends StatefulWidget {
  bool showChart;
  Function switchChart;
  SwitchLandscape(this.showChart, this.switchChart);
  @override
  State<SwitchLandscape> createState() => _SwitchLandscapeState();
}

class _SwitchLandscapeState extends State<SwitchLandscape> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Show chart',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Switch.adaptive(
          activeColor: Theme.of(context).primaryColor,
          value: widget.showChart,
          onChanged: (val) {
            widget.switchChart(val);
          },
        ),
      ],
    );
  }
}
