import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '_Name_App';
  static const primaryColor = Color.fromARGB(255, 255, 132, 167);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        
        // appBar: AppBar(
        //     title: const Text(_title),
        //     backgroundColor: primaryColor,
        // ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController UsernameController = TextEditingController();
  TextEditingController RealnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController RepasswordController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  var gender = ['Male', 'FeMale', 'other'];
  String dropdownvalue = 'Male';  
  Image icon = Image(
    image: AssetImage('favicon.png'),
    width: 100,
    height: 100,
    fit: BoxFit.fill
  );


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: icon
            ),

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: const Text(
                  'App Name',
                  style: TextStyle(
                      color: Color.fromARGB(255, 223, 80, 142),
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: const Text(
                  'Create a new account',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              height: 45,
              child: TextField(
                style: TextStyle(fontSize: 14),
                controller: UsernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              height: 45,
              child: TextField(
                style: TextStyle(fontSize: 14),
                controller: RealnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Real Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              height: 45,
              child: TextField(
                style: TextStyle(fontSize: 14),
                controller: EmailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email or phone number',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              height: 45,
              child: TextField(
                style: TextStyle(fontSize: 14),
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              height: 45,
              child: TextField(
                style: TextStyle(fontSize: 14),
                obscureText: true,
                controller: RepasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'RePassword',
                ),
              ),
            ),           
            Container(
              padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
              
              child: Center(
                heightFactor: 0.5,
                child: TextField(
                style: TextStyle(fontSize: 14),
                controller: dateInput,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Birth Date" //label text of field
                    ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));
  
                  if (pickedDate != null) {
                    setState(() {
                      dateInput.text =
                          pickedDate.toString(); //set output date to TextField value.
                    });
                  } else {}
                },
              ))),
            Row(
              children: <Widget>[
                const Text('Gender: '),
                  Container(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Column(
                    children: [
                      DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),   
                        items: gender.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            // ),
            Container(
                height: 45,
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: ElevatedButton(
                  child: const Text('Commit'),
                  onPressed: () {
                    print(UsernameController.text);
                    print(RealnameController.text);
                    print(EmailController.text);
                    print(passwordController.text);
                    print(RepasswordController.text);
                    print(dateInput.text);
                    print(dropdownvalue);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 132, 167),),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20, color: Colors.white,))),
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 15, color: Colors.pink),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}