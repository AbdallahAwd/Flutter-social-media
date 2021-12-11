import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/post_model.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';


class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var commentController = TextEditingController();
        return Scaffold(

          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
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
                                  backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}'),
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
                                          '${SocialCubit.get(context).userModel.name}',
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
                              '{model.text}',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            //    if(model.postPhoto != '')
                            Image(
                              image: NetworkImage('https://www.kindacode.com/wp-content/uploads/2020/11/Screen-Shot-2020-11-11-at-01.20.25.jpg'),
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
                                        '000',
                                        style: Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  width: width - 200,
                                ),
                                InkWell(
                                  onTap: () {},
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

                                SizedBox(
                                  width: 10,
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
                                        SocialCubit.get(context).postId[0]);
                                  },
                                ),
                                SizedBox(width: 30,),
                                InkWell(
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
                                        'comment',
                                        style: Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    commentController.selection;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[100],
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Wrap(
                              children: [
                                CircleAvatar(radius: 20,backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}'),),
                              ],
                            ),
                            suffixIcon: IconButton(icon:Icon(Icons.send) ,onPressed: ()
                            {
                              SocialCubit.get(context).setComment(0, Controller: commentController.text);
                            },),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context , index) =>commentDesign(context),
                      separatorBuilder: (context , index) => Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                      itemCount: 1
                  ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
Widget commentDesign(context)
=>  Row(
  children: [
    CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(
          '${SocialCubit.get(context).userModel.image}'),
    ),
    SizedBox(
      width: 10,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${SocialCubit.get(context).userModel.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 12),
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
          Text('pla' , style: TextStyle(color: Colors.black),)
        ],
      ),
    ),
  ],
);