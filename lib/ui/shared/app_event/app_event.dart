import '../../screens/home/model/items_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.freezed.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.clearCart() = ClearCart;

  const factory AppEvent.cartUpdate({required CategoryDish categoryDish}) =
      CartUpdate;
}
