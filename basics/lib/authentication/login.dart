import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isLogin = true; // Toggle between login and signup
  String errorMessage = '';

  Future<void> handleAuth() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Create email from username (using valid domain)
      String email = '${usernameController.text.toLowerCase()}@pethubapp.com';
      String password = passwordController.text;
      String username = usernameController.text;

      // Validation
      if (username.isEmpty || username.length < 3) {
        throw Exception('Username must be at least 3 characters');
      }
      if (password.isEmpty || password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      if (isLogin) {
        // LOGIN
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("✓ Login successful: $username");
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✓ Login successful!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushReplacementNamed(context, 'navigation');
        }
      } else {
        // SIGNUP
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Save user data to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': username,
          'email': email,
          'uid': userCredential.user!.uid,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'authMethod': 'email',
        });

        print("✓ Account created: $username");
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✓ Account created successfully! Logging in...'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, 'navigation');
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Error: ${e.code}';
      if (e.code == 'user-not-found') {
        message = 'Username not found. Create an account!';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password!';
      } else if (e.code == 'email-already-in-use') {
        message = 'Username already taken!';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak (min 6 chars)!';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid username format!';
      } else if (e.code == 'operation-not-allowed') {
        message = 'This operation is not allowed. Contact support!';
      } else if (e.code == 'network-request-failed') {
        message = 'Network error. Check your connection!';
      }
      setState(() {
        errorMessage = message;
      });
      print("Firebase Auth Error: ${e.code} - ${e.message}");
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
      print("Error: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade300, Colors.amber.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Image
                Image.asset(
                  'assets/petslogin.jpeg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 30),

                // Title
                Text(
                  isLogin ? 'Welcome Back!' : 'Create Account',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isLogin ? 'Login to your account' : 'Sign up for new account',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),

                // Username Field
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username (min 3 chars)',
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password (min 6 chars)',
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Error Message
                if (errorMessage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      border: Border.all(color: Colors.red.shade600),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '❌ $errorMessage',
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),

                // Login/Signup Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: isLoading ? null : handleAuth,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            isLogin ? 'LOGIN' : 'CREATE ACCOUNT',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // Toggle Login/Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? "Don't have account? " : 'Already have account? ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLogin = !isLogin;
                          errorMessage = '';
                          usernameController.clear();
                          passwordController.clear();
                        });
                      },
                      child: Text(
                        isLogin ? 'SIGN UP' : 'LOGIN',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
