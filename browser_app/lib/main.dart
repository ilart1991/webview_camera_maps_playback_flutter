import 'package:browser_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
    ),
  )
  ..loadRequest(Uri.parse('https://flutter.dev'));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TitleProvider>(
      create: (_) => TitleProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            SizedBox(
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
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1),
                        ),
                        hintText: 'Введите адрес',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: WebViewWidget(controller: controller)),
          ],
        ));
  }
}
