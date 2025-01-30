part of 'device_bloc.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object> get props => [];
}

class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceLoaded extends DeviceState {
  final String deviceType;

  DeviceLoaded(this.deviceType);

  @override
  List<Object> get props => [deviceType];
}

class DeviceError extends DeviceState {
  final String message;

  DeviceError(this.message);

  @override
  List<Object> get props => [message];
}
