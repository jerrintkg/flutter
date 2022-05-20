import 'package:get/get.dart';

class HomeController extends GetxController {
  
  var data = 'Jerrin'.obs;
  var list = [{'dev':'jerrin' ,'age':25,'team':'hybrid'}.obs,{'dev':'abhilash','age':30,'team':'php'}].obs;
  var map = {'dev':'jerrin' ,'age':25,'team':'hybrid'}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  
  void changeData(value){
    print(data);
    data = value;
    // list[0]['dev'] = value;
    // map['dev'] = value;
    // print(list);
  }
}