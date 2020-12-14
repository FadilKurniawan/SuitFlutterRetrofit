import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  File image;

  ImagePickerBloc(ImagePickerState initialState) : super(initialState);

  ImagePickerState get initialState => InitialImagePickerState();

  @override
  void onTransition(Transition<ImagePickerEvent, ImagePickerState> transition) {
    print("IMAGE PICKER BLOC");
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<ImagePickerState> mapEventToState(ImagePickerEvent event) async* {
    yield InitialImagePickerState();
    var imagePicker = ImagePicker();
    if (event is GalleryImagePickerEvent) {
      final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (file != null) {
          this.image = file;
          yield GalleryImagePickerState(this.image);
        }
      } else {
        yield FailedImagePickerEvent('Image not found');
      }
    } else if (event is CameraImagePickerEvent) {
      var pickedFile = await imagePicker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (file != null) {
          this.image = file;
          yield GalleryImagePickerState(this.image);
        }
      } else {
        yield FailedImagePickerEvent('Image not found');
      }
    } else {
      yield FailedImagePickerEvent('Canceled');
    }
  }
}

abstract class ImagePickerState extends Equatable {}

abstract class ImagePickerEvent extends Equatable {}

// STATE
//

class InitialImagePickerState extends ImagePickerState {
  @override
  List<Object> get props => null;
}

class PickerImagePickerState extends ImagePickerState {
  final File image;

  PickerImagePickerState(this.image);

  @override
  List<Object> get props => [image];
}

class GalleryImagePickerState extends PickerImagePickerState {
  GalleryImagePickerState(File image) : super(image);

  @override
  List<Object> get props => [image];
}

class CameraImagePickerState extends PickerImagePickerState {
  CameraImagePickerState(image) : super(image);

  @override
  List<Object> get props => [image];
}

class FailedImagePickerEvent extends ImagePickerState {
  final String error;

  FailedImagePickerEvent(this.error);

  @override
  List<Object> get props => [error];
}

// EVENT
//

class GalleryImagePickerEvent extends ImagePickerEvent {
  @override
  List<Object> get props => null;
}

class CameraImagePickerEvent extends ImagePickerEvent {
  @override
  List<Object> get props => null;
}
