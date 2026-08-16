import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final random=Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         Expanded(
           child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              //full bg
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              ...List.generate(65,(index){
               return Positioned(
                top: random.nextDouble()*800,
                left:random.nextDouble()*400 ,
                child: Icon(
                  Icons.star,
                  color: Colors.white24,
                  size: random.nextDouble()*8,
                ),
               );
              },),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(40),
                             child: Container(
                              height: 250,
                              width: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/Fanverse_logo.png"),
                                  fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                           ),
                   SizedBox(height: 5),
                   Text("FANVERSE",
                   style: GoogleFonts.orbitron( 
                    color: Color(0xFF00E5FF),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                   ),
                   ),
                   Text("WHERE EVERY FANS BELONGS",
                   style: GoogleFonts.poppins( 
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                   ),
                   ),
                   SizedBox(height: 30,),
                  CircularProgressIndicator(),
                      ],
                    ),
                  ),
                 ],  
                ),
              ),
       ],
     ),
    );
  }
}