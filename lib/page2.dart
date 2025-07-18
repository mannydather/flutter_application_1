import 'package:flutter/material.dart';
import 'page3.dart';
import 'widgets/base_page.dart';

class MySecondPage extends BasePage {
  const MySecondPage({super.key, required super.title});

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends BasePageState<MySecondPage> {
  @override
  Color get themeColor => Colors.amber;

  @override
  IconData get pageIcon => Icons.looks_two;

  @override
  String get pageTitle => 'Page 2 - Motivational Quotes!';

  @override
  String get quoteType => 'Motivational Quote';

  @override
  String get appBarTitle => "Page II:${widget.title}";

  @override
  Widget? get nextPage => MyThirdPage(title: widget.title);
}
