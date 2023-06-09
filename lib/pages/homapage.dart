import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homepage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _wtController = TextEditingController();
  final _htController = TextEditingController();

  var result = '';
  var tc = Colors.black;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Quicksand",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              tooltip: "Log Out",
              )
        ],
      ),
      body: Center(
        child: Container(
          width: size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
                child: const Text(
                  "Enter Your Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Quicksand",
                  ),
                ),
              ),
              TextField(
                controller: _wtController,
                decoration: const InputDecoration(
                  label: Text("Weight"),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans",
                  ),
                  hintText: "Enter your weight in KG's",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans",
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  suffixIcon: Icon(Icons.line_weight_outlined),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              TextField(
                controller: _htController,
                decoration: const InputDecoration(
                  label: Text("Height"),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans",
                  ),
                  hintText: "Enter your height in CM's",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans",
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  suffixIcon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
                onPressed: () {
                  var wt = _wtController.text.toString();
                  var ht = _htController.text.toString();
                  if (wt != "" && ht != "") {
                    var intWt = int.parse(wt);
                    var intHt = int.parse(ht);
                    var htMet = intHt / 100;
                    var bmi = intWt / (htMet * htMet);
                    var msg = '';
                    if (bmi > 26.3) {
                      msg = "You're OverWeight!!";
                      tc = Colors.red;
                    } else if (bmi < 18.7) {
                      msg = "You're Under Weight!!";
                      tc = Colors.orange;
                    } else {
                      msg = "You're Healthy!!";
                      tc = Colors.green;
                    }

                    setState(() {
                      result =
                          "Your BMI is: ${bmi.toStringAsFixed(2)} kg/m2 \n And $msg";
                    });
                  } else {
                    setState(() {
                      result = "Please fill all the details!!";
                    });
                  }
                },
                child: const Text(
                  "Calculate",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                result,
                style: TextStyle(
                  color: tc,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
