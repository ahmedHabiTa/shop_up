import 'package:flutter/material.dart';
class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('search'),
      ),
    );
  }
}
