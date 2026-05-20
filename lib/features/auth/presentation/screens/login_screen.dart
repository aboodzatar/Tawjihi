import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tawjihi_new/core/utils/constants.dart';
import 'package:tawjihi_new/features/auth/controller/auth_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/theme_lang_switcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _studentNumberController =
      TextEditingController();

  @override
  void dispose() {
    _studentNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authController = AuthController.to;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ThemeLangSwitcher(),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.padding),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/logo-removebg-preview.png',
                      height: 120,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.login_title,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.black87
                                : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 48),
                    CustomTextField(
                      controller: _studentNumberController,
                      label: l10n.enter_student_number,
                      prefixIcon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => ElevatedButton(
                        onPressed:
                            authController.isLoading.value
                                ? null
                                : () => authController.login(
                                  _studentNumberController.text,
                                ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                        ),
                        child:
                            authController.isLoading.value
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
                                  l10n.next,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
