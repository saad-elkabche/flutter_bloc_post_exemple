



class PostModel {
  int id;
  String title;
  String body;
  int userId;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId});

  factory PostModel.fromJson(Map<String,dynamic> json){
    return PostModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        userId:json['userId']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'body':body,
      'userId':userId,
    };
  }


}