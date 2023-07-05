import "package:covid_app/Services/states_services.dart";
import "package:covid_app/View/world_states.dart";
import "package:flutter/material.dart";

class CountryDetailScreen extends StatefulWidget {
  String imageUrl, name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  CountryDetailScreen({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.067),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: ReusableRow(
                            title: "Total Cases",
                            value: widget.totalCases.toString()),
                      ),
                      ReusableRow(
                          title: "Total Deaths",
                          value: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: "Total Recovered",
                          value: widget.totalRecovered.toString()),
                      ReusableRow(
                          title: "Active", value: widget.active.toString()),
                      ReusableRow(
                          title: "Critical", value: widget.critical.toString()),
                      ReusableRow(
                          title: "Today Recovered",
                          value: widget.todayRecovered.toString()),
                      ReusableRow(title: "Tests", value: widget.test.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
            ],
          )
        ],
      ),
    );
  }
}
