import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await addQuotesToFirebase();
  print('All quotes added successfully!');
}

Future<void> addQuotesToFirebase() async {
  final firestore = FirebaseFirestore.instance;
  
  final quotes = [
    {
      'text': 'The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt',
      'author': 'Eleanor Roosevelt',
      'category': 'inspiration',
      'timestamp': FieldValue.serverTimestamp(),
    },
    {
      'text': 'It is during our darkest moments that we must focus to see the light. - Aristotle',
      'author': 'Aristotle',
      'category': 'wisdom',
      'timestamp': FieldValue.serverTimestamp(),
    },
    {
      'text': 'Success is not final, failure is not fatal: it is the courage to continue that counts. - Winston Churchill',
      'author': 'Winston Churchill',
      'category': 'motivation',
      'timestamp': FieldValue.serverTimestamp(),
    },
    {
      'text': 'The way to get started is to quit talking and begin doing. - Walt Disney',
      'author': 'Walt Disney',
      'category': 'motivation',
      'timestamp': FieldValue.serverTimestamp(),
    },
    {
      'text': 'Your limitation—it\'s only your imagination.',
      'author': 'Unknown',
      'category': 'inspiration',
      'timestamp': FieldValue.serverTimestamp(),
    },
    {
      'text': 'Great things never come from comfort zones.',
      'author': 'Unknown',
      'category': 'motivation',
      'timestamp': FieldValue.serverTimestamp(),
    },
    {
      'text': 'Dream it. Wish it. Do it.',
      'author': 'Unknown',
      'category': 'inspiration',
      'timestamp': FieldValue.serverTimestamp(),
    },
    {
      'text': 'Don\'t stop when you\'re tired. Stop when you\'re done.',
      'author': 'Unknown',
      'category': 'motivation',
      'timestamp': FieldValue.serverTimestamp(),
    },
    {
      'text': 'Wake up with determination. Go to bed with satisfaction.',
      'author': 'Unknown',
      'category': 'life',
      'timestamp': FieldValue.serverTimestamp(),
    },
  ];

  for (int i = 0; i < quotes.length; i++) {
    try {
      await firestore.collection('quotes').add(quotes[i]);
      print('Added quote ${i + 1}: ${quotes[i]['text']}');
    } catch (e) {
      print('Error adding quote ${i + 1}: $e');
    }
  }
}
