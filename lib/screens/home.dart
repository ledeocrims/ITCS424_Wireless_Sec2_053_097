import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

//Define most usage color for easier to call and use
final Color mainHexColor = HexColor("#1C1C1C");
final Color accentHexColor = HexColor("#fcbd1c");
final Color valueHexColor = HexColor("#ffffff");

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Define weight and height variable
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  double bmi_result = 0;
  String _textResult = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI Calculator",
            style: TextStyle(
                fontSize: 25.0,
                color: accentHexColor,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0, //not have shadow effects
          centerTitle: true,
        ),
        backgroundColor: mainHexColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40.0,
              ),

              //Receiving an input from (keyboardType: TextinputType.number)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130.0,
                    child: TextField(
                      controller: _heightController,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 42.0,
                        color: accentHexColor,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "HEIGHT",
                          hintStyle: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(.8),
                          )),
                    ),
                    
                  ),
                  SizedBox(
                    width: 130.0,
                    child: TextField(
                      controller: _weightController,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 42.0,
                        color: accentHexColor,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "WEIGHT",
                          hintStyle: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(.8),
                          )),
                    ),
                  )
                ],
              ),
              
              //Input value type - (cm), (kg)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130.0,
                    child: Text(
                      "CM",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0,
                        color: valueHexColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                  ),
                  SizedBox(
                    width: 130.0,
                    child: Text(
                      "KG",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0,
                        color: valueHexColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              
              //Blank Space
              const SizedBox(
                height: 30.0,
              ),
              //Setting value of height and weight to default first,
              GestureDetector(
                onTap: () {
                  double _h = _heightController.text.isNotEmpty
                      ? double.parse(_heightController.text)
                      : 0.00;
                  double _w = _weightController.text.isNotEmpty
                      ? double.parse(_weightController.text)
                      : 0.00;
                  
                  //BMI Computation
                  setState(() {
                    bmi_result = _w / (_h * _h / 10000); //deivided by 10,000 to convert value base to bmi standard value
                    if ((_h <= 0) || (_w <= 0)) {
                      bmi_result = 0.0;
                      _textResult = " ";
                    } else if (bmi_result > 30) {
                      _textResult = "OBESITY!";
                    } else if (bmi_result >= 25 && bmi_result <= 29.9) {
                      _textResult = "OVERWEIGHT!";
                    }else if (bmi_result >= 18.6 && bmi_result <= 24.9) {
                      _textResult = "NORMAL WEIGHT!";
                    }else {
                      _textResult = "UNDERWEIGHT!";
                    }
                  });
                },
                //Calculate button and decoration
                child: Container(
                  child: Text(
                    "CALCULATE",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: valueHexColor,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              
              //Blank Space
              SizedBox(
                height: 50.0,
              ),
              
              //Result text decoration
              Container(
                child: Text(
                  bmi_result.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                      color: accentHexColor,
                      ),
                    
                ),
              ),
              
              //Blank Space
              SizedBox(
                height: 30.0,
              ),
              
              //Result value decoration
              Visibility(
                visible: _textResult.isNotEmpty,
                child: Container(
                  child: Text(
                    _textResult,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: valueHexColor),
                  ),
                ),
              ),
              
              //Blank Space
              SizedBox(
                height: 100.0,
              ),

              //Detail page linked button
              Center(
                child: ElevatedButton(
                  child: const Text('FOR MORE DETAIL'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DetailRoute()),
                    );
                  },
                  
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: accentHexColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      );
  }
}

/////////////////////////////////////////////////////////////////

class DetailRoute extends StatelessWidget {
  const DetailRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI Calculator",
            style: TextStyle(
                fontSize: 25.0,
                color: accentHexColor,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0, //not have shadow effects
          centerTitle: true,
        ),
        backgroundColor: mainHexColor,
        

        body: SingleChildScrollView(
          child: Column(
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                
                SizedBox(
                  height: 30.0,
                ),  
                //Row 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('UNDERWEIGHT'),
                        onPressed: () {
                          // Navigate to second route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const UnderweightRoute()),
                          );
                        },
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: accentHexColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                //Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('NORMAL WEIGHT'),
                        onPressed: () {
                          // Navigate to second route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DetailRoute()),
                          );
                        },
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: accentHexColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                //Row 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('OVERWEIGHT'),
                        onPressed: () {
                          // Navigate to second route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DetailRoute()),
                          );
                        },
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: accentHexColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                //Row 4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('OBESITY'),
                        onPressed: () {
                          // Navigate to second route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DetailRoute()),
                          );
                        },
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: accentHexColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
          ),
        ),
    );
  }
}

/////////////////////////////////////////////////////////////////

class UnderweightRoute extends StatelessWidget {
  const UnderweightRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI Calculator",
            style: TextStyle(
                fontSize: 25.0,
                color: accentHexColor,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0, //not have shadow effects
          centerTitle: true,
        ),
        backgroundColor: mainHexColor,

        body: SingleChildScrollView(
          child: Column(
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                //Row 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('UNDERWEIGHT'),
                        onPressed: () {
                          // Navigate to second route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DetailRoute()),
                          );
                        },
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: accentHexColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                //Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('NORMAL WEIGHT'),
                        onPressed: () {
                          // Navigate to second route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DetailRoute()),
                          );
                        },
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: accentHexColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
          ),
        ),
    );
  }
}
