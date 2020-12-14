import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  File file;

  FilePickerBloc(FilePickerState initialState) : super(initialState);

  FilePickerState get initialState => InitialFilePickerState();

  @override
  Stream<FilePickerState> mapEventToState(FilePickerEvent event) async* {
    yield InitialFilePickerState();

    if (event is FilePickerEvent) {
      File file;
      if (event.fileType == FileType.custom) {
        file = await FilePicker.getFile(
            type: event.fileType, allowedExtensions: ['pdf']);
      } else {
        file = await FilePicker.getFile(type: FileType.any);
      }
      yield DidSelectedFilePickerState(file);
    } else {
      yield FailedFilePickerEvent('Canceled');
    }
  }
}

// STATE

abstract class FilePickerState extends Equatable {}

class InitialFilePickerState extends FilePickerState {
  @override
  List<Object> get props => null;
}

class ShowPickerFilePickerState extends FilePickerState {
  final File file;

  ShowPickerFilePickerState(this.file);

  @override
  List<Object> get props => [file];
}

class DidSelectedFilePickerState extends FilePickerState {
  final File file;

  DidSelectedFilePickerState(this.file);

  @override
  List<Object> get props => [file];
}

class FailedFilePickerEvent extends FilePickerState {
  final String error;

  FailedFilePickerEvent(this.error);

  @override
  List<Object> get props => [error];
}

// EVENT

class FilePickerEvent extends Equatable {
  final FileType fileType;

  FilePickerEvent(this.fileType);

  @override
  List<Object> get props => [fileType];
}
