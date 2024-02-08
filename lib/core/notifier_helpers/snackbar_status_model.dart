import 'package:flutter/foundation.dart';

class SnackbarStatusModel extends ChangeNotifier
    implements ValueListenable<SnackbarMessage?> {
  SnackbarMessage? _message;

  void postError(String message) {
    post(SnackbarMessage(SnackbarMessageType.error, message));
  }

  void postInfo(String message) {
    post(SnackbarMessage(SnackbarMessageType.info, message));
  }

  void post(SnackbarMessage message) {
    _message = message;
    notifyListeners();
  }

  void reset() {
    _message = null;
    notifyListeners();
  }

  @override
  SnackbarMessage? get value => _message;
}

enum SnackbarMessageType { error, info }

class SnackbarMessage {
  final SnackbarMessageType type;
  final String message;

  SnackbarMessage(this.type, this.message);
}
