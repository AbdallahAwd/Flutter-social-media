class PostModel {

  String text;
  String postPhoto;
  String dateTime;
  String uId;
  String image;
  String name;
  PostModel(
      {
        this.text,
        this.postPhoto,
        this.dateTime,
        this.uId,
        this.name,
        this.image,
      });

  PostModel.fromJson(Map<String, dynamic> json) {

    text = json['text'];
    postPhoto = json['postPhoto'];
    dateTime = json['dateTime'];
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'postPhoto': postPhoto,
      'text': text,
      'dateTime': dateTime,
      'uId': uId,
      'name': name,
      'image': image,
    };
  }
}
