import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/usermodel.dart';
import 'package:learning/modules/profileView/users_profile.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';
import 'package:learning/shared/compnents/component.dart';


class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          SocialUserModel userModel;
          return ListView.separated(
              itemBuilder: (context , index) => buildUser(context , SocialCubit.get(context).users[index]),
              separatorBuilder: (context , index) => Column(
                children: [
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey,height: 1,indent: 20,),
                  SizedBox(height: 10,),
                ],
              ),
              itemCount: SocialCubit.get(context).users.length
          );
        },
        listener: (context, state) {}
    );
  }
}

Widget buildUser(context ,  SocialUserModel model) =>
    InkWell(
      onTap: ()
      {
        navigateTo(context, UsersProfile(model));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      '${model.image}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );