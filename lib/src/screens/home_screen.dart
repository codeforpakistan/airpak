import 'package:flutter/material.dart';
import '../blocs/report_bloc.dart';
import '../models/report.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _showInfo = true;
 
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
      margin: const EdgeInsets.only(top: 100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildLocation(data.userId),
          _buildTemperature(data.id),
          _buildAirQuality(453),
          _buildPollen(100),
          _buildInfoButton(),
        ],
      ),
    );
  }

  Row _buildLocation(int userID) {
    return  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset("assets/images/noun_Location.svg", width: 50, color: Color(0xffaaa9ab)),
      Text(
        "Islamabad",
        style:
          TextStyle(color: Color(0xffaaa9ab), fontSize: 20.0),
        textAlign: TextAlign.left,
      ),
    ]);
  }

  Column _buildTemperature(int temp) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "65 °C  ",
              style:
                TextStyle(color: Color(0xffaf0d0c), fontSize: 24.0),
              textAlign: TextAlign.left,
            ),
            SvgPicture.asset("assets/images/noun_Temperature.svg", width: 60, color: Color(0xffaf0d0c)),
          ],
        ),
        Visibility(
          visible: _showInfo == true,
          maintainState: true,
          maintainAnimation: true,
          child: _buildInfoText('Temperature'),
        )
        
      ]
    );
  }

  // Container _buildDivider() {
  //   return Container(
  //     height: 20, child: Divider(color: Colors.blueGrey));
  // }

  Widget _buildInfoText(String text) {
    return AnimatedOpacity(
      opacity: _showInfo ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$text",
            style: TextStyle(color: Color(0xffaaa9ab), fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
      ])
    );
  }

  Column _buildAirQuality(int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$value gm/cm",
            style:
              TextStyle(color: Color(0xff0d9b9b), fontSize: 24.0),
            textAlign: TextAlign.left,
          ),
          SvgPicture.asset("assets/images/noun_air quality.svg", width: 60, color: Color(0xff0d9b9b)),
        ]),
        Visibility(
          visible: _showInfo == true,
          maintainState: true,
          maintainAnimation: true,
          child: _buildInfoText('Air Quality index'),
        )
      ]
    );
  }

  Column _buildPollen(int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(
            "$value m³ ",
            style:
              TextStyle(color: Color(0xffd98601), fontSize: 24.0),
            textAlign: TextAlign.left,
          ),
          SvgPicture.asset("assets/images/noun_pollen.svg", width: 60, color: Color(0xffd98601)),
        ]),
        Visibility(
          visible: _showInfo == true,
          maintainState: true,
          maintainAnimation: true,
          child: _buildInfoText('Pollen Count'),
        )
      ]
    );
  }

  Widget _buildInfoButton() {
    return Visibility( 
      visible: _showInfo == false,
      maintainState: true,
      maintainAnimation: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() => _showInfo = true);
              Future.delayed(const Duration(milliseconds: 5000), () {
                setState(() => _showInfo = false);
              });
            },
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SvgPicture.asset("assets/images/noun_Question.svg", width: 35, color: Color(0xff6d6d6d)),
              ),
            ),
            
          ),
        ]
      ),
    );
  }

}
