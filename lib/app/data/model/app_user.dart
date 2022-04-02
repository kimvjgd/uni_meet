class AppUser {
  String? uid;
  bool? auth;
  String? gender;
  String? name;
  int? age;
  String? mbti;
  String? university;
  String? major;
  List<dynamic>? black;
  String? imagePath;
  String? phone;
  List<dynamic>? chatroomList;
  // DocumentReference reference;

  AppUser({this.uid, this.auth, this.gender, this.name, this.age, this.mbti, this.university, this.major, this.black, this.imagePath, this.phone, this.chatroomList});

  factory AppUser.fromJson(Map<String, dynamic> json){
    return AppUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
        auth: json['auth'] == null ? false : json['auth'] as bool,
        gender: json['gender'] == null ? 'MAN' : json['gender'] as String,
        name: json['name'] == null ? '' : json['name'] as String,
        age: json['age'] == null ? 20 : json['age'] as int,
        mbti: json['mbti'] == null ? '' : json['mbti'] as String,
        university: json['university'] == null ? '' : json['university'] as String,
        major: json['major'] == null ? '' : json['major'] as String,
        black: json['black'] == null ? [] : json['black'] as List,
        imagePath: json['imagePath'] == null ? '' : json['imagePath'] as String,
        phone: json['phone'] == null ? '' : json['phone'] as String,
        chatroomList: json['chatroomList'] == null ? [] : json['chatroomList'] as List,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "auth": auth,
      "gender": gender,
      "name": name,
      "age": age,
      "mbti": mbti,
      "university": university,
      "major": major,
      "black": black,
      "imagePath": imagePath,
      "phone": phone,
      "chatroomList": chatroomList,
    };
  }

  AppUser copyWith({
    String? uid,
    bool? auth,
    String? gender,
    String? name,
    int? age,
    String? mbti,
    String? university,
    String? major,
    List<dynamic>? black,
    String? imagePath,
    String? phone,
    List<dynamic>? chatroomList,
  }){
    return AppUser(
      uid: uid ?? this.uid,
      auth: auth ?? this.auth,
        gender: gender ?? this.gender,
        name: name ?? this.name,
        age: age ?? this.age,
        mbti: mbti ?? this.mbti,
        university: university ?? this.university,
        major: major ?? this.major,
        black: black ?? this.black,
        imagePath: imagePath ?? this.imagePath,
        phone: phone ?? this.phone,
        chatroomList: chatroomList ?? this.chatroomList,
    );
  }



}