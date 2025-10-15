import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countrycode = TextEditingController();
  TextEditingController nameController = TextEditingController(); // Added
  TextEditingController phoneController = TextEditingController(); // Added
  var phone = "";
  var name = ""; 

  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/petslogin.jpeg',
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
                "You need to register your phone !",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              // Container for Name
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 200, 
                      child: TextField(
                        controller: nameController,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your name", // hint text
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Container for Phone Number
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countrycode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone number",
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    // Validation
                    if (nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter your name')),
                      );
                      return;
                    }
                    if (phoneController.text.isEmpty || phoneController.text.length < 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter valid phone number (min 10 digits)')),
                      );
                      return;
                    }
                    
                    // For testing: Use test phone numbers added in Firebase Console
                    // Or use this format: +94712345678 (valid Sri Lankan number)
                    String fullPhone = '${countrycode.text}${phone}';
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('📱 Sending verification code...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    
                    try {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: fullPhone,
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          print("Verification Failed: ${e.message}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${e.message}\n\nTip: Use test numbers from Firebase Console for web testing'),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify = verificationId;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('✓ OTP sent successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pushNamed(context, 'otp', arguments: {
                            'name': nameController.text.trim(),
                            'phone': fullPhone,
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                        timeout: const Duration(seconds: 60),
                      );
                    } catch (e) {
                      print("Error: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e\n\nMake sure to add test numbers in Firebase Console'),
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    }
                  },
                  child: const Text("Send the code"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
