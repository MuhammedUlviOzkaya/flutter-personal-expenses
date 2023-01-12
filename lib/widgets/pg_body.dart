import 'package:flutter/material.dart';

import './switch_landscape.dart';
import './portrait_chart.dart';
import './landscape_chart.dart';

class PgBody extends StatelessWidget {
  bool isLandScape;
  bool _showChart;
  Function _switchChart;
  Container txListWidget;
  MediaQueryData _mediaQuery;
  PreferredSizeWidget _appBar;
  List _recentTransactions;

  PgBody(
      this.isLandScape,
      this._showChart,
      this._switchChart,
      this.txListWidget,
      this._mediaQuery,
      this._appBar,
      this._recentTransactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (isLandScape) SwitchLandscape(_showChart, _switchChart),
        if (!isLandScape)
          PortraitChart(_mediaQuery, _appBar, _recentTransactions),
        if (!isLandScape) txListWidget,
        if (isLandScape)
          _showChart
              ? LandscapeChart(_mediaQuery, _appBar, _recentTransactions)
              : txListWidget
      ],
    );
  }
}
