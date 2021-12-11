import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/Cubit/social_App/Cubit.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';
import 'package:learning/shared/compnents/component.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userData = SocialCubit.get(context).userModel;
    var profileImage = SocialCubit.get(context).profileImage;
    var CoverImage = SocialCubit.get(context).coverImage;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();
        var formKey = GlobalKey<FormState>();

        nameController.text = userData.name;
        phoneController.text = userData.phone;
        bioController.text = userData.bio;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if(profileImage != null)
                    SocialCubit.get(context).uploadProfileImage(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  if(CoverImage != null)
                    SocialCubit.get(context).uploadCoverImage(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                    SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  SocialCubit.get(context).emit(NewSocialSuccessState());
                  Navigator.pop(context);
                },
                child: Text('update'.toUpperCase()),
              ),
            ],
          ),
          body: userData != null
              ? SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
                      child: Column(

                        children: [
                          if(state is UpdateLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(height: 10,),
                            Container(
                            height: 219,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 175,
                                  child: Image(
                                    image: CoverImage == null ? NetworkImage('${userData.cover}') : FileImage(CoverImage),
                                    fit: BoxFit.cover,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                ),
                                InkWell(
                                  onTap: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  child: Container(
                                    color: Colors.black.withOpacity(0.2),
                                    height: 175,
                                    width: double.infinity,
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -2,
                                  left: 140,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 52,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: profileImage == null
                                              ? NetworkImage(
                                                  '${userData.image}')
                                              : FileImage(profileImage),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          SocialCubit.get(context)
                                              .getProfileImage();
                                        },
                                        child: CircleAvatar(
                                          radius: 51,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.2),
                                          child: Icon(
                                            Icons.add,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${userData.name}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${userData.bio}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultTextFormFeild(
                              controller: nameController,
                              pre: Icons.person_outline,
                              HintText: 'Name',
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'This Field Required';
                                }
                                return null;
                              },
                              KeyType: TextInputType.name),
                          SizedBox(
                            height: 10,
                          ),
                          defaultTextFormFeild(
                              controller: bioController,
                              pre: Icons.description_outlined,
                              HintText: 'Bio',
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'This Field Required';
                                }
                                return null;
                              },
                              KeyType: TextInputType.name),
                          SizedBox(
                            height: 10,
                          ),
                          defaultTextFormFeild(
                              controller: phoneController,
                              pre: Icons.phone_android_sharp,
                              HintText: 'Phone',
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'This Field Required';
                                }
                                return null;
                              },
                              KeyType: TextInputType.number),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
