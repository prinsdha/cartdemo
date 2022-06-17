// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clearCart,
    required TResult Function(CategoryDish categoryDish) cartUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clearCart,
    TResult Function(CategoryDish categoryDish)? cartUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clearCart,
    TResult Function(CategoryDish categoryDish)? cartUpdate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(CartUpdate value) cartUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ClearCart value)? clearCart,
    TResult Function(CartUpdate value)? cartUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClearCart value)? clearCart,
    TResult Function(CartUpdate value)? cartUpdate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppEventCopyWith<$Res> {
  factory $AppEventCopyWith(AppEvent value, $Res Function(AppEvent) then) =
      _$AppEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppEventCopyWithImpl<$Res> implements $AppEventCopyWith<$Res> {
  _$AppEventCopyWithImpl(this._value, this._then);

  final AppEvent _value;
  // ignore: unused_field
  final $Res Function(AppEvent) _then;
}

/// @nodoc
abstract class _$$ClearCartCopyWith<$Res> {
  factory _$$ClearCartCopyWith(
          _$ClearCart value, $Res Function(_$ClearCart) then) =
      __$$ClearCartCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearCartCopyWithImpl<$Res> extends _$AppEventCopyWithImpl<$Res>
    implements _$$ClearCartCopyWith<$Res> {
  __$$ClearCartCopyWithImpl(
      _$ClearCart _value, $Res Function(_$ClearCart) _then)
      : super(_value, (v) => _then(v as _$ClearCart));

  @override
  _$ClearCart get _value => super._value as _$ClearCart;
}

/// @nodoc

class _$ClearCart implements ClearCart {
  const _$ClearCart();

  @override
  String toString() {
    return 'AppEvent.clearCart()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearCart);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clearCart,
    required TResult Function(CategoryDish categoryDish) cartUpdate,
  }) {
    return clearCart();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clearCart,
    TResult Function(CategoryDish categoryDish)? cartUpdate,
  }) {
    return clearCart?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clearCart,
    TResult Function(CategoryDish categoryDish)? cartUpdate,
    required TResult orElse(),
  }) {
    if (clearCart != null) {
      return clearCart();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(CartUpdate value) cartUpdate,
  }) {
    return clearCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ClearCart value)? clearCart,
    TResult Function(CartUpdate value)? cartUpdate,
  }) {
    return clearCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClearCart value)? clearCart,
    TResult Function(CartUpdate value)? cartUpdate,
    required TResult orElse(),
  }) {
    if (clearCart != null) {
      return clearCart(this);
    }
    return orElse();
  }
}

abstract class ClearCart implements AppEvent {
  const factory ClearCart() = _$ClearCart;
}

/// @nodoc
abstract class _$$CartUpdateCopyWith<$Res> {
  factory _$$CartUpdateCopyWith(
          _$CartUpdate value, $Res Function(_$CartUpdate) then) =
      __$$CartUpdateCopyWithImpl<$Res>;
  $Res call({CategoryDish categoryDish});
}

/// @nodoc
class __$$CartUpdateCopyWithImpl<$Res> extends _$AppEventCopyWithImpl<$Res>
    implements _$$CartUpdateCopyWith<$Res> {
  __$$CartUpdateCopyWithImpl(
      _$CartUpdate _value, $Res Function(_$CartUpdate) _then)
      : super(_value, (v) => _then(v as _$CartUpdate));

  @override
  _$CartUpdate get _value => super._value as _$CartUpdate;

  @override
  $Res call({
    Object? categoryDish = freezed,
  }) {
    return _then(_$CartUpdate(
      categoryDish: categoryDish == freezed
          ? _value.categoryDish
          : categoryDish // ignore: cast_nullable_to_non_nullable
              as CategoryDish,
    ));
  }
}

/// @nodoc

class _$CartUpdate implements CartUpdate {
  const _$CartUpdate({required this.categoryDish});

  @override
  final CategoryDish categoryDish;

  @override
  String toString() {
    return 'AppEvent.cartUpdate(categoryDish: $categoryDish)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartUpdate &&
            const DeepCollectionEquality()
                .equals(other.categoryDish, categoryDish));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(categoryDish));

  @JsonKey(ignore: true)
  @override
  _$$CartUpdateCopyWith<_$CartUpdate> get copyWith =>
      __$$CartUpdateCopyWithImpl<_$CartUpdate>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clearCart,
    required TResult Function(CategoryDish categoryDish) cartUpdate,
  }) {
    return cartUpdate(categoryDish);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clearCart,
    TResult Function(CategoryDish categoryDish)? cartUpdate,
  }) {
    return cartUpdate?.call(categoryDish);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clearCart,
    TResult Function(CategoryDish categoryDish)? cartUpdate,
    required TResult orElse(),
  }) {
    if (cartUpdate != null) {
      return cartUpdate(categoryDish);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClearCart value) clearCart,
    required TResult Function(CartUpdate value) cartUpdate,
  }) {
    return cartUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ClearCart value)? clearCart,
    TResult Function(CartUpdate value)? cartUpdate,
  }) {
    return cartUpdate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClearCart value)? clearCart,
    TResult Function(CartUpdate value)? cartUpdate,
    required TResult orElse(),
  }) {
    if (cartUpdate != null) {
      return cartUpdate(this);
    }
    return orElse();
  }
}

abstract class CartUpdate implements AppEvent {
  const factory CartUpdate({required final CategoryDish categoryDish}) =
      _$CartUpdate;

  CategoryDish get categoryDish => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$CartUpdateCopyWith<_$CartUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}
