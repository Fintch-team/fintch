import 'dart:async';
import 'dart:io';

import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final ArgumentBundle? bundle;

  const PaymentPage({Key? key, this.bundle}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String redirectUrl = '';

  @override
  void initState() {
    super.initState();
    Helper.setLightAppBar();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    if (widget.bundle != null) {
      redirectUrl = widget.bundle!.extras['redirectUrl'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment Top Up',
            style: AppTheme.text1.white.bold,
            textAlign: TextAlign.start,
          ),
          centerTitle: false,
          actions: <Widget>[
            NavigationControls(_controller.future),
          ],
          backgroundColor: AppTheme.webViewPurple,
        ),
        body: redirectUrl.isNotEmpty ? _buildWeb(redirectUrl) : _buildBody());
  }

  Widget _buildBody() {
    return BlocConsumer<PayBloc, PayState>(
      listener: (context, state) {
        if (state is PayFailure) {
          Helper.snackBar(context, message: state.message, isFailure: true);
        }
      },
      builder: (context, state) {
        if (state is PayTopUpSuccess) {
          return _buildWeb(state.entity.webUrl);
        } else if (state is PayLoading) {
          return Center(
            child: CircularLoading(),
          );
        } else if (state is PayFailure) {
          return Center(
            child: Text(
              state.message,
              style: AppTheme.headline3.white,
              textAlign: TextAlign.center,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildWeb(String url) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onProgress: (int progress) {
        print("WebView is loading (progress : %)");
      },
      javascriptChannels: <JavascriptChannel>{
        _toasterJavascriptChannel(context),
      },
      navigationDelegate: (NavigationRequest request) {
        print(request.url);
        if (request.url.startsWith('http://fintch.id/api/payment')) {
          print('blocking navigation to }');
          context.read<HomeBloc>().add(HomeInit());
          int count = 0;
          Navigator.popUntil(context, (route) {
            return count++ == 2;
          });
          return NavigationDecision.prevent;
        }
        print('allowing navigation to ');
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        print('Page started loading: ');
      },
      onPageFinished: (String url) {
        print('Page finished loading: ');
      },
      gestureNavigationEnabled: true,
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Helper.snackBar(context, message: message.message);
        });
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoBack()) {
                        await controller.goBack();
                      } else {
                        // ignore: deprecated_member_use
                        Helper.snackBar(context,
                            message: 'No Back History Item');
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoForward()) {
                        await controller.goForward();
                      } else {
                        // ignore: deprecated_member_use
                        Helper.snackBar(context,
                            message: 'No Forward History Item');
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller!.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
