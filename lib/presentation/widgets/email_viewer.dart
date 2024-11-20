import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pragament_mail/data/logic/emails_provider.dart';
import 'package:pragament_mail/utils/html_util.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class EmailViewer extends ConsumerStatefulWidget {
  const EmailViewer({super.key, required this.emailId});

  final String emailId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailViewerState();
}

class _EmailViewerState extends ConsumerState<EmailViewer> {
  PlatformWebViewController? controller;

  @override
  void initState() {
    loadEmail();
    super.initState();
  }

  loadEmail() async {
    final email =
        ref.read(emailsProvider.notifier).getEmailById(widget.emailId);
    controller =
        PlatformWebViewController(PlatformWebViewControllerCreationParams())
          ..loadHtmlString(HtmlWrapper.wrapFromContent(email.body));

    await Future.delayed(Durations.long1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return controller != null
        ? PlatformWebViewWidget(
                PlatformWebViewWidgetCreationParams(controller: controller!))
            .build(context)
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
