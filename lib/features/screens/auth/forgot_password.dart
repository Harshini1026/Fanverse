
import 'package:fan_verse/features/screens/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email="";
  TextEditingController emailcontroller=TextEditingController();

  final _formkey=GlobalKey<FormState>();

  Future<void> resetpassword() async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailcontroller.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Password reset email has been sent!",
        ),
      ),
    );
  } on FirebaseAuthException catch (e) {
    if (!mounted) return;

    print("Firebase Error Code: ${e.code}");
    print("Firebase Error Message: ${e.message}");

    String message;

    if (e.code == 'user-not-found') {
      message = "No user found for that email.";
    } else if (e.code == 'invalid-email') {
      message = "Invalid email address.";
    } else if (e.code == 'too-many-requests') {
      message = "Too many requests. Please try again later.";
    } else if (e.code == 'operation-not-allowed') {
      message = "Email/Password authentication is not enabled.";
    } else {
      message = e.message ?? "Something went wrong.";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  } catch (e) {
    print("Error: $e");

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Something went wrong."),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 100,),
          Container(
            alignment: AlignmentDirectional.topCenter,
            child: Text(
              "Password Recovery",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter your mail",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 40,),
            Expanded(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          border:
                           Border.all(color: Colors.white70,width: 2),
                           borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                           validator: (value) {
                              if(value==null||value.isEmpty){
                                return 'Please Enter Email';
                                  }
                                  if(!value.contains("@")){
                                    return "Invalid email";
                                  }
                                  return null;
                                  },
                          controller: emailcontroller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontSize: 18,color: Colors.white),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.white,
                              size: 30,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 35,),
                      GestureDetector(
                        onTap: (){
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              email=emailcontroller.text;
                            });
                            resetpassword();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                         child: Center(
                          child: Text(
                            "Send Email",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                         ),
                        ),
                      ),
                      SizedBox(height: 40),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                              ),
                             SizedBox(width: 10,),
                             GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,MaterialPageRoute(builder: (context)=>SignupScreen()));
                              },
                               child: Text("SignUp",
                               style: TextStyle(
                               color: const Color.fromARGB(255, 4, 228, 244),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }
}