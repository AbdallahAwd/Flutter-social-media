import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/massegeModel.dart';
import 'package:learning/models/usermodel.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';
import 'package:learning/shared/compnents/constants.dart';

class ChatScreen extends StatelessWidget {
  SocialUserModel model;

  ChatScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          SocialCubit.get(context).getMessages(receiverId: model.uId);
          return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var messageController = TextEditingController();
              return Scaffold(
                appBar: AppBar(
                  title: Row(
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
                  leading: SizedBox(width: 0,),
                ),
                body: ConditionalBuilder(
                  condition: SocialCubit
                      .get(context)
                      .messages
                      .length > 0,
                  builder: (context) =>
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context , index)
                                  {
                                    var message = SocialCubit.get(context).messages[index];
                                    if(SocialCubit.get(context).userModel.uId == message.senderId)
                                      return buildSenderMessage(message);
                                    return buildReceiverMessage(message);
                                  },
                                  separatorBuilder: (context , index)=> SizedBox(height: 15,),
                                  itemCount: SocialCubit
                                      .get(context)
                                      .messages
                                      .length ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 0.1
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: ' Write something..'
                                      ),
                                    ),
                                  ),
                                  IconButton(onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: model.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                  },
                                      icon: Icon(
                                        Icons.send, color: defaultHexColor,)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  fallback: (context) =>
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context , index)
                                  {
                                    var message = SocialCubit.get(context).messages[index];
                                    if(SocialCubit.get(context).userModel.uId == message.senderId)
                                      return buildSenderMessage(message);
                                    return buildReceiverMessage(message);
                                  },
                                  separatorBuilder: (context , index)=> SizedBox(height: 15,),
                                  itemCount: SocialCubit
                                      .get(context)
                                      .messages
                                      .length ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 0.1
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: ' Write something..'
                                      ),
                                    ),
                                  ),
                                  IconButton(onPressed: () {
                                    SocialCubit.get(context).uploadChatImage();
                                  },
                                      icon: Icon(
                                        Icons.image, color: defaultHexColor,)),
                                  SizedBox(width: 5,),
                                  IconButton(onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: model.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                  },
                                      icon: Icon(
                                        Icons.send, color: defaultHexColor,)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
              );
            },
          );
        }
    );
  }
}

Widget buildReceiverMessage(MessageModel messageModel) =>
    Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(messageModel.text),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            )
        ),
      ),
    );

Widget buildSenderMessage(MessageModel messageModel) =>
    Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(messageModel.text),
        decoration: BoxDecoration(
            color: defaultHexColor.withOpacity(0.5),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
            )
        ),
      ),
    );