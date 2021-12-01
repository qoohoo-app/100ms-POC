import 'package:golive/meeting/hms_sdk_interactor.dart';
import 'package:golive/service/room_service.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';

class PreviewController {
  final String roomId;
  final String userId;
  final String userName;
  final String role;
  HMSSDKInteractor? _hmsSdkInteractor;

  PreviewController({
    required this.roomId,
    required this.userName,
    required this.userId,
    required this.role,
  }) : _hmsSdkInteractor = HMSSDKInteractor();

  Future<bool> startPreview() async {
    String token = await RoomService().getToken(
      userId: userId,
      roomId: roomId,
      role: role,
    );

    HMSConfig config = HMSConfig(
      userId: userId,
      roomId: roomId,
      authToken: token,
      userName: userName,
    );

    _hmsSdkInteractor?.previewVideo(config: config, isProdLink: false, setWebRtcLogs: true);
    return true;
  }

  void startListen(HMSPreviewListener listener) {
    _hmsSdkInteractor?.addPreviewListener(listener);
  }

  void removeListener(HMSPreviewListener listener) {
    _hmsSdkInteractor?.removePreviewListener(listener);
  }

  void stopCapturing() {
    _hmsSdkInteractor?.stopCapturing();
  }

  void startCapturing() {
    _hmsSdkInteractor?.startCapturing();
  }

  void switchAudio({bool isOn = false}) {
    _hmsSdkInteractor?.switchAudio(isOn: isOn);
  }

  void addLogsListener(HMSLogListener hmsLogListener) {
    _hmsSdkInteractor?.addLogsListener(hmsLogListener);
  }

  void removeLogsListener(HMSLogListener hmsLogListener) {
    _hmsSdkInteractor?.removeLogsListener(hmsLogListener);
  }
}
