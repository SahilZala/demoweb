
import 'package:demoweb/controller/controller_data_provider.dart';
import 'package:demoweb/controller/controller_main_view_index_changer.dart';
import 'package:demoweb/model/main_data.dart';
import 'package:demoweb/model/missions_data.dart';
import 'package:demoweb/tools/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget
{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {

    FetchLaunchPad().fetchLaunchPadData().then((value){

      print(value.data!['launchpads']);
      List daat = value.data!['launchpads'];

      List d = daat.map((element) => LaunchPad(element['name'].toString().substring(0,5),double.parse(element['successful_launches'].toString()), element['status'])).toList();

      context.read<DataProvider>().updateLaunchPadDataList(d as List<LaunchPad>);

    });

    FetchMissionData().fetchMissionData().then((value){
      List daat = value.data!['missions'];

      print(daat[0]['name']);
       List d = daat.map((element) => MissionData(element['name'].toString(),element['description'],element['id'],element['manufacturers'][0],element['website'],)).toList();
      //
      context.read<DataProvider>().updateMissionData(d as List<MissionData>);

      print(context.read<DataProvider>().mission_data.length);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

     return SafeArea(
       child: Scaffold(
        backgroundColor: getMainColor(),
        body: _getMainContainer(context),
    ),
     );
  }

  Widget _getMainContainer(BuildContext context)
  {
    return Row(
      children: [
        _getSideBar(context),
        _getCenterContainer(context),
      ],
    );
  }

  Widget _getSideBar(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white
      ),

      child: Column(
        children: [


      Container(
        width: 35,
          height: 35 ,
          decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage(
                "images/spacex_icon.png",
              ),
              fit: BoxFit.fill
            )
          ),
        ),

          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: (){
                          context.read<MainViewIndexChanger>().update(0);
                        },
                        icon: const Icon(
                          Icons.dashboard_outlined,
                          size: 25,
                          color: Color.fromRGBO(39, 55, 70, 1),
                        )
                    ),

                    IconButton(
                        onPressed: (){
                          context.read<MainViewIndexChanger>().update(1);
                        },
                        icon: const Icon(
                          Icons.graphic_eq,
                          size: 25,
                          color: Color.fromRGBO(39, 55, 70, 1),
                        )
                    ),

                    IconButton(
                        onPressed: (){
                          context.read<MainViewIndexChanger>().update(2);
                        },
                        icon: const Icon(
                          Icons.info_outline,
                          size: 25,
                          color: Color.fromRGBO(39, 55, 70, 1),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCenterContainer(BuildContext context)
  {
    return Expanded(
      flex: 10,
        child: Container(
          decoration: BoxDecoration(
              color: getMainColor()
          ),
          child: context.watch<MainViewIndexChanger>().index == 0 ? _getDashbordContainer(context) : context.watch<MainViewIndexChanger>().index == 1 ? _getGraphBord(context) : _getInfo(context),
        ),
    );
  }

  Widget _getDashbordContainer(BuildContext context)
  {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                "Explore Space with Spacex",
                style: TextStyle(
                  fontSize: 40,
                  color:  Color.fromRGBO(28, 40, 51, 1),
                  fontFamily:  "font_black",
                  //fontWeight: FontWeight.bold,

                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: getLogoColor(),
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://cdn.dribbble.com/users/5342679/screenshots/11893348/media/a4942ea117321561ece782251cd3be9b.gif",
                  ),
                  fit: BoxFit.cover
                )
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget _getGraphBord(BuildContext context)
  {

    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: const Text(
                "Graph present",
                style: TextStyle(
                  fontSize: 40,
                  color:  Color.fromRGBO(28, 40, 51, 1),
                  fontFamily:  "font_black",
                  //fontWeight: FontWeight.bold,

                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
              ),


              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                height: MediaQuery.of(context).size.height/2.5,
                              margin: EdgeInsets.all(15),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                  text: "Total launches from different space station",
                                  alignment: ChartAlignment.near,
                                    textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "fonts",
                                    fontWeight: FontWeight.bold,
                                      fontSize: 22

                                  )
                                ),
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(minimum: 0, maximum: context.watch<DataProvider>().getMaxLaupadCount(), interval: 1),
                                  tooltipBehavior: _tooltip,
                                  series: <ChartSeries<LaunchPad, String>>[
                                    BarSeries<LaunchPad, String>(
                                        dataSource: context.watch<DataProvider>().launch_pad,
                                        xValueMapper: (LaunchPad data, _) => data.lname.toString(),
                                        yValueMapper: (LaunchPad data, _) => data.count,
                                        name: 'count of launches',
                                        color: Colors.blueGrey)
                                  ]
                              )
                            ),
                          ),
                        ),
                      ),


                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Material(
                      //       elevation: 5,
                      //       borderRadius: BorderRadius.circular(10),
                      //       child: Container(
                      //         height: MediaQuery.of(context).size.height/2.5,
                      //         margin: EdgeInsets.all(15),
                      //         child: SfCartesianChart(
                      //
                      //             primaryXAxis: CategoryAxis(),
                      //             // Chart title
                      //             title: ChartTitle(text: 'Half yearly sales analysis'),
                      //             // Enable legend
                      //             legend: Legend(isVisible: true),
                      //             // Enable tooltip
                      //             tooltipBehavior: _tooltipBehavior,
                      //
                      //             series: <LineSeries<SalesData, String>>[
                      //               LineSeries<SalesData, String>(
                      //                   dataSource:  <SalesData>[
                      //                     SalesData('Jan', 35),
                      //                     SalesData('Feb', 28),
                      //                     SalesData('Mar', 34),
                      //                     SalesData('Apr', 32),
                      //                     SalesData('May', 40)
                      //                   ],
                      //                   xValueMapper: (SalesData sales, _) => sales.year,
                      //                   yValueMapper: (SalesData sales, _) => sales.sales,
                      //                   // Enable data label
                      //                   dataLabelSettings: DataLabelSettings(isVisible: true)
                      //               )
                      //             ]
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),


                  _getDataInTabularForm(context),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget _getDataInTabularForm(BuildContext context)
  {

    print(context.watch<DataProvider>().launch_pad);

    List<TableRow> table_row = [];

    table_row.add(TableRow(children: [
      Column(children:const [
        Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("launch name",
            style: TextStyle(
                fontSize: 20.0,
              fontWeight: FontWeight.bold,

            )
        ),
      )]),
      Column(children:const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("launch count",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,

              )
          ),
        )]),
      Column(children:const [


        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("launch status",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,

              )
          ),
        )]
      )]
    ));
    table_row.addAll(context.watch<DataProvider>().launch_pad.map((e){
      return TableRow( children: [
        Column(children:[Text(e.lname, style: const TextStyle(fontSize: 20.0))]),
        Column(children:[Text('${e.count}', style: const TextStyle(fontSize: 20.0))]),
        Column(children:[Text(e.status, style: const TextStyle(fontSize: 20.0))]),
      ]);
    }).toList());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[


      Wrap(
        spacing: 30,
        runSpacing: 10,
        alignment: WrapAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: const Text(
              "Tabular representation",
              style: TextStyle(
                fontSize: 30,
                color:  Color.fromRGBO(28, 40, 51, 1),
                fontFamily:  "font_black",
                //fontWeight: FontWeight.bold,

              ),
            ),
          ),

          Form(
            key: _searchKey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/5,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'search key';
                      }

                      return null;
                    },
                    onChanged: (key){
                      context.read<DataProvider>().searchData(key);
                    },

                    maxLength: 5,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontFamily: "fonts",
                        fontWeight: FontWeight.bold
                    ),

                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "search here",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,
                              color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,
                              color: Colors.black)
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),


        ],
      ),

      Container(
        margin: EdgeInsets.all(20),
        child: Table(
          defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/5),
          border: TableBorder.all(
              color: Colors.black,
              style: BorderStyle.solid,),
          children: table_row,
        ),
      ),
    ]);
  }

  Widget _getInfo(BuildContext context)
  {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: const Text(
                "Mission Info.",
                style: TextStyle(
                  fontSize: 40,
                  color:  Color.fromRGBO(28, 40, 51, 1),
                  fontFamily:  "font_black",
                  //fontWeight: FontWeight.bold,

                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(
                    height: 20,
                  ),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: context.watch<DataProvider>().getMissionData().map((var e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Text(
                                "${e.name}",
                              style: TextStyle(
                                color: getLogoColor(),
                                fontSize: 30,
                                fontFamily: "fonts",
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            child: Text(
                              "${e.description}",
                              style: TextStyle(
                                color: getLogoColor(),
                                fontSize: 20,
                                fontFamily: "fonts",
                                fontWeight: FontWeight.normal,

                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          MaterialButton(
                            onPressed: () {
                              showChangeDialogBox(e.description);
                            },
                            child: Text("Edit it."),
                            color: Colors.blue,
                            elevation: 0,
                            padding: EdgeInsets.all(15),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    }).toList()
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  void showChangeDialogBox(String data)
  {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
            alignment: Alignment.bottomCenter,
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
               // _controller.document.insert(0, "$data");
                return Container(
                  margin: const EdgeInsets.all(25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.5,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Scaffold(
                    body: Container(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            },
                                icon: const Icon(Icons.minimize,size: 30,),
                              color: getLogoColor(),
                            ),

                            const SizedBox(height: 20,),

                            // quil.QuillToolbar.basic(controller: _controller),
                            // Container(
                            //   child: quil.QuillEditor.basic(
                            //     controller: _controller,
                            //     readOnly: false, // true for view only mode
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );

  }

  //quil.QuillController _controller = quil.QuillController.basic();


  GlobalKey<FormState> _searchKey = new GlobalKey();
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  TextEditingController _searchController = new TextEditingController();
  var _tooltip = TooltipBehavior(enable: true);
}


class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
