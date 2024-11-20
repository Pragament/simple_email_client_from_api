import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pragament_mail/data/logic/emails_provider.dart';
import 'package:pragament_mail/presentation/widgets/email_viewer.dart';
import 'package:pragament_mail/utils/debug_print.dart';

class EmailViewerPage extends ConsumerWidget {
  const EmailViewerPage({super.key, required this.emailId});

  final String emailId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    final email = ref.read(emailsProvider.notifier).getEmailById(emailId);

    printInDebug(email.isHtml);

    return Scaffold(
      appBar: AppBar(
        title: Text(email.fromName.isEmpty ? email.fromEmail : email.fromName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sender:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(email.fromEmail),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Subject:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(email.subject),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Body:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                email.isHtml
                    ? SizedBox(
                        height: size.height / 1.6,
                        child: EmailViewer(emailId: emailId))
                    : Text(email.body),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
