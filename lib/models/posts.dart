class Post {
  Post({
    required this.name,
    required this.post,
    required this.profileImage,

  });

  late final String name;
  late final String post;
  late final String profileImage;


  Post.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    post = json['post'].toString();
    profileImage = json['profileImage'].toString();

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = name;
    data['msg'] = post;
    data['read'] = profileImage;
    return data;
  }
}


