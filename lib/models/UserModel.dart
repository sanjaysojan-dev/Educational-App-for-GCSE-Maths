class UserModel {

  String? uid;
  String? email;
  //String? forename;
  //String? surname;
  String? displayName;

  UserModel ({this.uid, this.email, this.displayName});

// receive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      // forename: map['forename'],
      // surname: map['surname'],

      displayName: map['display name']
    );
  }



  // send data to server
  Map<String, dynamic> toMap (){
    return {
      'uid': uid,
      'email': email,
      'display name': displayName
      // 'forename': forename,
      // 'surname': surname
    };
  }
}