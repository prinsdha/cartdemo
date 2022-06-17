import 'package:interviewtask/ui/screens/home/model/items_model.dart';

abstract class UserRepo {
  Future<List<ItemsModel>> getItems();
}
