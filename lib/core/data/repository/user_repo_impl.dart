import 'package:get_it/get_it.dart';
import 'package:interviewtask/core/data/repository/user_repo.dart';

import '../../../ui/screens/home/model/items_model.dart';
import '../network/api_client.dart';

class UserRepoImpl extends UserRepo {
  static final apiClient = GetIt.I.get<ApiClient>();

  @override
  Future<List<ItemsModel>> getItems() async {
    return await apiClient.getItems();
  }
}
