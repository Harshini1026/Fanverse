import 'dart:ui';
import 'package:fan_verse/features/auth/login_screen.dart';
import 'package:fan_verse/features/home/presentation/screens/home_screen.dart';
import 'package:fan_verse/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String name="",email="",password="",confirmpassword="";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller =TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();
  TextEditingController confirmpasswordcontroller =TextEditingController();

  bool _isObscure = true; 
  bool _isConfirmObscure = true;

  final _formkey = GlobalKey<FormState>();

 Future<void> registration() async{
    if(passwordcontroller.text!=""&&namecontroller.text!=""&& emailcontroller.text!=""&& passwordcontroller.text==confirmpasswordcontroller.text){
      try{
        await FirebaseAuth.instance
         .createUserWithEmailAndPassword(email: email, password: password);
         if(!mounted)return;
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:Center(
            child: const Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20),
            ),
          )
         ));
         Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }on FirebaseAuthException catch(e){
         if(!mounted)return;
        if (e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: const Color.fromARGB(255, 4, 228, 244),
            content:Center(
              child: const Text("Password is too weak",
              style: TextStyle(fontSize: 18),
              ),
            )));
        } else if (e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: const Color.fromARGB(255, 4, 228, 244),
            content: Center(
              child: Text(" Account Already exists",
              style: TextStyle(fontSize: 18),
              ),
            )));
        }else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(child: Text(e.message ?? "Authentication failed")),
        ));
      }
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
                            padding: const EdgeInsets.only(top: 70),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                                Text("FANVERSE",
                                style: GoogleFonts.orbitron( 
                                color: Color(0xFF00E5FF),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                ),
                             ),
                               SizedBox(height: 10,),
                             Text("Sign Up",
                                    style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: 22,fontWeight: FontWeight.bold,),
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
                                      return 'Please Enter Name';
                                    }
                                    return null;
                                  },
                                  controller: namecontroller,
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                    decoration: InputDecoration(  
                                      prefixIcon: Icon(Icons.person,color: Colors.white,),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: InputBorder.none,
                                      hintText: "Enter your name...",
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
                                      hintText: "Enter your mail...",
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
                                        icon:Icon(
                                          _isObscure?Icons.visibility_off:Icons.visibility,
                                        color: Colors.white,),
                                        onPressed:() {
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
                                      return 'Confirm Password cannot be empty';
                                    }
                                    if(value!=passwordcontroller.text){
                                      return "Password don't match";
                                    }
                                    return null;
                                  },
                                    controller: confirmpasswordcontroller,
                                     obscureText:_isConfirmObscure,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock,color: Colors.white,),
                                      suffixIcon: IconButton (
                                      icon:Icon(
                                        _isConfirmObscure?Icons.visibility_off:Icons.visibility,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                        _isConfirmObscure=!_isConfirmObscure;
                                        });
                                      },
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: InputBorder.none,
                                      hintText: "Confirm password...",
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
                                    name=namecontroller.text;
                                    password=passwordcontroller.text;
                                    confirmpassword=confirmpasswordcontroller.text;
                                  });
                                  registration();
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
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.70))
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
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
                              "Already have an account?",
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
                                    builder: (context)=>LoginScreen()));
                               },
                               child: Text("Login",
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