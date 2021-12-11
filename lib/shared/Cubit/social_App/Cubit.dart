import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learning/models/massegeModel.dart';
import 'package:learning/models/post_model.dart';
import 'package:learning/models/usermodel.dart';
import 'package:learning/modules/Home/home_screen.dart';
import 'package:learning/modules/chats/chats_screens.dart';
import 'package:learning/modules/setting/profile.dart';
import 'package:learning/modules/users/users.dart';
import 'package:learning/shared/Cubit/social_App/states.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(initialState());



  static SocialCubit get(context) => BlocProvider.of(context);


  List<Widget> screens =[
    HomeScreen(),
    ChatsScreen(),
   UsersScreen(),
   ProfileScreen(),
  ];
  SocialUserModel userModel;

  void getUserData()
  {
    emit(SocialLoadingState());
     FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)  {
     userModel = SocialUserModel.fromJson(value.data());
     emit(SocialSuccessState());
     getNewData();

    }).catchError((onError){
      print('Errorrrrrr ${onError.toString()}');
      emit(SocialErrorState());
    });
  }
  void getNewData()
  {
    emit(NewSocialLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)  {
      userModel = SocialUserModel.fromJson(value.data());
      emit(NewSocialSuccessState());

    }).catchError((onError){
      print('Errorrrrrr ${onError.toString()}');
      emit(NewSocialErrorState());
    });
  }
  int currentIndex = 0;
  void changeNav(int index)
  {
    if (index == 2)
      getAllUsers();
     if(index == 3)
      getUserData();
     if (index == 0)
       getPosts();
    currentIndex = index;
    emit(NavigationBarState());
  }

  File profileImage;
  var picker = ImagePicker();

  Future <void> getProfileImage() async
  {
    emit(ImagePickerLoadingState());
    final profilePicker = await picker.pickImage(source: ImageSource.gallery);
    if(profilePicker != null)
      {
        profileImage = File(profilePicker.path);
        emit(ImagePickerSuccessState());
      }
    else
      {
        print('Fuck you Hossam');
        emit(ImagePickerErrorState());
      }
  }
  File coverImage;

  Future<void> getCoverImage() async
  {
    emit(ImagePickerLoadingState());
    final coverImagePicker = await picker.pickImage(source: ImageSource.gallery);
    if(coverImagePicker != null)
      {
        coverImage = File(coverImagePicker.path);
        emit(CoverPickerSuccessState());
      }
    else
      {
        print('Fuck you Hossam');
        emit(CoverPickerErrorState());
      }
  }

  File postImage;

  Future<void> getPostImage() async
  {
    emit(GetImagePostLoadingState());
    final postImagePicker = await picker.pickImage(source: ImageSource.gallery);
    if(postImagePicker != null)
    {
      postImage = File(postImagePicker.path);
      emit(GetImagePostSuccessState());
    }
    else
    {
      print('Fuck you Hossam');
      emit(GetImagePostErrorState());
    }
  }

  void cancelImage()
  {
    postImage = null;
    emit(CancelImage());
  }

  void uploadProfileImage({
    @required String phone,
    @required String bio,
    @required String name,


  })
  {

    emit(ImageUploadLoadingState());
   firebase_storage.FirebaseStorage.instance
        .ref()
       .child('users/${Uri.file(profileImage.path).pathSegments.last}')
       .putFile(profileImage)
       .then((p0)
       {
         p0.ref.getDownloadURL().then((value){
           print(value);
           updateUserData(
             phone: phone,
             bio: bio,
             name: name,
             image: value,
           );
           emit(ImageUploadSuccessState());
         }).catchError((onError){
           emit(ImageUploadErrorState());
         });
       })
       .catchError((onError){
     emit(ImageUploadErrorState());
   });
  }

  void uploadCoverImage({
    @required String phone,
    @required String bio,
    @required String name,

  })
  {
    emit(CoverUploadLoadingState());
   firebase_storage.FirebaseStorage.instance
        .ref()
       .child('users/${Uri.file(coverImage.path).pathSegments.last}')
       .putFile(coverImage)
       .then((p0)
       {
         p0.ref.getDownloadURL().then((value){
           print(value);
           updateUserData(
             name: name,
             bio: bio,
             phone: phone,
             cover: value,
           );

         }).catchError((onError){
           emit(CoverUploadErrorState());
         });
       })
       .catchError((onError){
     emit(CoverUploadErrorState());
   });
  }


  void uploadPostImage({
    @required String text,

  })
    {
    String Now = DateFormat("yyyy-MM-dd").format(DateTime.now());
    DateTime now = DateTime.now();
    String  formattedTime = DateFormat.Hm().format(now);
    emit(CoverUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((p0)
    {
      p0.ref.getDownloadURL().then((value){
        print(value);
        createPost(
          dateTime: '$Now at ${formattedTime}'.toString(),
          text: text,
          postPhoto: value,
        );

      }).catchError((onError){
        emit(CoverUploadErrorState());
      });
    })
        .catchError((onError){
      emit(CoverUploadErrorState());
    });
  }

  void createPost({
    @required String text,
    String postPhoto,
    String dateTime,



  })
  {
    String Now = DateFormat("yyyy-MM-dd").format(DateTime.now());
    DateTime now = DateTime.now();
    String  formattedTime = DateFormat.Hm().format(now);
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
      text: text,
      postPhoto: postPhoto??'',
      dateTime: '$Now at ${formattedTime}'.toString(),
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
    );
    FirebaseFirestore.instance.collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());

    })
        .catchError((onError){
      emit(CreatePostErrorState());
    }); }


 void updateUserData({
   @required String phone,
   @required String bio,
   @required String name,
   String image,
   String cover,
 })
 {
   emit(UpdateLoadingState());
   SocialUserModel socialUserModel = SocialUserModel(
     phone: phone,
     bio: bio,
     name: name,
     image:image??userModel.image,
     cover:cover??userModel.cover,
     email: userModel.email,
     uId: userModel.uId,

   );
   FirebaseFirestore.instance.collection('users')
       .doc(userModel.uId)
       .update(socialUserModel.toMap())
       .then((value) {
     getUserData();
   })
       .catchError((onError){
     emit(UpdateErrorState());
   }); }


   List<PostModel> posts =[];
   List<String> postId =[];
   List<int> likesNum =[];
 void getPosts()
 {
   emit(GetPostSocialLoadingState());
   FirebaseFirestore.instance.collection('posts').get().then((value) {
         value.docs.forEach((element) {
           element.reference
           .collection('Likes')
           .get()
           .then((value) {
             likesNum.add(value.docs.length);
             postId.add(element.id);
            // if(userModel.name == element.id)
              posts.add(PostModel.fromJson(element.data()));
           }).catchError((onError){});
         });
         emit(GetPostSocialSuccessState());
   }).catchError((onError)
   {
     emit(GetPostSocialErrorState());
   });
 }



 void postLikes(String postID)
 {
   FirebaseFirestore.instance.collection('posts')
       .doc(postID)
       .collection('Likes')
       .doc(userModel.uId)
       .set({
     'Like': true
   })
       .then((value) {
     emit(LikeSocialSuccessState());

   }).catchError((onError)
   {
     emit(LikeSocialErrorState());
   });
 }

 void setComment(index , {@required String Controller})
 {
   FirebaseFirestore.instance.collection('posts')
       .doc(postId[index])
       .collection('comments')
       .doc(userModel.uId)
       .set({
     'comment': Controller
   }).then((value) {
     emit(CommentSocialSuccessState());
   }).catchError((onError){
     emit(CommentSocialErrorState());
   });
 }

 List<SocialUserModel> users;
 void getAllUsers()
 {
   users = [];
     FirebaseFirestore.instance.collection('users').get().then((value) {
       value.docs.forEach((element)
       {
         if(userModel.uId != element.id)
          users.add(SocialUserModel.fromJson(element.data()));
       });
       emit(GetAllUsersSocialSuccessState());
     }).catchError((onError)
     {
       emit(GetAllUsersSocialErrorState());
     });
 }

 void sendMessage({
   String receiverId,
   String dateTime,
   String text,
   String image,
})
 {
    MessageModel messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      image: image??'',
      senderId: userModel.uId,
    );
  //set chats on my phone
    FirebaseFirestore.instance.collection('users')
    .doc(userModel.uId)
    .collection('chat')
    .doc(receiverId)
    .collection('messages')
    .add(messageModel.toMap()).then((value) {
      emit(SendMassageSuccessState());
    }).catchError((onError){
      emit(SendMassageErrorState());
    });

  // on receiver phone
    FirebaseFirestore.instance.collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userModel.uId)
        .collection('messages')
        .add(messageModel.toMap()).then((value) {
      emit(SendMassageSuccessState());
    }).catchError((onError){
      emit(SendMassageErrorState());
    });
 }
 
 List<MessageModel> messages =[];
 
 
 void getMessages({
   @required String receiverId,

 })
 {
   messages =[];
   FirebaseFirestore.instance
       .collection('users')
       .doc(userModel.uId)
       .collection('chat')
       .doc(receiverId)
       .collection('messages').orderBy('dateTime')
       .snapshots().
   listen((event) {
     messages =[];
     event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
     });
     emit(GetMassageSuccessState());
   });

 }

  File chatImage;

  Future<void> getChatImage() async
  {
    emit(GetImagePostLoadingState());
    final chatImagePicker = await picker.pickImage(source: ImageSource.gallery);
    if(chatImagePicker != null)
    {
      chatImage = File(chatImagePicker.path);
      emit(GetImagePostSuccessState());
    }
    else
    {
      print('Fuck you Hossam');
      emit(GetImagePostErrorState());
    }
  }



  void uploadChatImage()
  {

    emit(CoverUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(chatImage.path).pathSegments.last}')
        .putFile(chatImage)
        .then((p0)
    {
      p0.ref.getDownloadURL().then((value){
        print(value);
        sendMessage(
          image: value
        );

      }).catchError((onError){
        emit(CoverUploadErrorState());
      });
    })
        .catchError((onError){
      emit(CoverUploadErrorState());
    });
  }

}