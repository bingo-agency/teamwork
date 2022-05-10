import 'package:flutter/material.dart';
import 'package:team_work/widgets/BottomNavBarV2.dart';
import 'package:team_work/widgets/Drawer.dart';
import 'package:team_work/widgets/best_offer.dart';
import 'package:team_work/widgets/categories.dart';
import 'package:team_work/widgets/custom_app_bar.dart';
import 'package:team_work/widgets/custom_bottom_navigation_bar.dart';
import 'package:team_work/widgets/recommended_house.dart';
import 'package:team_work/widgets/search_input.dart';
import 'package:team_work/widgets/welcome_text.dart';
import 'package:flutter_svg/svg.dart';



class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      // appBar: CustomAppBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:  new IconButton(icon: SvgPicture.asset('assets/icons/menu.svg',color: Colors.purple,),onPressed: ()=> _scaffoldKey.currentState!.openDrawer(),),

        actions: [
          Icon(Icons.account_circle_rounded,size: 40,color: Colors.purple,)
        ],
      ),
      drawer: Mydrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeText(),
            SearchInput(),
            Categories(),
            RecommendedHouse(

            ),
            BestOffer()
          ],
        ),
      ),
      bottomNavigationBar: Mybottom(),
    );
  }
}
