import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pragament_mail/data/logic/auth_provider.dart';
import 'package:pragament_mail/data/logic/emails_provider.dart';
import 'package:pragament_mail/presentation/routes/routes.dart';
import 'package:pragament_mail/presentation/widgets/my_snackbar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(emailsProvider.notifier).load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final emails = ref.watch(emailsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async =>
              await ref.read(userNotifierProvider.notifier).logout(),
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
        ),
        title: const Text('Pragament Mail'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async =>
                await ref.read(emailsProvider.notifier).load().whenComplete(
                      () => showSnackBar(message: 'Sync successful'),
                    ),
            icon: const Icon(Icons.sync),
            tooltip: 'Sync',
          ),
        ],
      ),
      body: emails != null
          ? emails.isNotEmpty
              ? ListView.builder(
                  itemCount: emails.length,
                  itemBuilder: (context, index) {
                    final email = emails.elementAt(index);
                    return Column(
                      children: [
                        if (index == 0 ||
                            email.datetime.day !=
                                emails[index - 1].datetime.day)
                          Center(
                            child: Card.outlined(
                              margin: const EdgeInsets.only(top: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(email.datetime),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        // Email card
                        Card(
                          elevation: 0,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () => EmailViewerPageRoute(emailId: email.id)
                                .push(context),
                            child: ListTile(
                              title: Text(
                                email.fromEmail,
                                style: TextStyle(color: color.primary),
                              ),
                              subtitle: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: email.subject,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const TextSpan(text: '\n\n'),
                                    TextSpan(text: email.snippet),
                                    const TextSpan(text: '\n'),
                                    TextSpan(
                                      text: DateFormat('HH:mm a (EEEE)')
                                          .format(email.datetime),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ),
                        if (index == emails.length - 1)
                          OutlinedButton(
                            onPressed: () async {
                              showSnackBar(message: 'Syncing');
                              // await ref
                              //     .read(emailsProvider.notifier)
                              //     .load(getNextEmails: true);
                              showSnackBar(message: 'Sync successful');
                            },
                            child: const Text('Load more'),
                          ),
                      ],
                    );
                  },
                )
              : const Center(child: Text('No Emails found'))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
