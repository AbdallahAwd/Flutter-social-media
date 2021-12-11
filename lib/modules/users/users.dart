import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/usermodel.dart';
import 'package:learning/modules/chat_detels_screen/chatScreen.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';
import 'package:learning/shared/compnents/component.dart';

class UsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context , index)=>buildUserItems(context , SocialCubit.get(context).users[index]),
            separatorBuilder: (context , index)=> Column(
              children: [
                SizedBox(height: 10,),
                Divider(color: Colors.grey,height: 1,indent: 20,),
                SizedBox(height: 10,),
              ],
            ),
            itemCount: SocialCubit.get(context).users.length
        );
      },
    );
  }
}

Widget buildUserItems(context , SocialUserModel model) =>
    InkWell(
      onTap: ()
      {
        navigateTo(context, ChatScreen(model));

      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  '${model.image}'),
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Text(
                  '${model.name}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 14),
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
      ),
    );