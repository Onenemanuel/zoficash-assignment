import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zoficash/blocs/blocs.dart';
import 'package:zoficash/router.dart';
import 'package:zoficash/styles/styles.dart';
import 'package:zoficash/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String route = "/login";

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          switch (state.status) {
            case LoginStatus.progress:
              _onLoginProgress(context);
              break;
            case LoginStatus.success:
              _onLoginSuccess(context, router);
              break;
            case LoginStatus.failure:
              _onLoginFailure(context, state.message);
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Login",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Choose your country code and enter your phone number",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email - Optional",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  TextFormFieldWidget(
                    hintText: "sample@email.com",
                    keyboardType: TextInputType.emailAddress,
                    errorText:
                        state.status.invalid ? state.email.error?.value : null,
                    onChanged: (value) {
                      _onEmailChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone Number",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  TextFormFieldWidget(
                    hintText: "77-XXX-XXX-X",
                    keyboardType: TextInputType.phone,
                    prefixIcon: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        CountryCodePicker(
                          textStyle: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          padding: EdgeInsets.zero,
                          initialSelection: "UG",
                          flagWidth: 24,
                          onChanged: (value) {
                            _onPhoneCodeChanged(context, value.dialCode!);
                          },
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    errorText: state.status.invalid
                        ? state.phoneNumber.error?.value
                        : null,
                    onChanged: (value) {
                      _onPhoneNumberChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  PasswordTextFormFieldWidget(
                    hintText: "******",
                    obscureText: state.passwordVisible,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        state.passwordVisible
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                      onTap: () {
                        _onTogglePassword(context);
                      },
                    ),
                    errorText: state.status.invalid
                        ? state.password.error?.value
                        : null,
                    onChanged: (value) {
                      _onPasswordChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    child: const Center(
                      child: Text("Login"),
                    ),
                    onPressed: () {
                      _onLoginPressed(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  AppRichTextSingle(
                    text: "Don't have an account?  ",
                    actionText: "Register",
                    action: () {
                      _onRegisterPressed(context, router);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onLoginProgress(BuildContext context) {
    LoadingOverlay.of(context).show();
  }

  void _onLoginSuccess(BuildContext context, GoRouter router) {
    LoadingOverlay.of(context).hide();
    // Get AuthBloc instance
    var authBloc = context.read<AuthBloc>();

    // Check if security question is setup
    if (!authBloc.state.authUser.isSecurityQuestionSetup) {
      router.push(SecurityQuestionScreen.route);
    } else {
      router.go(HomeScreen.route);
    }
  }

  void _onLoginFailure(BuildContext context, String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Center(child: Text(message))));
  }

  void _onEmailChanged(BuildContext context, String value) {
    context.read<LoginBloc>().add(LoginEmailChanged(value));
  }

  void _onPhoneCodeChanged(BuildContext context, String value) {
    context.read<LoginBloc>().add(LoginPhoneCodeChanged(value));
  }

  void _onPhoneNumberChanged(BuildContext context, String value) {
    context.read<LoginBloc>().add(LoginPhoneNumberChanged(value));
  }

  void _onTogglePassword(BuildContext context) {
    context.read<LoginBloc>().add(const LoginTogglePassword());
  }

  void _onPasswordChanged(BuildContext context, String value) {
    context.read<LoginBloc>().add(LoginPasswordChanged(value));
  }

  void _onLoginPressed(BuildContext context) {
    context.read<LoginBloc>().add(const LoginSubmitted());
  }

  void _onRegisterPressed(BuildContext context, GoRouter router) {
    router.push(RegisterScreen.route);
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String route = "/register";

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          switch (state.status) {
            case RegisterStatus.progress:
              _onRegisterProgress(context);
              break;
            case RegisterStatus.success:
              _onRegisterSuccess(context, router);
              break;
            case RegisterStatus.failure:
              _onRegisterFailure(context, state.message);
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Register",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Choose your country code and enter your phone number",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email - Optional",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  TextFormFieldWidget(
                    hintText: "sample@email.com",
                    keyboardType: TextInputType.emailAddress,
                    errorText:
                        state.status.invalid ? state.email.error?.value : null,
                    onChanged: (value) {
                      _onEmailChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone Number",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  TextFormFieldWidget(
                    hintText: "77-XXX-XXX-X",
                    keyboardType: TextInputType.phone,
                    prefixIcon: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        CountryCodePicker(
                          textStyle: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          padding: EdgeInsets.zero,
                          initialSelection: "UG",
                          flagWidth: 24,
                          onChanged: (value) {
                            _onPhoneCodeChanged(context, value.dialCode!);
                          },
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    errorText: state.status.invalid
                        ? state.phoneNumber.error?.value
                        : null,
                    onChanged: (value) {
                      _onPhoneNumberChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  PasswordTextFormFieldWidget(
                    hintText: "******",
                    obscureText: state.passwordVisible,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        state.passwordVisible
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                      onTap: () {
                        _onTogglePassword(context);
                      },
                    ),
                    errorText: state.status.invalid
                        ? state.password.error?.value
                        : null,
                    onChanged: (value) {
                      _onPasswordChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Repeat Password",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  PasswordTextFormFieldWidget(
                    hintText: "******",
                    obscureText: state.passwordVisible,
                    errorText: state.status.invalid
                        ? state.repeatPassword.error?.value
                        : null,
                    onChanged: (value) {
                      _onRepeatPasswordChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 30),
                  AppRichTextSingle(
                    text:
                        "By submitting this application you confirm that you are authorized to share this information and agree with our ",
                    actionText: "Terms and Conditions",
                    action: () {
                      _onTermsAndConditionsPressed(context, router);
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    child: const Center(
                      child: Text("Register Account"),
                    ),
                    onPressed: () {
                      _onRegisterPressed(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  AppRichTextSingle(
                    text: "Already have an account?  ",
                    actionText: "Login",
                    action: () {
                      _onLoginPressed(context, router);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onRegisterProgress(BuildContext context) {
    LoadingOverlay.of(context).show();
  }

  void _onRegisterSuccess(BuildContext context, GoRouter router) {
    LoadingOverlay.of(context).hide();
    router.push(VerificationScreen.route);
  }

  void _onRegisterFailure(BuildContext context, String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
  }

  void _onEmailChanged(BuildContext context, String value) {
    context.read<RegisterBloc>().add(RegisterEmailChanged(value));
  }

  void _onPhoneCodeChanged(BuildContext context, String value) {
    context.read<RegisterBloc>().add(RegisterPhoneCodeChanged(value));
  }

  void _onPhoneNumberChanged(BuildContext context, String value) {
    context.read<RegisterBloc>().add(RegisterPhoneNumberChanged(value));
  }

  void _onTogglePassword(BuildContext context) {
    context.read<RegisterBloc>().add(const RegisterTogglePassword());
  }

  void _onPasswordChanged(BuildContext context, String value) {
    context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
  }

  void _onRepeatPasswordChanged(BuildContext context, String value) {
    context.read<RegisterBloc>().add(RegisterRepeatPasswordChanged(value));
  }

  void _onTermsAndConditionsPressed(BuildContext context, GoRouter router) {
    router.push(WebViewScreen.route);
  }

  void _onRegisterPressed(BuildContext context) {
    context.read<RegisterBloc>().add(const RegisterSubmitted());
  }

  void _onLoginPressed(BuildContext context, GoRouter router) {
    router.pop();
  }
}

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  static const String route = "/verification";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var authUser = context.read<AuthBloc>().state.authUser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(authUser.accountVerificationOtp!),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          switch (state.status) {
            case VerificationStatus.progress:
              _onVerificationProgress(context);
              break;
            case VerificationStatus.success:
              _onVerificationSuccess(context);
              break;
            case VerificationStatus.failure:
              _onVerificationFailure(context, state.message);
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Verification",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Verify the handphone number by entering the verification code",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildInputDisplay(
                      textInput: state.code,
                      theme: theme,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Didn't recieve verification code?",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Resend Code",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildInputRow(
                    theme: theme,
                    elements: ["1", "2", "3"],
                    onPressed: (value) {
                      _onCodeChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildInputRow(
                    theme: theme,
                    elements: ["4", "5", "6"],
                    onPressed: (value) {
                      _onCodeChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildInputRow(
                    theme: theme,
                    elements: ["7", "8", "9"],
                    onPressed: (value) {
                      _onCodeChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildInputRow(
                    theme: theme,
                    elements: [
                      Icons.fingerprint,
                      "0",
                      Icons.arrow_back_rounded,
                    ],
                    onPressed: (value) {
                      switch (value) {
                        case Icons.fingerprint:
                          _onFingerprintPressed(context);
                          break;
                        case Icons.arrow_back_rounded:
                          _onDeletePressed(context);
                          break;
                        default:
                          _onCodeChanged(context, value);
                          break;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onVerificationProgress(BuildContext context) {
    LoadingOverlay.of(context).show();
  }

  void _onVerificationSuccess(BuildContext context) {
    LoadingOverlay.of(context).hide();
    context.go(LoginScreen.route);
  }

  void _onVerificationFailure(BuildContext context, String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Center(child: Text(message))));
  }

  List<Widget> _buildInputDisplay({
    required String textInput,
    required ThemeData theme,
  }) {
    List<Widget> widgets = [];

    for (int i = 0; i < 6; i++) {
      var input = i > textInput.length - 1 ? null : textInput[i];

      if (input != null) {
        var widget = Text(
          input,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        );

        widgets.add(widget);
      } else {
        var widget = const Icon(size: 15, Icons.circle);
        widgets.add(widget);
      }

      if (i < 5) widgets.add(const SizedBox(width: 20));
    }

    return widgets;
  }

  Widget _buildInputRow({
    required Function(dynamic) onPressed,
    required List<dynamic> elements,
    required ThemeData theme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: elements.map(
        (element) {
          if (element.runtimeType == IconData) {
            return IconButton(
              iconSize: 30,
              onPressed: () {
                onPressed(element);
              },
              icon: Icon(element, color: AppColors.black),
            );
          }

          return TextButton(
            onPressed: () {
              onPressed(element);
            },
            child: Text(
              element,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  void _onCodeChanged(BuildContext context, String value) {
    context.read<VerificationBloc>().add(VerificationCodeChanged(code: value));
  }

  void _onDeletePressed(BuildContext context) {
    context.read<VerificationBloc>().add(const VerificationDeletePressed());
  }

  void _onFingerprintPressed(BuildContext context) {
    context
        .read<VerificationBloc>()
        .add(const VerificationFingerprintPressed());
  }
}

class SecurityQuestionScreen extends StatelessWidget {
  const SecurityQuestionScreen({super.key});

  static const String route = "/securityQuestion";

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<SecurityQuestionBloc, SecurityQuestionState>(
        listener: (context, state) {
          switch (state.status) {
            case SecurityQuestionStatus.progress:
              _onSecurityQuestionProgress(context);
              break;
            case SecurityQuestionStatus.success:
              _onSecurityQuestionSuccess(context, router);
              break;
            case SecurityQuestionStatus.failure:
              _onSecurityQuestionFailure(context, state.message);
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Setup security question",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Question",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    initialValue: state.question,
                    hintText: "What city were you born?",
                    keyboardType: TextInputType.emailAddress,
                    errorText: (state.question.isEmpty && state.status.invalid)
                        ? "Required"
                        : null,
                    onChanged: (value) {
                      _onQuestionChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Answer",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  TextFormFieldWidget(
                    hintText: "Your answer here",
                    keyboardType: TextInputType.emailAddress,
                    errorText: (state.answer.isEmpty && state.status.invalid)
                        ? "Required"
                        : null,
                    onChanged: (value) {
                      _onAnswerChanged(context, value);
                    },
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    child: const Center(
                      child: Text("Continue"),
                    ),
                    onPressed: () {
                      _onContinuePressed(context);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSecurityQuestionProgress(BuildContext context) {
    LoadingOverlay.of(context).show();
  }

  void _onSecurityQuestionSuccess(BuildContext context, GoRouter router) {
    LoadingOverlay.of(context).hide();
    router.go(HomeScreen.route);
  }

  void _onSecurityQuestionFailure(BuildContext context, String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Center(child: Text(message))));
  }

  void _onQuestionChanged(BuildContext context, String value) {
    context
        .read<SecurityQuestionBloc>()
        .add(SecurityQuestionChanged(question: value));
  }

  void _onAnswerChanged(BuildContext context, String value) {
    context
        .read<SecurityQuestionBloc>()
        .add(SecurityAnswerChanged(answer: value));
  }

  void _onContinuePressed(BuildContext context) {
    context.read<SecurityQuestionBloc>().add(const SecurityQuestionSubmitted());
  }
}
