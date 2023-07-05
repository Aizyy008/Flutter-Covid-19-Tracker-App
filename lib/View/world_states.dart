import 'package:covid_app/Model/world_states_model.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  final colorList = const <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
return Column(
  children: [
    PieChart(
      dataMap:  {"Cases": double.parse(snapshot.data!.cases!.toString()), "Recovered": double.parse(snapshot.data!.recovered!.toString()), "Death": double.parse(snapshot.data!.deaths!.toString())},
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      chartType: ChartType.ring,
      chartValuesOptions: const ChartValuesOptions(
          showChartValuesInPercentage: true
      ),
      animationDuration: Duration(milliseconds: 1200),
      legendOptions: LegendOptions(legendPosition: LegendPosition.left),
      colorList: colorList,
    ),
    Padding(
      padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.06),
      child: Card(
          child: Column(
            children: [
              ReusableRow(title: "Cases", value: snapshot.data!.cases!.toString()),
              ReusableRow(title: "Recovered", value: snapshot.data!.recovered!.toString()),
              ReusableRow(title: "Death", value: snapshot.data!.deaths!.toString()),
              ReusableRow(title: "Today Cases", value: snapshot.data!.todayCases!.toString()),
              ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths!.toString()),
              ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered!.toString()),
              ReusableRow(title: "Active", value: snapshot.data!.active!.toString()),
              ReusableRow(title: "Critical", value: snapshot.data!.critical!.toString()),
              // ReusableRow(title: "Cases Per One Million", value: snapshot.data!.casesPerOneMillion!.toString()),
              // ReusableRow(title: "Deaths Per One Million", value: snapshot.data!.deathsPerOneMillion!.toString()),
              // ReusableRow(title: "Tests", value: snapshot.data!.tests!.toString()),
              // ReusableRow(title: "Tests Per One Million", value: snapshot.data!.testsPerOneMillion!.toString()),
              // ReusableRow(title: "Population", value: snapshot.data!.population!.toString()),
              // ReusableRow(title: "One Case Per People", value: snapshot.data!.oneCasePerPeople!.toString()),
              // ReusableRow(title: "One Death Per People", value: snapshot.data!.oneDeathPerPeople!.toString()),
              // ReusableRow(title: "One Test Per People", value: snapshot.data!.oneTestPerPeople!.toString()),
              // ReusableRow(title: "Active Per Million", value: snapshot.data!.activePerOneMillion!.toString()),
              // ReusableRow(title: "Recovered Per Million", value: snapshot.data!.recoveredPerOneMillion!.toString()),
              // ReusableRow(title: "Critical Per Million", value: snapshot.data!.criticalPerOneMillion!.toString()),
              ReusableRow(title: "Affected Countries", value: snapshot.data!.affectedCountries!.toString()),
            ],
          ),
      ),
    ),
    SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList()));

          },
          child: Center(
              child: Text(
                "Track Countries",
                style: TextStyle(color: Colors.white),
              )),
          backgroundColor: Color(0xff1aa260),
          hoverColor: Colors.grey.shade50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),

      ),
    )
  ],
);

                    }
                  }),

            ],
          ),
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
