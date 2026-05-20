import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/ai_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/core/utils/shared_prefs_helper.dart';
import 'package:tawjihi_new/features/auth/controller/auth_controller.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text, 
    required this.isUser, 
    required this.timestamp
  });

  Map<String, dynamic> toJson() => {
    'text': text,
    'isUser': isUser,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    text: json['text'],
    isUser: json['isUser'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}

class AIChatController extends GetxController {
  final AIService _aiService = AIService();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;

  String get _storageKey {
    final studentId = AuthController.to.currentStudent.value?.id ?? 'guest';
    return "ai_chat_$studentId";
  }

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();
  }

  void _loadChatHistory() {
    final historyStr = SharedPrefsHelper.instance.getString(_storageKey);
    if (historyStr != null) {
      final List<dynamic> decoded = jsonDecode(historyStr);
      messages.value = decoded.map((m) => ChatMessage.fromJson(m)).toList();
      scrollToBottom(immediate: true);
    }
  }

  void _saveChatHistory() {
    final historyStr = jsonEncode(messages.map((m) => m.toJson()).toList());
    SharedPrefsHelper.instance.setString(_storageKey, historyStr);
  }

  void initChat(String welcomeMsg) {
    if (messages.isEmpty) {
      messages.add(ChatMessage(
        text: welcomeMsg,
        isUser: false,
        timestamp: DateTime.now(),
      ));
      _saveChatHistory();
    }
    scrollToBottom(immediate: true);
  }

  void clearChat(String welcomeMsg) {
    messages.clear();
    _aiService.resetChat();
    messages.add(ChatMessage(
      text: welcomeMsg,
      isUser: false,
      timestamp: DateTime.now(),
    ));
    _saveChatHistory();
  }

  Future<void> sendMessage({String? context}) async {
    final text = textController.text.trim();
    if (text.isEmpty && context == null) return;

    if (text.isNotEmpty) {
      messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      textController.clear();
    } else if (context != null) {
      messages.add(ChatMessage(
        text: context!,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    }

    _saveChatHistory();

    isLoading.value = true;
    scrollToBottom();

    final response = await _aiService.sendMessage(
      text.isEmpty && context != null ? context! : text, 
      extraContext: context
    );
    final l10n = AppLocalizations.of(Get.context!)!;

    if (response == "BUSY_ERROR") {
      messages.add(ChatMessage(
        text: l10n.ai_busy_message,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } else if (response == "GENERAL_ERROR") {
      messages.add(ChatMessage(
        text: l10n.error_message,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } else if (response != null) {
      messages.add(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    }

    _saveChatHistory();
    isLoading.value = false;
    scrollToBottom();
  }

  void scrollToBottom({bool immediate = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        if (immediate) {
          scrollController.jumpTo(0.0);
        } else {
          scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
