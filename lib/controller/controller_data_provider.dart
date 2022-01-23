import 'package:demoweb/model/main_data.dart';
import 'package:demoweb/model/missions_data.dart';
import 'package:flutter/cupertino.dart';

class DataProvider extends ChangeNotifier{

  List<LaunchPad> launch_pad = [];
  List<MissionData> mission_data = [];


  List getLaunchPadDataList()
  {
    return launch_pad;
  }

  List getMissionData()
  {
    return mission_data;
  }

  updateLaunchPadDataList(List<LaunchPad> data)
  {

    launch_pad.clear();
    launch_pad.addAll(data);

    notifyListeners();
  }


  updateMissionData(List<MissionData> data)
  {
    mission_data.addAll(data);
  }

  searchData(String key){
    if(key.length > 0)
    {
      if(launch_pad.isNotEmpty) {
        launch_pad.clear();

        FetchLaunchPad().fetchLaunchPadData().then((value){

          List daat = value.data!['launchpads'];

          print(daat);

          List<LaunchPad> d = daat.where((element) => element['name'].toString().substring(0,key.length) == key).map((element) {
            if(element['name'].toString().substring(0,key.length) == key)
            {}
            return LaunchPad(element['name'].toString().substring(0,5),double.parse(element['successful_launches'].toString()), element['status']);
          }).toList();

          launch_pad.clear();
          launch_pad.addAll(d);

          notifyListeners();

        });

      }

    }
    else {

      launch_pad.clear();
      print("empty");
      FetchLaunchPad().fetchLaunchPadData().then((value){

        List daat = value.data!['launchpads'];

        print(daat);

        List<LaunchPad> d = daat.map((element) => LaunchPad(element['name'].toString().substring(0,5),double.parse(element['successful_launches'].toString()), element['status'])).toList();

        launch_pad.addAll(d);

        notifyListeners();

      });


    }

  }

  double getMaxLaupadCount()
  {
    if(launch_pad == null){
      return 0.0;
    }
    else {
      launch_pad.sort((LaunchPad s1, LaunchPad s2) =>
      s1.count < s2.count
          ? 1
          : 0);

      //notifyListeners();
      print(launch_pad);
      if (launch_pad.isEmpty) {
        return 0.0;
      } else {
        return launch_pad.first.count;
      }
    }
  }




}