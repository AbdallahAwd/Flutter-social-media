import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';

class PostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
        listener: (context , state){},
        builder: (context , state)
        {
          var userData = SocialCubit.get(context).userModel;
          var postImage = SocialCubit.get(context).postImage;
          return Scaffold(
            appBar: AppBar(
              title: Text('Create Post' , style: Theme.of(context).textTheme.bodyText1,),
              actions: [
                TextButton(onPressed: ()
                {
                  if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createPost(text: textController.text,);

                        Navigator.pop(context);
                    }
                  else
                    {
                      SocialCubit.get(context).uploadPostImage(text: textController.text  );
                        Navigator.pop(context);
                    }
                }, child: Text('POST')),
                SizedBox(width: 10,)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is CreatePostLoadingState || state is CoverUploadLoadingState)
                        LinearProgressIndicator(),
                    if(state is CreatePostLoadingState|| state is CoverUploadLoadingState)
                        SizedBox(height: 10,),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${userData.image}'),
                          radius: 25,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${userData.name}' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),),
                            Text('Public' , style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ],
                    ),
                      TextFormField(
                      controller: textController,
                      keyboardType: TextInputType.text,
                      maxLength: 200,
                      maxLines: postImage != null ? 15 : 30,
                      decoration: InputDecoration(
                        hintText: 'What is on Your mind ?',
                        border: InputBorder.none,
                      ),
                    ),
                      if(postImage != null)
                      SizedBox(height: 15,),
                      if(postImage != null)
                      Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 175,
                          child: Image(
                            image: FileImage(postImage),
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                        ),
                        InkWell(
                          onTap: () {
                            SocialCubit.get(context).cancelImage();
                          },
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                            height: 175,
                            width: double.infinity,
                            child: Icon(
                              Icons.close_outlined,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
            bottomNavigationBar:  Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: ()
                {
                  SocialCubit.get(context).getPostImage();
                }, child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 10,),
                    Text('Add Photos'),
                  ],
                ) ,)),
                SizedBox(width: 10,),
                Expanded(child: OutlinedButton(onPressed: (){}, child: Text('# tags'))),
              ],
            ),
          );
        },
      );

  }
}
