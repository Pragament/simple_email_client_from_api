import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pragament_mail/data/graphql/graphql_requests.dart';
import 'package:pragament_mail/data/logic/organization_provider.dart';
import 'package:pragament_mail/data/settings.dart';
import 'package:pragament_mail/data/temp.dart';
import 'package:pragament_mail/presentation/widgets/my_snackbar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // Controllers for login/register textfields
  final TextEditingController otpC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController rePasswordC = TextEditingController();

  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(false);
  final isNewUserProvider = StateNotifierProvider<IsValidatedNotifier, bool>((_) =>
      IsValidatedNotifier()); // To create dynamic UI that updates when user switches between login and register
  final isValidatedProvider = StateNotifierProvider<IsValidatedNotifier, bool>(
      (_) => IsValidatedNotifier());

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isNewUser = ref.watch(isNewUserProvider);
    final isValidated = ref.watch(isValidatedProvider);
    final organization = ref.watch(oraganizationNotifierProvider);

    final organizationNotifier =
        ref.read(oraganizationNotifierProvider.notifier);

    // This widget creates rounded container as a backround to it's child
    Widget textFieldContainer({required Widget child}) => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(18.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: child,
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pragament Mail'),
        centerTitle: true,
      ),
      body: Center(
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Image.asset(
                  'assets/logo.png',
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withAlpha(100),
                      borderRadius: BorderRadius.circular(18.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                isValidated
                                    ? isNewUser
                                        ? 'Register'
                                        : 'Login'
                                    : 'Verify',
                                style: theme.textTheme.titleLarge),
                          ),
                          if (!isValidated)
                            textFieldContainer(
                              child: TextFormField(
                                controller: otpC,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'[^0-9]'))
                                ],
                                maxLength: 6,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.pin),
                                  labelText: 'OTP',
                                  hintText: 'Enter your Organization OTP',
                                ),
                              ),
                            ),
                          if (isValidated)
                            textFieldContainer(
                              child: TextFormField(
                                controller: emailC,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[a-zA-Z0-9]+$'))
                                ],
                                validator: (value) =>
                                    // Popular Email validation package
                                    EmailValidator.validate(value != null
                                            ? value +
                                                organization!.emailDomainPart
                                            : '')
                                        ? null
                                        : ' Please enter a valid email',
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: 'Email',
                                  suffixText: organization?.emailDomainPart,
                                ),
                              ),
                            ),
                          if (isValidated)
                            textFieldContainer(
                              child: ValueListenableBuilder(
                                valueListenable: showPassword,
                                builder: (context, isVisible, child) =>
                                    TextFormField(
                                  controller: passwordC,
                                  obscureText: !isVisible,
                                  textInputAction: isValidated
                                      ? TextInputAction.next
                                      : TextInputAction.done,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[a-zA-Z0-9]+$'))
                                  ],
                                  validator: (value) {
                                    // Form validation which shows errors for the user
                                    if (value!.isEmpty || value.length <= 6) {
                                      return 'Minimum 6 charaters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.password),
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          showPassword.value = !isVisible,
                                      icon: Icon(isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (isValidated && isNewUser)
                            textFieldContainer(
                              child: TextFormField(
                                controller: rePasswordC,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty || value.length <= 6) {
                                    return 'Minimum 6 charaters';
                                  } else if (value != passwordC.text) {
                                    return 'Password mismatch';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.password),
                                  labelText: 'Re-enter Password',
                                  hintText: 'Enter the same password again',
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => isLoading = true);
                                  if (isValidated) {
                                    if (isNewUser) {
                                      final acc = await GraphQLRequests('0')
                                          .createAccount(
                                        orgId: organization!.id,
                                        emailLocalPart: emailC.text,
                                        password: passwordC.text,
                                        secondaryEmailId: '0',
                                      );

                                      if (acc != null) {
                                        account = acc;

                                        ref
                                            .read(loginStateNotifierProvider
                                                .notifier)
                                            .saveLoginState(true);
                                      } else {
                                        showSnackBar(
                                            message: 'Something went wrong');
                                      }
                                    } else {
                                      final acc = await GraphQLRequests('0')
                                          .getAccount(
                                              emailC.text, passwordC.text);

                                      if (acc != null) {
                                        account = acc;

                                        ref
                                            .read(loginStateNotifierProvider
                                                .notifier)
                                            .saveLoginState(true);
                                      } else {
                                        showSnackBar(
                                            message:
                                                'Please check your details');
                                      }
                                    }
                                  } else {
                                    final organization =
                                        await GraphQLRequests('0')
                                            .checkOTPValidity(otpC.text);

                                    if (organization != null) {
                                      organizationNotifier.update(organization);

                                      ref
                                          .read(isValidatedProvider.notifier)
                                          .toggle();
                                    } else {
                                      showSnackBar(
                                          message: 'Enter a valid OTP');
                                    }
                                  }

                                  setState(() => isLoading = false);
                                }
                              },
                              child: !isLoading
                                  ? const Text('Submit')
                                  : const SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      )),
                            ),
                          ),
                          if (isValidated)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Are you ${!isNewUser ? 'a new' : 'an existing'} user?'),
                                TextButton(
                                  onPressed: () => ref
                                      .read(isNewUserProvider.notifier)
                                      .toggle(),
                                  child:
                                      Text(!isNewUser ? 'REGISTER' : 'LOGIN'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// To create dynamic UI that updates when user switches between login and register
class IsNewUserNotifier extends StateNotifier<bool> {
  IsNewUserNotifier() : super(false); // Initialize with the default value

  toggle() => state = !state;
}

class IsValidatedNotifier extends StateNotifier<bool> {
  IsValidatedNotifier() : super(false); // Initialize with the default value

  toggle() => state = !state;
}
