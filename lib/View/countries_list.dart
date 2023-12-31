import "package:covid_app/Services/states_services.dart";
import "package:covid_app/View/country_detail_screen.dart";
import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: " Search with country name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServices.CountryStateApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String countryName = snapshot.data![index]["country"];
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                child: Card(
                                  child: ListTile(
                                    leading: Image(
                                      image: NetworkImage(snapshot.data![index]
                                          ["countryInfo"]["flag"]),
                                      width: 50,
                                      height: 50,
                                    ),
                                    title: Text(snapshot.data![index]["country"]
                                        .toString()),
                                    subtitle: Text("Id: " +
                                        snapshot.data![index]["countryInfo"]
                                                ["_id"]
                                            .toString()),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CountryDetailScreen(
                                                imageUrl: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                name: snapshot.data![index]
                                                    ['country'],
                                                totalCases: snapshot
                                                    .data![index]['cases'],
                                                totalRecovered: snapshot
                                                    .data![index]['recovered'],
                                                totalDeaths: snapshot
                                                    .data![index]['deaths'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                                test: snapshot.data![index]
                                                    ['tests'],
                                              )));
                                },
                              ),
                            ],
                          );
                        } else if (countryName
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                child: Card(
                                  child: ListTile(
                                    leading: Image(
                                      image: NetworkImage(snapshot.data![index]
                                          ["countryInfo"]["flag"]),
                                      width: 50,
                                      height: 50,
                                    ),
                                    title: Text(snapshot.data![index]["country"]
                                        .toString()),
                                    subtitle: Text("Id: " +
                                        snapshot.data![index]["countryInfo"]
                                                ["_id"]
                                            .toString()),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CountryDetailScreen(
                                                imageUrl: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                                name: snapshot.data![index]
                                                ['country'],
                                                totalCases: snapshot
                                                    .data![index]['cases'],
                                                totalRecovered: snapshot
                                                    .data![index]['recovered'],
                                                totalDeaths: snapshot
                                                    .data![index]['deaths'],
                                                active: snapshot.data![index]
                                                ['active'],
                                                critical: snapshot.data![index]
                                                ['critical'],
                                                todayRecovered:
                                                snapshot.data![index]
                                                ['todayRecovered'],
                                                test: snapshot.data![index]
                                                ['tests'],
                                              )));
                                },
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
