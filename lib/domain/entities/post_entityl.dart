

class PostEntity{
  int id;
  String title;
  String body;
  int userId;

  PostEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.userId});

  factory PostEntity.fromJson(Map<String,dynamic> json){
    return PostEntity(
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




