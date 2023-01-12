import 'package:flutter/material.dart';

import './chart.dart';

class PortraitChart extends StatelessWidget {
  MediaQueryData _mediaQuery;
  PreferredSizeWidget _appBar;
  List _recentTransactions;

  PortraitChart(this._mediaQuery, this._appBar, this._recentTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: (_mediaQuery.size.height -
                _appBar.preferredSize.height -
                _mediaQuery.padding.top) *
            0.27,
        child: Chart(_recentTransactions));
  }
}
