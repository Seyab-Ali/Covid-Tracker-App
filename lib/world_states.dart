import 'package:covid_tracker_app/Model/WorldStateModel.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = [
    const Color(0xff4285f4),
    const Color(0xff1ae260),
    const Color(0xff6e5245),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              FutureBuilder(
                future: statesServices.fetchWorldStateRecord(),
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitCircle(
                          controller: _controller,
                          color: Colors.white,
                          size: 50,
                        ));
                  } else {
                    return Column(
                      children: [
                         PieChart(
                          dataMap: {
                            'Total': double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(snapshot.data!.recovered.toString()),
                            'Deaths': double.parse(snapshot.data!.deaths.toString()),
                          //  'Today Deaths' : double.parse(snapshot.data!.todayDeaths.toString())
                            //  'Serious' : 3
                          },
                           chartValuesOptions: ChartValuesOptions(
                               showChartValuesInPercentage: true
                           ),
                          animationDuration: Duration(seconds: 2),
                          chartType: ChartType.ring,
                          chartRadius: 170,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                ReuseRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ReuseRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                ReuseRow(title: 'Active', value: snapshot.data!.active.toString()),
                                ReuseRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                ReuseRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                ReuseRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString())

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesList()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:
                                  const Center(child: Text('Track Countries')),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  String title, value;

  ReuseRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
