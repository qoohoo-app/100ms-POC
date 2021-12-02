import 'package:golive/meeting/hms_sdk_interactor.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';

class PreviewController {
  final String roomId;
  final HMSConfig config;
  HMSSDKInteractor? _hmsSdkInteractor;

  PreviewController({
    required this.roomId,
    required this.config,
  }) : _hmsSdkInteractor = HMSSDKInteractor();

  Future<bool> startPreview() async {
    _hmsSdkInteractor?.previewVideo(config: config, isProdLink: true, setWebRtcLogs: false);
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
