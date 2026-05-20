import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/features/ai_assistant/controller/ai_chat_controller.dart';
import 'package:tawjihi_new/features/auth/controller/auth_controller.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../widgets/chat_bubble.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  late final AIChatController controller;
  bool _contextSent = false;

  @override
  void initState() {
    super.initState();
    // Using a unique tag or ensuring clean state on each entry
    controller = Get.put(AIChatController());
  }

  @override
  void dispose() {
    // Force delete controller when screen is disposed to clean up scroll controllers
    Get.delete<AIChatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    // Initialize welcome message
    controller.initChat(l10n.ai_welcome_msg);

    // Check if we received context (e.g. from Major Details)
    final String? initialContext = Get.arguments as String?;
    if (initialContext != null && !_contextSent) {
      _contextSent = true;
      // Automatically send a trigger if context is provided
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.sendMessage(context: initialContext);
      });
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          l10n.ai_assistant_title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            final authController = AuthController.to;
            final isDark = authController.isDarkMode.value;
            final locale = authController.currentLocale.value;

            return PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onSelected: (value) {
                if (value == 'theme') authController.toggleTheme();
                if (value == 'lang') authController.toggleLanguage();
                if (value == 'clear') {
                  _showClearDialog(context, controller, l10n);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'theme',
                  child: Row(
                    children: [
                      Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode, 
                        size: 20,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      const SizedBox(width: 12),
                      Text(isDark ? l10n.theme_light : l10n.theme_dark),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'lang',
                  child: Row(
                    children: [
                      Icon(
                        Icons.language, 
                        size: 20,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      const SizedBox(width: 12),
                      Text(locale == 'ar' ? 'English' : 'عربي'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'clear',
                  child: Row(
                    children: [
                      const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                      const SizedBox(width: 12),
                      Text(
                        l10n.ai_clear_chat,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                controller: controller.scrollController,
                itemCount: controller.messages.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  final message = controller.messages[controller.messages.length - 1 - index];
                  return ChatBubble(message: message);
                },
              ),
            ),
          ),

          Obx(
            () =>
                controller.isLoading.value
                    ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitThreeBounce(
                            color: AppColors.primaryLight,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.ai_thinking,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox.shrink(),
          ),

          _buildInputArea(context, controller, theme, l10n),
        ],
      ),
    );
  }

  Widget _buildInputArea(
    BuildContext context,
    AIChatController controller,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: TextField(
                  controller: controller.textController,
                  decoration: InputDecoration(
                    hintText: l10n.ai_hint_text,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: (_) => controller.sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              backgroundColor: AppColors.primaryLight,
              radius: 24,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () => controller.sendMessage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearDialog(
    BuildContext context,
    AIChatController controller,
    AppLocalizations l10n,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text(l10n.ai_clear_chat),
        content: Text(l10n.ai_clear_chat_desc),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () {
              controller.clearChat(l10n.ai_welcome_msg);
              Get.back();
            },
            child: Text(
              l10n.ai_clear_chat.split('?').first,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
