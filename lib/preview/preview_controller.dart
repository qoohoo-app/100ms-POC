import 'package:golive/meeting/hms_sdk_interactor.dart';
import 'package:golive/service/room_service.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:uuid/uuid.dart';

class PreviewController {
  final String roomId;
  final String user;
  HMSSDKInteractor? _hmsSdkInteractor;

  PreviewController({required this.roomId, required this.user}) : _hmsSdkInteractor = HMSSDKInteractor();

  Future<bool> startPreview() async {
    String token = await RoomService().getToken(user: user, room: roomId);

    HMSConfig config = HMSConfig(
      userId: Uuid().v1(),
      roomId: roomId,
      authToken: token,
      userName: user,
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
