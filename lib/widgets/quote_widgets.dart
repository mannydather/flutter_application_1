import 'package:flutter/material.dart';

class QuoteDisplayWidget extends StatelessWidget {
  final String quote;
  final String author;
  final bool isLoading;
  final Color themeColor;
  final String quoteType;

  const QuoteDisplayWidget({
    super.key,
    required this.quote,
    required this.author,
    required this.isLoading,
    required this.themeColor,
    required this.quoteType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeColor.withOpacity(0.1),
            themeColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isLoading)
            Column(
              children: [
                CircularProgressIndicator(
                  color: themeColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading inspiration...',
                  style: TextStyle(
                    fontSize: 14,
                    color: themeColor.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                // Opening quotation mark
                Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: const Offset(-8, 0),
                    child: Text(
                      '"',
                      style: TextStyle(
                        fontSize: 64,
                        color: themeColor.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                        height: 0.8,
                      ),
                    ),
                  ),
                ),
                
                // Quote text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    quote,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: themeColor,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                // Closing quotation mark
                Align(
                  alignment: Alignment.centerRight,
                  child: Transform.translate(
                    offset: const Offset(8, -16),
                    child: Text(
                      '"',
                      style: TextStyle(
                        fontSize: 64,
                        color: themeColor.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                        height: 0.8,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Author
                if (author.isNotEmpty)
                  Text(
                    '— $author',
                    style: TextStyle(
                      fontSize: 16,
                      color: themeColor.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                
                const SizedBox(height: 12),
                
                // Quote type badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: themeColor.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    quoteType,
                    style: TextStyle(
                      fontSize: 12,
                      color: themeColor.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class CounterDisplayWidget extends StatelessWidget {
  final int counter;
  final Color themeColor;

  const CounterDisplayWidget({
    super.key,
    required this.counter,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'You have pushed the button this many times:',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: themeColor.withOpacity(0.3)),
          ),
          child: Text(
            '$counter',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: themeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class PageHeaderWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color themeColor;

  const PageHeaderWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 80,
          color: themeColor,
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: themeColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
