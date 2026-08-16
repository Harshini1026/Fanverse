import 'dart:ui';
import 'package:fan_verse/features/screens/auth/forgot_password.dart';
import 'package:fan_verse/features/screens/home/home_screen.dart';
import 'package:fan_verse/features/screens/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fan_verse/service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email="",password="";
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

   bool _isObscure = true; 
  
  final _formkey=GlobalKey<FormState>();

  Future<void>userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(!mounted)return;
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:Center(
            child: const Text(
              "Login Successfully",
              style: TextStyle(fontSize: 20),
            ),
          )
         ));
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
    } on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 4, 228, 244),
          content: Center(
            child: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ));
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:const Color.fromARGB(255, 4, 228, 244) ,
          content: Center(
            child: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18),
            ),
          ),));
      }else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(child: Text(e.message ?? "Authentication failed")),
        ));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ 
          Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://i.pinimg.com/736x/53/6e/5b/536e5b077bdf962642920167304e60ee.jpg"),
            fit:BoxFit.cover,
            ),
          ),
          ),
         Positioned.fill(
          child:BackdropFilter(filter: ImageFilter.blur(sigmaX: 0.5,sigmaY: 0.5),
          child: Container(
            color: Colors.black87.withValues(alpha: 0.50),
          ),
          ), 
         ),
                    Align(
                      alignment: AlignmentGeometry.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 135),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text("Welcome To...",
                                    style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold,),
                                    ),
                                    SizedBox(height: 10,),
                                Text("FANVERSE",
                                style: GoogleFonts.orbitron( 
                                color: Color(0xFF00E5FF),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                ),
                             ),
                            ],
                            ),
                          ),
                        ),
                    
             Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(left: 20,right: 20),
                    child: Form(
                      key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.50))
                                ),
                                child: TextFormField(
                                  cursorColor: const Color.fromARGB(255, 4, 228, 244),
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
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                    decoration: InputDecoration(  
                                      prefixIcon: Icon(Icons.email,color: Colors.white,),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: InputBorder.none,
                                      hintText: "Enter your email here...",
                                      contentPadding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                                      hintStyle: TextStyle(
                                        color: Colors.white,fontSize: 18,
                                      ),
                                      ),
                                      ),
                                      ),
                                    ),
                              ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.50))
                                  ),
                                  child: TextFormField(
                                    cursorColor: const Color.fromARGB(255, 4, 228, 244),
                                     validator: (value) {
                                    if(value==null||value.isEmpty){
                                      return 'Password cannot be empty';
                                    }
                                    if(value.length<6){
                                      return "Password must be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                    controller: passwordcontroller,
                                      obscureText: _isObscure,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock,color: Colors.white,),
                                      suffixIcon: IconButton(
                                      icon: Icon(
                                       _isObscure?Icons.visibility_off:Icons.visibility,
                                      color: Colors.white,),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure=!_isObscure;
                                        });
                                      },
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: InputBorder.none,
                                      hintText: "Your password...",
                                      contentPadding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                                      hintStyle: TextStyle(
                                        color: Colors.white,fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 15.0),
                            child: GestureDetector(
                              onTap: (){
                                if(_formkey.currentState!.validate()){
                                  setState(() {
                                    email=emailcontroller.text;
                                    password=passwordcontroller.text;
                                  });
                                  userLogin();
                                }
                              },
                              child: Container(
                                width: MediaQuery.of( context).size.width,
                                padding: EdgeInsets.symmetric(
                                  vertical: 13.0,horizontal: 30.0 ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors:[
                                      Colors.black,
                                      const Color.fromARGB(255, 44, 51, 127),
                                      Colors.white,
                                      Colors.white,
                                      const Color.fromARGB(255, 44, 51, 127),
                                      Colors.black,
                                    ]),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.30))
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                            },
                            child: Text("Forget Password?",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 4, 228, 244),
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                            ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: Colors.grey.shade600,
                                  thickness: 1,
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "or continue with",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: Colors.grey.shade600,
                                  thickness: 1,
                                ),
                              )),
                            ],
                          ),
                          SizedBox(height: 25,),
                         GestureDetector(
                           onTap: () async {
                             await AuthServiceMethods().signInWithGoogle(context);
                           },
                           child: Image.network(
                             "https://cdn-icons-png.magnific.com/512/720/720255.png",
                             height: 45,
                             width: 45,
                           ),
                         ),
                       SizedBox(height: 25),
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
                             SizedBox(width: 5.0,),
                             GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context, MaterialPageRoute(
                                    builder: (context)=>SignupScreen()));
                              },
                               child: Text("SignUp",
                               style: TextStyle(
                               color: const Color.fromARGB(255, 4, 228, 244),
                                fontSize: 21.0,
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
              ),
        ],
      ),
    );
  }
}