// google_sign_in_button.dart
export 'stub.dart'
    if (dart.library.html) 'web.dart'
    if (dart.library.io) 'mobile.dart';
