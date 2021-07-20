import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mainviewmodel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MainViewModel()
      )
    ],
    child: MainApp(),
  ));
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

  @override
  void initState() {
    MainViewModel viewModel =
    Provider.of<MainViewModel>(context, listen: false);
    viewModel.request();
    print("request at initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    MainViewModel viewModel = Provider.of<MainViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
            padding: EdgeInsets.all(4.0),
            mainAxisSpacing: 1.0,
            childAspectRatio: 8 / 14.0,
            crossAxisCount: 2,
            children: List.generate(viewModel.count(), (index) {
              return GestureDetector(
               onTap: () { print("tap $index"); },
               child: Container(
                color: Colors.amber,
                child: Image.network(viewModel.getImageUrl(index), fit: BoxFit.cover),
               ),
              );
          })
        ),
    ));
  }
}

