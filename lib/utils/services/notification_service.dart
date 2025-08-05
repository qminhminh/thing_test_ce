// Firebase is disabled for now - stub implementation
import 'dart:async';
import 'dart:convert';

import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/modules/notification/notification_model.dart';
import 'package:thingsboard_app/utils/services/_tb_secure_storage.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

// Stub for background handler
@pragma('vm:entry-point')
Future<void> backgroundHandler(Map<String, dynamic> message) async {
  // Firebase is disabled
}

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  static final notificationsNumberStream = StreamController<int>.broadcast();

  static const notificationCounterKey = 'notifications_counter';
  static const notificationsListKey = 'notifications_list';

  NotificationService._();

  factory NotificationService() => _instance;

  Future<void> init(
    ThingsboardClient tbClient,
    TbLogger log,
    TbContext context,
  ) async {
    // Firebase is disabled
  }

  Future<void> logout() async {
    // Firebase is disabled
  }

  static void handleClickOnNotification(
    Map<String, dynamic> data,
    TbContext tbContext,
  ) {
    // Firebase is disabled
  }

  static Future<void> increaseNotificationBadgeCount() async {
    // Firebase is disabled
  }

  static Future<void> decreaseNotificationBadgeCount(int id) async {
    // Firebase is disabled
  }

  static Future<void> clearNotificationBadgeCount() async {
    // Firebase is disabled
  }

  static Future<void> saveNotification(Map<String, dynamic> message) async {
    // Firebase is disabled
  }

  static Future<void> triggerNotificationCountStream() async {
    // Firebase is disabled
    notificationsNumberStream.add(0);
  }
} 