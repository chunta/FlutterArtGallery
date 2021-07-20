import 'package:flutter/material.dart';
import 'mainviewmodel.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Main'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  MainViewModel viewModel = MainViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.addListener(() {
      print("view model done with: ${viewModel.count()}");
      Align(child: CircularProgressIndicator());
    });
    viewModel.request();
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
          children: List.generate(viewModel.count(), (index) {
            return 
              GestureDetector(
                onTap: () {
                  print("onTap called. $index");
                  viewModel.echo();
                  viewModel.request();
                },
                child: 
                Container(
                  color: Colors.yellow, 
                  child: Image.asset(
                    viewModel.getImageUrl(index),
                    fit: BoxFit.cover)
                )
              );
            
          }),
        ),
      ),
    );
  }
}

