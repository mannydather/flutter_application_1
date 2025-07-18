# Firebase Phone Authentication + Firestore Setup

This Flutter app has been configured with Firebase Phone Authentication and Firestore database for your project `flutterproject01djm`.

## What's been added:

1. **Firebase Dependencies** - Added to `pubspec.yaml`:
   - `firebase_core`: For Firebase initialization
   - `firebase_auth`: For authentication functionality
   - `cloud_firestore`: For database functionality

2. **Authentication Pages**:
   - `login_page.dart`: Phone number login/verification page
   - `auth_wrapper.dart`: Handles authentication state management

3. **Database Integration**:
   - Quote fetching from Firestore database
   - Automatic sample quote creation if none exist
   - Refresh functionality to get new quotes

4. **Firebase Configuration**:
   - `firebase_options.dart`: Generated Firebase configuration for all platforms
   - `google-services.json`: Android configuration file

5. **Updated Main App**:
   - Firebase initialization in `main.dart`
   - Authentication wrapper integration
   - Quote display with loading states
   - Sign out button and refresh quote button in app bar

## How to use:

1. **Run the app**: `flutter run -d windows` (or your preferred platform)
2. **Enter Phone Number**: Input your phone number with country code (e.g., +1234567890)
3. **Receive SMS**: Get the verification code via SMS
4. **Verify Code**: Enter the 6-digit code to sign in
5. **View Quote**: See a daily quote from your Firebase database
6. **Refresh Quote**: Click the refresh button to get a new quote
7. **Sign Out**: Click the logout button in the app bar

## Features:

- **Phone Number Authentication**: Users sign in with their phone number
- **SMS Verification**: Secure 6-digit SMS code verification
- **Real-time Database**: Quotes stored and retrieved from Firestore
- **Auto-quote Creation**: Creates sample quotes if database is empty
- **Refresh Functionality**: Users can refresh to get new quotes
- **Beautiful UI**: Styled quote display with loading indicators
- **Authentication State Management**: Automatic login/logout handling
- **Error Handling**: User-friendly error messages
- **Cross-Platform**: Works on Android, iOS, Web, and Windows

## Database Setup:

### Step 1: Enable Firestore
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project `flutterproject01djm`
3. Go to Firestore Database
4. Click "Create database"
5. Choose "Start in test mode" for development

### Step 2: Set up Quotes Collection
The app will automatically create a sample quote when you first run it. To add more quotes manually:

1. In Firebase Console, go to Firestore Database
2. Create a collection called `quotes`
3. Add documents with this structure:
   ```json
   {
     "text": "Your quote text here",
     "author": "Author Name",
     "category": "motivation",
     "timestamp": "current server timestamp"
   }
   ```

### Step 3: Sample Quotes
Check the `sample_quotes.js` file for sample quotes you can add to your database.

## Next Steps:

1. **Enable Phone Authentication in Firebase Console**:
   - Go to Authentication > Sign-in method
   - Enable "Phone" authentication
   - **Important**: Add your phone number to the test phone numbers for testing

2. **Enable Firestore Database**:
   - Go to Firestore Database
   - Create database in test mode
   - The app will automatically create sample quotes

3. **Test the App**:
   - Run the app
   - Enter a test phone number
   - Use the test verification code from Firebase Console
   - See quotes from your database
   - Test the refresh functionality

## Database Structure:

```
quotes/
├── document1/
│   ├── text: "Quote text"
│   ├── author: "Author name"
│   ├── category: "Category"
│   └── timestamp: ServerTimestamp
├── document2/
│   └── ...
```

## Production Considerations:

- **Security Rules**: Set up proper Firestore security rules
- **Indexes**: Create indexes for better query performance
- **Billing**: Monitor database usage and billing
- **Error Handling**: Implement robust error handling for network issues

Enjoy your Firebase Phone Authentication + Database Flutter app! 📱🔐📚
