import 'package:flutter/material.dart';

import '../presentation/pages/my_home_page.dart';

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
