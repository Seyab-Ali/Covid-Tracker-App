import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search With Country Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
              Expanded(
                  child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade800,
                          highlightColor: Colors.grey.shade200,
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
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String conName =
                            snapshot.data![index]['country'].toString();
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeaths:snapshot.data![index]['deaths'],
                                      totalRecovered: snapshot.data![index]['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      test: snapshot.data![index]['tests'])));
                          },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']
                                      .toString()),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (conName
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                image: snapshot.data![index]['countryInfo']['flag'],
                                name: snapshot.data![index]['country'],
                                totalCases: snapshot.data![index]['cases'],
                                totalDeaths:snapshot.data![index]['deaths'],
                                totalRecovered: snapshot.data![index]['recovered'],
                                active: snapshot.data![index]['active'],
                                critical: snapshot.data![index]['critical'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                test: snapshot.data![index]['tests'])));

                          },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']
                                      .toString()),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
