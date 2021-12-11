abstract class SocialStates{}

class initialState extends SocialStates{}

class SocialLoadingState extends SocialStates{}
class SocialSuccessState extends SocialStates{}
class SocialErrorState extends SocialStates{}
//get posts
class GetPostSocialLoadingState extends SocialStates{}
class GetPostSocialSuccessState extends SocialStates{}
class GetPostSocialErrorState extends SocialStates{}
//get Useers
class GetAllUsersSocialLoadingState extends SocialStates{}
class GetAllUsersSocialSuccessState extends SocialStates{}
class GetAllUsersSocialErrorState extends SocialStates{}

//likes
class LikeSocialSuccessState extends SocialStates{}
class LikeSocialErrorState extends SocialStates{}
//comments
class CommentSocialSuccessState extends SocialStates{}
class CommentSocialErrorState extends SocialStates{}

class NewSocialLoadingState extends SocialStates{}
class NewSocialSuccessState extends SocialStates{}
class NewSocialErrorState extends SocialStates{}

class NavigationBarState extends SocialStates{}

class ImagePickerSuccessState extends SocialStates{}
class ImagePickerErrorState extends SocialStates{}
class ImagePickerLoadingState extends SocialStates{}

class CoverPickerSuccessState extends SocialStates{}
class CoverPickerErrorState extends SocialStates{}

class ImageUploadSuccessState extends SocialStates{}
class ImageUploadLoadingState extends SocialStates{}
class ImageUploadErrorState extends SocialStates{}

class CoverUploadSuccessState extends SocialStates{}
class CoverUploadLoadingState extends SocialStates{}
class CoverUploadErrorState extends SocialStates{}

class UpdateErrorState extends SocialStates{}
class UpdateLoadingState extends SocialStates{}

//create post
class CreatePostLoadingState extends SocialStates{}
class CreatePostSuccessState extends SocialStates{}
class CreatePostErrorState extends SocialStates{}

class GetImagePostLoadingState extends SocialStates{}
class GetImagePostSuccessState extends SocialStates{}
class GetImagePostErrorState extends SocialStates{}
class CancelImage extends SocialStates{}

//chats
class SendMassageErrorState extends SocialStates{}
class SendMassageSuccessState extends SocialStates{}
class GetMassageSuccessState extends SocialStates{}

class UploadChatMassageErrorState extends SocialStates{}
class UploadChatMassageLoadingState extends SocialStates{}
