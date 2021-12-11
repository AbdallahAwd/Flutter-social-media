class MessageModel {

  String text;
  String senderId;
  String receiverId;
  String dateTime;
  String image;
  MessageModel(
      {
        this.text,
        this.senderId,
        this.dateTime,
        this.receiverId,
        this.image,

      });

  MessageModel.fromJson(Map<String, dynamic> json) {

    text = json['text'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'dateTime': dateTime,
      'receiverId': receiverId,
      'image': image,
    };
  }
}
