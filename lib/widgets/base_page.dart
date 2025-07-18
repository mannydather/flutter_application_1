import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/quote_service.dart';
import '../widgets/quote_widgets.dart';
import '../main.dart';
import '../page2.dart';
import '../page3.dart';
import '../page4.dart';
import '../page5.dart';

abstract class BasePage extends StatefulWidget {
  final String title;
  
  const BasePage({super.key, required this.title});
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  String _quote = 'Loading quote...';
  String _author = '';
  bool _isLoadingQuote = true;
  final QuoteService _quoteService = QuoteService();

  // Abstract methods to be implemented by each page
  Color get themeColor;
  IconData get pageIcon;
  String get pageTitle;
  String get quoteType;
  String get appBarTitle;
  Widget? get nextPage;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    setState(() {
      _isLoadingQuote = true;
      _quote = 'Loading quote...';
      _author = '';
    });

    final quoteData = await _quoteService.fetchQuote();
    
    setState(() {
      _quote = quoteData['text'] ?? 'No quote available';
      _author = quoteData['author'] ?? 'Unknown';
      _isLoadingQuote = false;
    });
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: themeColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text(
            'Navigate to:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildNavButton(
                context,
                icon: Icons.home,
                label: 'Home',
                color: Colors.blue,
                onTap: () => _navigateToPage(context, 'home'),
              ),
              _buildNavButton(
                context,
                icon: Icons.looks_two,
                label: 'Page 2',
                color: Colors.amber,
                onTap: () => _navigateToPage(context, 'page2'),
              ),
              _buildNavButton(
                context,
                icon: Icons.looks_3,
                label: 'Page 3',
                color: Colors.green,
                onTap: () => _navigateToPage(context, 'page3'),
              ),
              _buildNavButton(
                context,
                icon: Icons.looks_4,
                label: 'Page 4',
                color: Colors.purple,
                onTap: () => _navigateToPage(context, 'page4'),
              ),
              _buildNavButton(
                context,
                icon: Icons.looks_5,
                label: 'Page 5',
                color: Colors.red,
                onTap: () => _navigateToPage(context, 'page5'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String page) {
    Widget? targetPage;
    switch (page) {
      case 'home':
        targetPage = MyHomePage(title: widget.title);
        break;
      case 'page2':
        targetPage = MySecondPage(title: widget.title);
        break;
      case 'page3':
        targetPage = MyThirdPage(title: widget.title);
        break;
      case 'page4':
        targetPage = MyFourthPage(title: widget.title);
        break;
      case 'page5':
        targetPage = MyFifthPage(title: widget.title);
        break;
    }
    
    if (targetPage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => targetPage!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchQuote,
            tooltip: 'Refresh Quote',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PageHeaderWidget(
                icon: pageIcon,
                title: pageTitle,
                themeColor: themeColor,
              ),
              
              QuoteDisplayWidget(
                quote: _quote,
                author: _author,
                isLoading: _isLoadingQuote,
                themeColor: themeColor,
                quoteType: quoteType,
              ),
              
              const SizedBox(height: 32),
              
              // Navigation Buttons
              _buildNavigationButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}
