import 'package:flutter/material.dart';

class NavigationService {
  static void navigateToPage(BuildContext context, String pageName, String title) {
    Navigator.pop(context); // Close the drawer first
    
    Widget? targetPage;
    switch (pageName) {
      case 'home':
        // Dynamic import to avoid circular dependencies
        targetPage = _createPage('MyHomePage', title);
        break;
      case 'page2':
        targetPage = _createPage('MySecondPage', title);
        break;
      case 'page3':
        targetPage = _createPage('MyThirdPage', title);
        break;
      case 'page4':
        targetPage = _createPage('MyFourthPage', title);
        break;
      case 'page5':
        targetPage = _createPage('MyFifthPage', title);
        break;
    }
    
    if (targetPage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => targetPage!),
      );
    }
  }
  
  static Widget? _createPage(String className, String title) {
    // This is a simplified approach - in a real app you might use 
    // dependency injection or a routing system
    try {
      switch (className) {
        case 'MyHomePage':
          // We'll need to import this dynamically
          return null; // Will be handled by each page individually
        case 'MySecondPage':
          return null; // Will be handled by each page individually
        case 'MyThirdPage':
          return null; // Will be handled by each page individually
        case 'MyFourthPage':
          return null; // Will be handled by each page individually
        case 'MyFifthPage':
          return null; // Will be handled by each page individually
        default:
          return null;
      }
    } catch (e) {
      print('Error creating page $className: $e');
      return null;
    }
  }
}
