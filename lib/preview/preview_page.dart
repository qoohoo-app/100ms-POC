import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:golive/common/ui/organisms/peer_item_organism.dart';
import 'package:golive/common/util/utility_components.dart';
import 'package:golive/meeting/meeting_page.dart';
import 'package:golive/meeting/meeting_store.dart';
import 'package:golive/preview/preview_controller.dart';
import 'package:golive/preview/preview_store.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class PreviewPage extends StatefulWidget {
  final String roomId;
  final HMSConfig config;

  const PreviewPage({
    Key? key,
    required this.roomId,
    required this.config,
  }) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> with WidgetsBindingObserver {
  late PreviewStore _previewStore;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _previewStore = PreviewStore();
    _previewStore.previewController = PreviewController(
      roomId: widget.roomId,
      config: widget.config,
    );
    super.initState();
    initPreview();
    reaction((_) => _previewStore.error,
        (event) => {UtilityComponents.showSnackBarWithString((event as HMSError).message, context)});
  }

  void initPreview() async {
    _previewStore.startListen();
    bool ans = await _previewStore.startPreview();
    if (ans == false) {
      UtilityComponents.showSnackBarWithString("Unable to preview", context);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24);
    final double itemWidth = size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: itemHeight,
          width: itemWidth,
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Observer(
                  builder: (_) {
                    if (_previewStore.localTracks.isEmpty) {
                      return Column(children: [
                        CupertinoActivityIndicator(radius: 124),
                        SizedBox(
                          height: 64.0,
                        ),
                        Text("No preview available") //
                      ]);
                    }
                    return GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: List.generate(
                          _previewStore.localTracks.length,
                          (index) => PeerItemOrganism(
                                key: UniqueKey(),
                                height: itemHeight,
                                width: itemWidth,
                                track: _previewStore.localTracks[index],
                                isVideoMuted: false,
                              )),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (_previewStore.videoOn) {
                          _previewStore.stopCapturing();
                        } else {
                          _previewStore.startCapturing();
                        }
                        setState(() {});
                      },
                      child: Icon(_previewStore.videoOn ? Icons.videocam : Icons.videocam_off, size: 48),
                    ),
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      _previewStore.removeListener();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => Provider<MeetingStore>(
                            create: (_) => MeetingStore(),
                            child: MeetingPage(
                              roomId: widget.roomId,
                              config: widget.config,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Join Now',
                      style: TextStyle(height: 1, fontSize: 18),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () async {
                      _previewStore.switchAudio();
                      setState(() {});
                    },
                    child: Icon(_previewStore.audioOn ? Icons.mic : Icons.mic_off, size: 48),
                  ))
                ],
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (_previewStore.videoOn) {
        _previewStore.previewController.startCapturing();
      }
    } else if (state == AppLifecycleState.paused) {
      if (_previewStore.videoOn) {
        _previewStore.previewController.stopCapturing();
      }
    } else if (state == AppLifecycleState.inactive) {
      if (_previewStore.videoOn) {
        _previewStore.previewController.stopCapturing();
      }
    }
  }
}
