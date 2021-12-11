import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:learning/models/post_model.dart';
import 'package:learning/modules/comments/comments.dart';
import 'package:learning/modules/setting/profile.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';
import 'package:learning/shared/compnents/component.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(
                      image: AssetImage('assets/cofe.jpg'),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PastBuilder(context, width,
                        SocialCubit.get(context).posts[index], index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: SocialCubit.get(context).posts.length),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget PastBuilder(context, width, PostModel model, index) => Column(
  children: [
    Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
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
                          style: Theme.of(context)
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
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              height: 6,
            ),

            Divider(
              height: 1,
              endIndent: 10,
              indent: 5,
            ),

            SizedBox(
              height: 9,
            ),

            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.bodyText2,
            ),

            SizedBox(
              height: 5,
            ),

            // Text(

            //   '#software #software #software #software #software #software #software #software ',

            //   style: TextStyle(

            //     fontSize: 15,

            //     color: Colors.blue,

            //     height: 1.5,

            //   ),

            //   textAlign: TextAlign.start,

            // ),

            // SizedBox(

            //   height: 10,

            // ),

            if (model.postPhoto != '')
              Image(
                image: NetworkImage('${model.postPhoto}'),
                fit: BoxFit.cover,
                width: double.infinity,
              ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_outline_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(
                        height: 3,
                        width: 5,
                      ),
                      Text(
                        '${SocialCubit.get(context).likesNum[index]}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  width: width - 115,
                ),
                InkWell(
                  onTap: ()
                  {

                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(
                        height: 3,
                        width: 5,
                      ),
                      Text(
                        '0',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 5,
            ),

            Divider(
              height: 1,
            ),

            SizedBox(
              height: 5,
            ),

            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      '${SocialCubit.get(context).userModel.image}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, CommentScreen());
                    },
                    child: Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'write a comment...',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_outline_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(
                        height: 3,
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context).postLikes(
                        SocialCubit.get(context).postId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ],
);
