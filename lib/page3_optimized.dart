import 'package:flutter/material.dart';
import 'page4.dart';
import 'widgets/base_page.dart';

class MyThirdPage extends BasePage {
  const MyThirdPage({super.key, required super.title});

  @override
  State<MyThirdPage> createState() => _MyThirdPageState();
}

class _MyThirdPageState extends BasePageState<MyThirdPage> {
  @override
  Color get themeColor => Colors.green;

  @override
  IconData get pageIcon => Icons.looks_3;

  @override
  String get pageTitle => 'Page 3 - Inspirational Quotes!';

  @override
  String get quoteType => 'Inspirational Quote';

  @override
  String get appBarTitle => "Page III:${widget.title}";

  @override
  Widget? get nextPage => MyFourthPage(title: widget.title);
}
