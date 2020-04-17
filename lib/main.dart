import 'package:dio/dio.dart';
import 'package:dropdown_issue_flutter/customwidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Size size;
  List<String> reasonsList = [];
  String currentSelectedValue = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    // reasonsList = List.generate(10, (index) => index.toString()).toList();
  }

  Future<void> fetchData() async {
    reasonsList = [];

    final response = await getReportReasons();
    if (response != null) {
      Map result = response.data;
      print(result);
      Iterable data = result['success']['return reasons'];
      reasonsList = data.map((e) => e['reason'].toString()).toList();
      setState(() {});
      print(reasonsList);
    }
  }

  Future<Response> getReportReasons() async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          'http://iborganic.com/QC/TestApp/index.php?route=api/rma/return_reasons');
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomWidget(
              reasonsList: reasonsList,
              onDropdownSelected: (String selected) {
                print('$selected');
              },
            ),
            RaisedButton(
                child: Text('Tap to SetState'),
                onPressed: () {
                  setState(
                      () {}); // after setState the dropDown Widget gets activated till that it doesnt detect taps
                }),
          ]),
    );
  }
}
