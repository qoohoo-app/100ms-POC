// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PreviewStore on PreviewStoreBase, Store {
  final _$localTracksAtom = Atom(name: 'PreviewStoreBase.localTracks');

  @override
  List<HMSTrack> get localTracks {
    _$localTracksAtom.reportRead();
    return super.localTracks;
  }

  @override
  set localTracks(List<HMSTrack> value) {
    _$localTracksAtom.reportWrite(value, super.localTracks, () {
      super.localTracks = value;
    });
  }

  final _$errorAtom = Atom(name: 'PreviewStoreBase.error');

  @override
  HMSError? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(HMSError? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$videoOnAtom = Atom(name: 'PreviewStoreBase.videoOn');

  @override
  bool get videoOn {
    _$videoOnAtom.reportRead();
    return super.videoOn;
  }

  @override
  set videoOn(bool value) {
    _$videoOnAtom.reportWrite(value, super.videoOn, () {
      super.videoOn = value;
    });
  }

  final _$audioOnAtom = Atom(name: 'PreviewStoreBase.audioOn');

  @override
  bool get audioOn {
    _$audioOnAtom.reportRead();
    return super.audioOn;
  }

  @override
  set audioOn(bool value) {
    _$audioOnAtom.reportWrite(value, super.audioOn, () {
      super.audioOn = value;
    });
  }

  final _$PreviewStoreBaseActionController =
      ActionController(name: 'PreviewStoreBase');

  @override
  void updateError(HMSError error) {
    final _$actionInfo = _$PreviewStoreBaseActionController.startAction(
        name: 'PreviewStoreBase.updateError');
    try {
      return super.updateError(error);
    } finally {
      _$PreviewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
localTracks: ${localTracks},
error: ${error},
videoOn: ${videoOn},
audioOn: ${audioOn}
    ''';
  }
}
