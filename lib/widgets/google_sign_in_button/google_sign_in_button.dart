// google_sign_in_button.dart
export 'stub.dart' // Defaults to stub if no condition matches
    if (dart.library.html) 'web.dart'      // Web platform
    if (dart.library.io) 'mobile.dart';    // Mobile platforms (like Android, iOS)
