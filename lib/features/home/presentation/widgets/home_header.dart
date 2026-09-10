import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [IconButton(onPressed: () {}, icon: Icon(Icons.menu),),
      Spacer(),
       Text(
             "FANVERSE",
               style: GoogleFonts.orbitron(
                color: Color(0xFF00E5FF),
                fontSize: 18,
                 fontWeight: FontWeight.bold,
               ),
            ),
           Spacer(),
          IconButton(onPressed: (){},
           icon: Icon(Icons.trolley),),
      ],
    );
  }
}
