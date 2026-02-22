part of 'appauth_cubit.dart';

@immutable
abstract class AppauthState {}

class AppauthInitial extends AppauthState {}

class AppauthLoading extends AppauthState {}

class AppauthSuccess extends AppauthState {}

class AppauthError extends AppauthState {
  final String message;
  AppauthError({required this.message});
}
