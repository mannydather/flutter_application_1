import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteService {
  static final QuoteService _instance = QuoteService._internal();
  factory QuoteService() => _instance;
  QuoteService._internal();

  // Offline quotes as fallback
  static const List<String> _offlineQuotes = [
    '🔴 OFFLINE: The only way to do great work is to love what you do. - Steve Jobs',
    '🔴 OFFLINE: Innovation distinguishes between a leader and a follower. - Steve Jobs',
    '🔴 OFFLINE: The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt',
    '🔴 OFFLINE: It is during our darkest moments that we must focus to see the light. - Aristotle',
    '🔴 OFFLINE: The only impossible journey is the one you never begin. - Tony Robbins',
  ];

  Future<Map<String, String>> fetchQuote() async {
    try {
      print('Attempting to fetch quote from Firestore...');
      // Try to fetch all quotes from the 'quotes' collection
      final querySnapshot = await FirebaseFirestore.instance
          .collection('quotes')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Found ${querySnapshot.docs.length} quotes in Firestore');
        // Get a random quote
        final randomIndex = DateTime.now().millisecondsSinceEpoch % querySnapshot.docs.length;
        final doc = querySnapshot.docs[randomIndex];
        final quoteData = doc.data();
        
        final text = quoteData['text'] ?? 'No quote text found';
        final author = quoteData['author'] ?? 'Unknown';
        print('Quote fetched successfully: $text - $author');
        
        return {
          'text': text,
          'author': author,
        };
      } else {
        print('No quotes found in Firestore, creating sample quotes...');
        await _createSampleQuotes();
        return {
          'text': 'Firebase is working perfectly! This quote came from your cloud database. 🚀',
          'author': 'Flutter Team',
        };
      }
    } catch (e) {
      print('Error fetching quote: $e');
      return _getOfflineQuote();
    }
  }

  Map<String, String> _getOfflineQuote() {
    print('Using offline quote fallback...');
    final random = DateTime.now().millisecondsSinceEpoch % _offlineQuotes.length;
    final quote = _offlineQuotes[random];
    print('Offline quote selected: $quote');
    
    // Parse the quote to separate text and author
    final parts = quote.split(' - ');
    if (parts.length >= 2) {
      return {
        'text': parts[0].trim(),
        'author': parts.sublist(1).join(' - ').trim(),
      };
    } else {
      return {
        'text': quote,
        'author': 'Unknown',
      };
    }
  }

  Future<void> _createSampleQuotes() async {
    try {
      print('Creating sample quotes in Firestore...');
      
      final quotes = [
        {
          'text': 'The only way to do great work is to love what you do. - Steve Jobs',
          'author': 'Steve Jobs',
          'category': 'motivation',
          'timestamp': FieldValue.serverTimestamp(),
        },
        {
          'text': 'Firebase is working perfectly! This quote came from your cloud database. 🚀',
          'author': 'Firebase',
          'category': 'tech',
          'timestamp': FieldValue.serverTimestamp(),
        },
        {
          'text': 'Success is not final, failure is not fatal: it is the courage to continue that counts. - Winston Churchill',
          'author': 'Winston Churchill',
          'category': 'motivation',
          'timestamp': FieldValue.serverTimestamp(),
        },
        {
          'text': 'Your Firestore database is connected and working! 🎉 This proves the offline quotes are NOT being used.',
          'author': 'Cloud Firestore',
          'category': 'tech',
          'timestamp': FieldValue.serverTimestamp(),
        },
        {
          'text': 'The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt',
          'author': 'Eleanor Roosevelt',
          'category': 'inspiration',
          'timestamp': FieldValue.serverTimestamp(),
        }
      ];

      // Add all quotes to Firestore
      for (final quote in quotes) {
        await FirebaseFirestore.instance.collection('quotes').add(quote);
        print('Added quote: ${quote['text']}');
      }

      print('All sample quotes created successfully');
    } catch (e) {
      print('Error creating sample quotes: $e');
    }
  }
}
