import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/usermodel.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';

class UsersProfile extends StatelessWidget {
  SocialUserModel model;
  UsersProfile(this.model);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
     listener: (context , state) {},
     builder: (context , state)
     {
       return Scaffold(
         body: SafeArea(
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: Column(
               children: [
                 Container(
                   height: 219,
                   child: Stack(
                     children: [
                       Container(
                         width: double.infinity,
                         height: 175,
                         child: Image(
                           image: NetworkImage('${model.cover}'),
                           fit: BoxFit.cover,
                         ),
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10)
                         ),
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                       ),
                       Positioned(
                         bottom: -2,
                         left: 140,
                         child: CircleAvatar(
                           radius: 52,
                           backgroundColor: Colors.white,
                           child: CircleAvatar(
                             radius: 50,
                             backgroundImage: NetworkImage(
                                 '${model.image}'),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 Text(
                   '${model.name}',
                   style: Theme.of(context).textTheme.bodyText1,
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 Text(
                   '${model.bio}',
                   style: Theme.of(context).textTheme.caption,
                 ),
                 SizedBox(
                   height: 40,
                 ),
                 Row(
                   children: [
                     Expanded(
                       child: InkWell(
                         onTap: () {},
                         child: Column(
                           children: [
                             Text(
                               '100',
                               style: Theme.of(context).textTheme.bodyText1,
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Text(
                               'Posts',
                               style: Theme.of(context).textTheme.bodyText2,
                             ),
                           ],
                         ),
                       ),
                     ),
                     Expanded(
                       child: InkWell(
                         onTap: () {},
                         child: Column(
                           children: [
                             Text(
                               '90K',
                               style: Theme.of(context).textTheme.bodyText1,
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Text(
                               'Follower',
                               style: Theme.of(context).textTheme.bodyText2,
                             ),
                           ],
                         ),
                       ),
                     ),
                     Expanded(
                       child: InkWell(
                         onTap: () {},
                         child: Column(
                           children: [
                             Text(
                               '165',
                               style: Theme.of(context).textTheme.bodyText1,
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Text(
                               'Photos',
                               style: Theme.of(context).textTheme.bodyText2,
                             ),
                           ],
                         ),
                       ),
                     ),

                     Expanded(
                       child: InkWell(
                         onTap: () {},
                         child: Column(
                           children: [
                             Text(
                               '105',
                               style: Theme.of(context).textTheme.bodyText1,
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Text(
                               'Following',
                               style: Theme.of(context).textTheme.bodyText2,
                             ),
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 Row(
                   children: [
                     Expanded(
                       child: OutlinedButton(
                         onPressed: () {


                         },
                         child: Text('Follow '),
                       ),
                     ),
                     SizedBox(
                       width: 10,
                     ),

                   ],
                 )
               ],
             ),
           ),
         ),
       );
     },
    );
  }
}
