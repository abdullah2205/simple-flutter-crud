import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName, studentID, studyProgramID;
  double studentGPA;

  getStudentName(name){
    this.studentName = name;
  }

  getStudentID(id){
    this.studentID = id;
  }

  getStudyProgramID(programID){
    this.studyProgramID = programID;
  }

  getStudentGPA(gpa){
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentID);

    Map<String, dynamic> students = {
      "studentID": studentID,
      "studentName": studentName,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };

    documentReference.set(students).whenComplete(() {
      print("$studentID dibuat");
    });
  }

  readData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentID);

    documentReference.get().then((datasnapshot) {
      print("ID : " + datasnapshot.data()["studentID"]);
      print("Name : " + datasnapshot.data()["studentName"]);
      print("Study Program ID : " + datasnapshot.data()["studyProgramID"]);
      print("GPA : " + datasnapshot.data()["studentGPA"].toString());
    });
  }

  updateData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentID);

    Map<String, dynamic> students = {
      "studentID": studentID,
      "studentName": studentName,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };

    documentReference.update(students).whenComplete(() {
      print("$studentID diperbarui");
    });
  }

  deleteData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentID);

    documentReference.delete().whenComplete(() => print("$studentID dihapus"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD FLutter "),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom : 13.0, top: 5, right: 13, left: 13),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6, // 60% of space => (6/(6 + 4))
              child:
                ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.0,
                        ),
                        decoration: InputDecoration(
                            labelText: "Student ID",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1.0
                                ))),
                        onChanged: (String id){
                          getStudentID(id);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom : 3.0, top: 5.0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.0,
                        ),
                        decoration: InputDecoration(
                            labelText: "Name",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1.0
                                ))),
                        onChanged: (String name){
                          getStudentName(name);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom : 3.0, top: 5.0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.0,
                        ),
                        decoration: InputDecoration(
                            labelText: "Study Program ID",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1.0
                                ))),
                        onChanged: (String programID){
                          getStudyProgramID(programID);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom : 3.0, top: 5.0),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.0,
                        ),
                        decoration: InputDecoration(
                            labelText: "GPA",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1.0
                                ))),
                        onChanged: (String gpa){
                          getStudentGPA(gpa);
                        },
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: Text("Create"),
                            textColor: Colors.white,
                            onPressed: () {
                              createData();
                            },
                          ),
                          RaisedButton(
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: Text("Update"),
                            textColor: Colors.white,
                            onPressed: () {
                              updateData();
                            },
                          ),
                          RaisedButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: Text("Delete"),
                            textColor: Colors.white,
                            onPressed: () {
                              deleteData();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
            Padding(
              padding: EdgeInsets.only(bottom : 13.0, top : 13.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Student ID"),
                  ),
                  Expanded(
                    child: Text("Name"),
                  ),
                  Expanded(
                    child: Text("Program ID"),
                  ),
                  Expanded(
                    child: Text("GPA"),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4, // 40% of space
              child: StreamBuilder <QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("MyStudents").orderBy("studentID").snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Align(
                      alignment: FractionalOffset.topCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                  else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index){
                          DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                          return
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(documentSnapshot["studentID"]),
                                  ),
                                  Expanded(
                                    child: Text(documentSnapshot["studentName"]),
                                  ),
                                  Expanded(
                                    child: Text(documentSnapshot["studyProgramID"]),
                                  ),
                                  Expanded(
                                    child: Text(documentSnapshot["studentGPA"].toString()),
                                  ),
                                ],
                              ),
                            );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}