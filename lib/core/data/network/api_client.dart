import 'package:interviewtask/ui/screens/home/model/items_model.dart';

abstract class ApiClient {
  Future<List<ItemsModel>> getItems();
}
