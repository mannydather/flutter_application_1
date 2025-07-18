import 'package:flutter/material.dart';
import 'page5.dart';
import 'widgets/base_page.dart';

class MyFourthPage extends BasePage {
  const MyFourthPage({super.key, required super.title});

  @override
  State<MyFourthPage> createState() => _MyFourthPageState();
}

class _MyFourthPageState extends BasePageState<MyFourthPage> {
  @override
  Color get themeColor => Colors.purple;

  @override
  IconData get pageIcon => Icons.looks_4;

  @override
  String get pageTitle => 'Page 4 - Wisdom Quotes!';

  @override
  String get quoteType => 'Wisdom Quote';

  @override
  String get appBarTitle => "Page IV:${widget.title}";

  @override
  Widget? get nextPage => MyFifthPage(title: widget.title);
}
