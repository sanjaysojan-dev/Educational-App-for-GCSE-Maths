class UserModel {

  String? uid;
  String? email;
  String? forename;
  String? surname;

  UserModel ({this.uid, this.email, this.forename, this.surname});

// receive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      forename: map['forename'],
      surname: map['surname'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap (){
    return {
      'uid': uid,
      'email': email,
      'forename': forename,
      'surname': surname
    };
  }
}