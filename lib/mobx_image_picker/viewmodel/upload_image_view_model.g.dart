// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UploadImageViewModel on _UploadImageViewModelBase, Store {
  late final _$pickedFileAtom =
      Atom(name: '_UploadImageViewModelBase.pickedFile', context: context);

  @override
  PlatformFile? get pickedFile {
    _$pickedFileAtom.reportRead();
    return super.pickedFile;
  }

  @override
  set pickedFile(PlatformFile? value) {
    _$pickedFileAtom.reportWrite(value, super.pickedFile, () {
      super.pickedFile = value;
    });
  }

  late final _$uploadTaskAtom =
      Atom(name: '_UploadImageViewModelBase.uploadTask', context: context);

  @override
  UploadTask? get uploadTask {
    _$uploadTaskAtom.reportRead();
    return super.uploadTask;
  }

  @override
  set uploadTask(UploadTask? value) {
    _$uploadTaskAtom.reportWrite(value, super.uploadTask, () {
      super.uploadTask = value;
    });
  }

  late final _$isSelectedAtom =
      Atom(name: '_UploadImageViewModelBase.isSelected', context: context);

  @override
  bool get isSelected {
    _$isSelectedAtom.reportRead();
    return super.isSelected;
  }

  @override
  set isSelected(bool value) {
    _$isSelectedAtom.reportWrite(value, super.isSelected, () {
      super.isSelected = value;
    });
  }

  late final _$uploadImageAsyncAction =
      AsyncAction('_UploadImageViewModelBase.uploadImage', context: context);

  @override
  Future<void> uploadImage() {
    return _$uploadImageAsyncAction.run(() => super.uploadImage());
  }

  late final _$_UploadImageViewModelBaseActionController =
      ActionController(name: '_UploadImageViewModelBase', context: context);

  @override
  void filePicked(FilePickerResult? filePickerResult) {
    final _$actionInfo = _$_UploadImageViewModelBaseActionController
        .startAction(name: '_UploadImageViewModelBase.filePicked');
    try {
      return super.filePicked(filePickerResult);
    } finally {
      _$_UploadImageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void uploadTaskPutFile(Reference ref, File file) {
    final _$actionInfo = _$_UploadImageViewModelBaseActionController
        .startAction(name: '_UploadImageViewModelBase.uploadTaskPutFile');
    try {
      return super.uploadTaskPutFile(ref, file);
    } finally {
      _$_UploadImageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void uploadTaskNull() {
    final _$actionInfo = _$_UploadImageViewModelBaseActionController
        .startAction(name: '_UploadImageViewModelBase.uploadTaskNull');
    try {
      return super.uploadTaskNull();
    } finally {
      _$_UploadImageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pickedFile: ${pickedFile},
uploadTask: ${uploadTask},
isSelected: ${isSelected}
    ''';
  }
}
