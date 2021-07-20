import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Home'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  List<String> nameList = ['images/oldmangaram.jpg', 'images/jazno.jpg', 'images/zerueru.png', 'images/mamimifooly.jpg'];
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void clicked(int index) {
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.all(4.0),
          childAspectRatio: 8.0 / 14,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          crossAxisCount: 2,
          children: List.generate(10, (index) {
            return 
              GestureDetector(
                onTap: () {
                  print("onTap called. $index");
                },
                child: 
                Container(
                  color: Colors.yellow, 
                  child: Image.asset(
                    nameList[index % nameList.length], 
                    fit: BoxFit.cover)
                )
              );
            
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

