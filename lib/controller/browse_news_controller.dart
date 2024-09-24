import 'package:flutter_motobike_app/models/bike.dart';
import 'package:flutter_motobike_app/sources/bike_source.dart';
import 'package:get/get.dart';

class BrowseNewsController extends GetxController {
  final _list = <Bike>[].obs;
  List<Bike> get list => _list;
  set list(List<Bike> n) => _list.value = n;

  final _status = ''.obs;
  String get status => _status.value;
  set status(String n) => _status.value = n;

  fetchNews() async {
    status = 'loading';

    final bikes = await BikeSource.fetchNewestBikes();
    if (bikes == null) {
      status = 'something wrong';
      return;
    }

    status = 'success';
    list = bikes;
  }
}
