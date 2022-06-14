class User {

  String? uid;
  String? email;
  String? forename;
  String? surname;

  User ({this.uid, this.email, this.forename, this.surname});

// receive data from server
  factory User.fromMap(map){
    return User(
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