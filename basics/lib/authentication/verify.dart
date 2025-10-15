import 'package:basics/authentication/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code="";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/pet_otp.avif',
              ),
                
              const SizedBox(
                height: 25,
              ),

              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Register with Furniwas to Get Started",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code=value;
                },
              ),
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);
                        // Sign the user in (or link) with the credential
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                        
                        // Get arguments passed from phone.dart
                        final args = ModalRoute.of(context)!.settings.arguments as Map?;
                        final name = args?['name'] ?? 'User';
                        final phone = args?['phone'] ?? '';
                        
                        print("📝 Attempting to save user data:");
                        print("   Name: $name");
                        print("   Phone: $phone");
                        print("   UID: ${userCredential.user!.uid}");
                        
                        // Save user data to Firestore
                        final userId = userCredential.user!.uid;
                        final firestore = FirebaseFirestore.instance;
                        
                        final userData = {
                          'name': name,
                          'phone': phone,
                          'uid': userId,
                          'email': userCredential.user?.email ?? '',
                          'createdAt': FieldValue.serverTimestamp(),
                          'updatedAt': FieldValue.serverTimestamp(),
                          'authMethod': 'phone',
                        };
                        
                        try {
                          await firestore
                              .collection('users')
                              .doc(userId)
                              .set(userData, SetOptions(merge: true))
                              .timeout(const Duration(seconds: 10));
                          
                          print("✓ User data saved to Firestore: $userId");
                          print("✓ Fields saved: ${userData.keys.join(', ')}");
                        } catch (dbError) {
                          print("❌ Firestore Error: $dbError");
                          print("⚠️ This might be a security rule issue");
                          print("⚠️ Make sure rules allow authenticated users to write");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('⚠️ Database error: $dbError\n\nCheck Firebase Rules if data not saved'),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        }
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✓ Registration successful! Welcome!'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pushReplacementNamed(context, "navigation");
                        });
                      } catch (e) {
                        print("❌ Auth Error: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Wrong OTP! Please check properly."),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text("Confirm OTP")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'phone');
                      },
                      child: const Text(
                        "Edit Phone Number?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}