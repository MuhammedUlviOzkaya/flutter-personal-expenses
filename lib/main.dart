import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './widgets/switch_landscape.dart';
import './widgets/landscape_chart.dart';
import './widgets/portrait_chart.dart';
import './widgets/pg_body.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buz Flutter App',
      theme: ThemeData(
        errorColor: Colors.red.shade800,
        scaffoldBackgroundColor: Colors.orange[100],
        primarySwatch: Colors.purple,
        secondaryHeaderColor: Colors.orange,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.green,
        ),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        textTheme:
            //GoogleFonts.emilysCandyTextTheme(),
            const TextTheme(
          headline1: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChart = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      amount: 700,
      title: 'White Air Force Low',
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      amount: 30,
      title: 'Coffee shopping',
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: txDate);

    setState(() {
      _userTransactions.add(newTx);
    });
    print(txTitle);
  }

  // String titleInput;
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: ((_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      }),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _switchChart(val) {
    setState(() {
      _showChart = val;
    });
  }

  Widget _buildFloatingButton() {
    return Tooltip(
      message: 'Add new transaction!',
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() => _startAddNewTransaction(context)),
      ),
    );
  }

  Widget _buildCupertinoNav() {
    return CupertinoNavigationBar(
      middle: Text('Buz Expenses iOS'),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
          onTap: (() => _startAddNewTransaction(context)),
          child: Icon(CupertinoIcons.add),
        )
      ]),
    );
  }

  Widget _buildAndroidAppBar() {
    return AppBar(
      title: Text(
        'Buz Expenses App',
        style:
            // TextStyle(
            //     fontFamily: 'Quicksand',
            //     color: Colors.yellow.shade600,
            //     fontSize: 25),
            Theme.of(context).textTheme.headline1,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (() => _startAddNewTransaction(context)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildCupertinoNav() : _buildAndroidAppBar();

    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.73,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: PgBody(isLandScape, _showChart, _switchChart, txListWidget,
            mediaQuery, appBar, _recentTransactions),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
                Platform.isIOS ? Container() : _buildFloatingButton());
  }
}
