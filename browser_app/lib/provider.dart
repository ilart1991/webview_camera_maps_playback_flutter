import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';

class TitleProvider with ChangeNotifier {
  bool canGoBackBool = false;
  bool canGoForwardBool = false;
  bool isLoading = false;

  loadingPage() {
    isLoading = true;
    notifyListeners();
  }

  loadedPage() {
    isLoading = false;
    notifyListeners();
  }

  canGoBack() {
    controller.canGoBack().then((value) {
      print("go back - " + value.toString());
      return canGoBackBool = value;
    });
    notifyListeners();
    return canGoBackBool;
  }

  canGoForward() {
    controller.canGoForward().then((value) {
      print("go back - " + value.toString());
      return canGoForwardBool = value;
    });
    notifyListeners();
    return canGoForwardBool;
  }

  goBack() {
    controller.goBack();
    canGoBack();
    canGoForward();
  }

  goForward() {
    controller.goForward();
    canGoForward();
    canGoBack();
  }
}
