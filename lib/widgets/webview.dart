import 'dart:core';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoficash/styles/styles.dart';

// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  static const String route = "/webview";

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;
  var loadingPercentage = 0;

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        allowsInlineMediaPlayback: true,
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {
            context.pop();
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://www.zoficash.com/terms"));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
        actions: [
          IconButton(
            onPressed: () {
              _controller.reload();
            },
            icon: const Icon(Icons.replay_rounded),
          ),
        ],
      ),
      body: loadingPercentage < 100
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.blue,
                strokeWidth: 2,
              ),
            )
          : WebViewWidget(controller: _controller),
    );
  }
}
