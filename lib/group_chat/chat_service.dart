import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  // استبدل هذه القيم بالقيم الفعلية الخاصة بك
  final String oneSignalAppId = 'f7374124-82e0-4ce3-89ea-8774e8674fc8';
  final String restApiKey = 'ZGQ4MjZhZTMtNDQ4NS00MDFkLWJiYWEtYTUwOGVjODhmOTk4';

  Future<void> sendNotification(String message, String senderId) async {
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization':
      'Basic $restApiKey', // أدخل مفتاح REST API الخاص بك من OneSignal
    };

    var body = jsonEncode({
      "app_id": oneSignalAppId, // استخدم معرف التطبيق الخاص بك
      "included_segments": ["All"],
      "contents": {"en": message},
      "headings": {"en": "New Message"},
      "data": {"senderId": senderId}, // إرسال معرف المرسل مع البيانات
    });

    var response = await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
    }
  }
}