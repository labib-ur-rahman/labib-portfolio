import 'web_loader_stub.dart'
    if (dart.library.html) 'web_loader_web.dart'
    as web_loader;

void hideWebLoader() => web_loader.hideWebLoader();
