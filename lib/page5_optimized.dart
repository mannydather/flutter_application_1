import 'package:flutter/material.dart';
import 'main.dart';
import 'widgets/base_page.dart';

class MyFifthPage extends BasePage {
  const MyFifthPage({super.key, required super.title});

  @override
  State<MyFifthPage> createState() => _MyFifthPageState();
}

class _MyFifthPageState extends BasePageState<MyFifthPage> {
  @override
  Color get themeColor => Colors.red;

  @override
  IconData get pageIcon => Icons.looks_5;

  @override
  String get pageTitle => 'Page 5 - Life Quotes!';

  @override
  String get quoteType => 'Life Quote';

  @override
  String get appBarTitle => "Page V:${widget.title}";

  @override
  Widget? get nextPage => MyHomePage(title: widget.title);
}
