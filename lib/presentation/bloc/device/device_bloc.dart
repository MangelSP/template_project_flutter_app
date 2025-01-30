import 'package:finance_connect_app/core/utils/device_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceInfo deviceInfo;

  DeviceBloc({required this.deviceInfo}) : super(DeviceInitial()) {
    on<CheckDeviceType>(_onCheckDeviceType);
  }

  void _onCheckDeviceType(
      CheckDeviceType event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());
    try {
      final deviceType = await deviceInfo.getDeviceType();
      emit(DeviceLoaded(deviceType));
    } catch (e) {
      emit(DeviceError('Failed to detect device type'));
    }
  }
}
