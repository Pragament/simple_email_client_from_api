import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pragament_mail/data/logic/emails_provider.dart';
import 'package:pragament_mail/presentation/widgets/email_viewer.dart';

class EmailViewerPage extends ConsumerWidget {
  const EmailViewerPage({super.key, required this.emailId});

  final String emailId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email =
        ref.read(emailsNotifierProvider.notifier).getEmailById(emailId);

    return Scaffold(
      appBar: AppBar(
        title: Text(email.fromName.isEmpty ? email.fromEmail : email.fromName),
      ),
      body: EmailViewer(emailId: emailId),
    );
  }
}
