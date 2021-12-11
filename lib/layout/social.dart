import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/modules/Past/post_screen.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/compnents/constants.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text('NewField',style: Theme.of(context).textTheme.bodyText1,),
            actions: [
              IconButton(onPressed: ()
              {
              }, icon: Icon(Icons.notifications))
            ],
          ),
          body: SocialCubit.get(context).screens[SocialCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavyBar(

            animationDuration: Duration(milliseconds: 350),
                selectedIndex: SocialCubit.get(context).currentIndex,
                onItemSelected: (index)
                {
                  SocialCubit.get(context).changeNav(index);
                },
                items: [
                  BottomNavyBarItem(
                    title: Text(' Home' , style: Theme.of(context).textTheme.caption,),
                    icon: Icon(Icons.home),
                    activeColor: defaultHexColor,
                    inactiveColor: Colors.grey,

                  ),
                  BottomNavyBarItem(
                    title: Text(' Users' , style: Theme.of(context).textTheme.caption,),
                    icon: Icon(Icons.location_on_outlined),
                    activeColor: Colors.orangeAccent,
                    inactiveColor: Colors.grey,
                  ),
                  BottomNavyBarItem(
                    title: Text(' Chats' , style:Theme.of(context).textTheme.caption),
                    icon: Icon(Icons.chat_outlined),
                    activeColor: defaultHexColor,
                    inactiveColor: Colors.grey,
                  ),
                  BottomNavyBarItem(
                    title: Text(' Profile' , style: Theme.of(context).textTheme.caption,),
                    icon: Icon(Icons.person_pin_circle_outlined),
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                ],
          ),
          floatingActionButton: FloatingActionButton(
            splashColor: defaultHexColor,
            backgroundColor: defaultHexColor,
            child: Icon(Icons.post_add),
            onPressed: ()
            {
              navigateTo(context, PostScreen());
            },
          ),

        );
      },
    );
  }
}
