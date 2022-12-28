import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/provider.dart';
import '../pages/my_home_page.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          IconButton(
              color: context.watch<TitleProvider>().canGoBackBool
                  ? Colors.black
                  : Colors.black12,
              onPressed: () {
                if (Provider.of<TitleProvider>(context, listen: false)
                    .canGoBackBool) {
                  context.read<TitleProvider>().goBack();
                }
              },
              icon: const Icon(Icons.arrow_back)),
          IconButton(
              color: context.watch<TitleProvider>().canGoForwardBool
                  ? Colors.black
                  : Colors.black12,
              onPressed: () {
                if (Provider.of<TitleProvider>(context, listen: false)
                    .canGoForwardBool) {
                  context.read<TitleProvider>().goForward();
                }
              },
              icon: const Icon(Icons.arrow_forward)),
          IconButton(
              color: Colors.black,
              onPressed: () {
                if (!Provider.of<TitleProvider>(context, listen: false)
                    .isLoading) {
                  controller.reload();
                } else {
                  controller.loadHtmlString("about:blank");
                }
              },
              icon: Icon(!context.watch<TitleProvider>().isLoading
                  ? Icons.refresh
                  : Icons.cancel)),
          Expanded(
            flex: 2,
            child: TextField(
              controller: urlController,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 8),
                suffixIcon: IconButton(
                    color: Colors.black,
                    onPressed: () {
                      context.read<TitleProvider>().loadingPage();
                      controller.loadRequest(
                          Uri.parse("https://${urlController.text}"));

                      controller.setNavigationDelegate(
                        NavigationDelegate(
                          onPageFinished: (String url) {
                            context.read<TitleProvider>().canGoBack();
                            context.read<TitleProvider>().loadedPage();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_upward)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                hintText: 'Введите адрес',
              ),
            ),
          )
        ],
      ),
    );
  }
}
