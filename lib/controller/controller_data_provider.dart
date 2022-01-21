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