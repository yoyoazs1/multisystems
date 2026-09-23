\
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MultisystemsApp());
}

class MultisystemsApp extends StatelessWidget {
  const MultisystemsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multisystems Centrum',
      theme: ThemeData(useMaterial3: true),
      home: const MultisystemsWebApp(),
    );
  }
}

class MultisystemsWebApp extends StatefulWidget {
  const MultisystemsWebApp({super.key});

  @override
  State<MultisystemsWebApp> createState() => _MultisystemsWebAppState();
}

class _MultisystemsWebAppState extends State<MultisystemsWebApp> {
  late final WebViewController controller;
  int progress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF111111))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) => setState(() => progress = value),
          onNavigationRequest: (request) async {
            final uri = Uri.tryParse(request.url);
            if (uri == null) return NavigationDecision.prevent;

            if (uri.scheme == 'file' || uri.scheme == 'about' || uri.scheme == 'data') {
              return NavigationDecision.navigate;
            }

            if (['mailto', 'tel', 'sms', 'http', 'https'].contains(uri.scheme)) {
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadFlutterAsset('assets/MULTISYSTEMS_Centrum_v6_8.html');
  }

  Future<bool> _goBack() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (await _goBack() && mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: controller),
              if (progress < 100)
                LinearProgressIndicator(value: progress / 100),
            ],
          ),
        ),
      ),
    );
  }
}
