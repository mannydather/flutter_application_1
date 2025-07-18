import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();
  bool _isLoading = false;
  bool _codeSent = false;
  String _errorMessage = '';
  String _verificationId = '';

  Future<void> _sendSMSCode() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification on Android
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _errorMessage = e.message ?? 'Phone verification failed';
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _codeSent = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyCode() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsCodeController.text.trim(),
      );
      
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Code verification failed';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_codeSent ? 'Verify Phone' : 'Phone Login (+44 7444 555666)'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.phone,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 32),
            if (!_codeSent) ...[
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',

                  hintText: '+44 7444 555666',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
            ] else ...[
              Text(
                'SMS code sent to ${_phoneController.text}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _smsCodeController,
                decoration: const InputDecoration(
                  labelText: 'SMS Code',
                  hintText: '123456',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.sms),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
            ],
            const SizedBox(height: 24),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Column(
                children: [
                  if (!_codeSent) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _sendSMSCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Send SMS Code'),
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _verifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Verify Code'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _codeSent = false;
                            _smsCodeController.clear();
                            _errorMessage = '';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.deepPurple),
                        ),
                        child: const Text('Use Different Number'),
                      ),
                    ),
                  ],
                ],
              ),
            const SizedBox(height: 32),
            SelectableText(
              'USE FOR DEMO: +44 7444 555666',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            SelectableText(
              'USE FOR DEMO (SMS): 123456',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _smsCodeController.dispose();
    super.dispose();
  }
}
