class UserModel {

  String? uid;
  String? email;
  String? displayName;
  Map<String, int>? quizScores;


  UserModel ({this.uid, this.email, this.displayName}) {
    quizScores = {"Introduction into Algebra": 0, "Algebra Continued":0, "Advanced Algebra":0};
  }

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
      'display name': displayName,
      'quiz_scores': quizScores
    };
  }

}