import 'package:flutter/material.dart';
import '../blocs/report_bloc.dart';
import '../models/report.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    reportBloc.fetchReport();
    return StreamBuilder(
        stream: reportBloc.result,
        builder: (context, AsyncSnapshot<Report> snapshot) {
          if (snapshot.hasData) {
            return _buildHomeScreen(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Container _buildHomeScreen(Report data) {
    return Container(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildTitle(data.userId),
          _buildID(data.id),
          _buildMain(data.title),
          _buildButton(),
        ],
      ),
    );
  }

  Center _buildTitle(int userID) {
    return Center(
      child: Text(
        "User id $userID",
        style:
            TextStyle(color: Color.fromRGBO(0, 123, 174, 100), fontSize: 40.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Column _buildID(int id) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Item ID: $id",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  Column _buildMain(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Gibberish",
            style: TextStyle(
              color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        _buildDivider(),
        Text(
          title.toString(),
          style: TextStyle(
            color: Colors.black54, fontSize: 14.0 ), 
        ),
      ],
    );
  }

   Widget _buildButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: RaisedButton (
            child: Text('Refresh'),
            key: Key("refresh"),
            onPressed: () {
              reportBloc.fetchReport();
            },
            color: Color.fromRGBO(240, 240, 240, 20),
            textColor: Colors.black87,
          ),
        ),
      ],
    );
  }

  Container _buildDivider() {
    return Container(
      height: 20, child: Divider(color: Colors.blueGrey));
  }

}
