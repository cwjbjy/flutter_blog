import 'package:flutter/material.dart';

class CompositePage extends StatefulWidget {
  const CompositePage({super.key});

  @override
  State<CompositePage> createState() => _CompositePageState();
}

class _CompositePageState extends State<CompositePage> {
  @override
  Widget build(BuildContext context) {
    return Text('页面1');
  }
}
