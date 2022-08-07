class UserModel {

  String? uid;
  String? email;
  String? displayName;
  Map<String, int>? quizScores;

  ///Constructor - instantiates users with 0 scores for all quizes
  UserModel ({this.uid, this.email, this.displayName}) {
    quizScores = {"Introduction into Algebra": 0, "Algebra Continued":0, "Advanced Algebra":0};
  }

/// A method to get user data
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['display name']
    );
  }

  /// A method to set user data
  Map<String, dynamic> toMap (){
    return {
      'uid': uid,
      'email': email,
      'display name': displayName,
      'quiz_scores': quizScores
    };
  }

}