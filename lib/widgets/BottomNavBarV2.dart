

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Mybottom extends StatelessWidget {
  // const Mybottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,




        items: [



          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.purple),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list,color: Colors.purple),
            label: 'Listining',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera,color: Colors.purple),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon:  SvgPicture.asset('assets/icons/project.svg',height: 20,color: Colors.purple,),label: "projects",),


          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/more.svg',height: 20,color: Colors.purple,),label: "more",



            ),


        ]
    );
  }
}
