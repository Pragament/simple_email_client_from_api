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
    ref.read(emailsNotifierProvider.notifier).load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final emails = ref.watch(emailsNotifierProvider);

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
            onPressed: () async => await ref
                .read(emailsNotifierProvider.notifier)
                .load()
                .whenComplete(
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

                    return Card(
                      elevation: 0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => EmailViewerPageRoute(emailId: email.id)
                            .push(context),
                        child: ListTile(
                          title: Text(email.fromName),
                          subtitle: Text(email.subject),
                          isThreeLine: true,
                          trailing: Text(DateFormat('HH:mma EEE, dd-MM-yyyy')
                              .format(email.datetime)),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No Emails found'))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
