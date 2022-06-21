class UserModel {

  String? uid;
  String? email;
  String? displayName;

  UserModel ({this.uid, this.email, this.displayName});

// receive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['display name']
    );
  }

  // send data to server
  Map<String, dynamic> toMap (){
    return {
      'uid': uid,
      'email': email,
      'display name': displayName
    };
  }
}