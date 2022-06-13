import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GCSE Maths Educational App"),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          // SizedBox(
          //   height: 200,
          //   child: Image.asset(''
          //   , fit: BoxFit.contain
          //   )),],
            Text("Quiz", style: TextStyle (fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10 ,),
            Text ("Name", style:  TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
            SizedBox(height: 10 ,),
            Text ("Email", style:  TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
            ActionChip(label: Text( "Logout", style: TextStyle(color:Colors.black45, fontWeight: FontWeight.bold),), onPressed: (){})

          ]
        ),
      )
      ),
    );
  }
}
