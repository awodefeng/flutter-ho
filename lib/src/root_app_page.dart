
import 'package:flutter/material.dart';

import 'index_page.dart';

class RootApp extends StatefulWidget{
  const RootApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RootAppState();
  }
}

class _RootAppState extends State{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
  
}