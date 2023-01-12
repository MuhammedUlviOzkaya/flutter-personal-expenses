import 'package:flutter/material.dart';

import './chart.dart';

class LandscapeChart extends StatelessWidget {
  MediaQueryData _mediaQuery;
  PreferredSizeWidget _appBar;
  List _recentTransactions;
  LandscapeChart(this._mediaQuery, this._appBar, this._recentTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: (_mediaQuery.size.height -
                _appBar.preferredSize.height -
                _mediaQuery.padding.top) *
            0.7,
        child: Chart(_recentTransactions));
  }
}
