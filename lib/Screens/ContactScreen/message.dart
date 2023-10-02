import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String authToken = "bWFsZWVzaGFAZ21haWwuY29tOm1hbGVlc2hhMTIz";
  String authzToken = "your-authorization-token-here";

  void _sendSMS(String message, List<String> recipients) async {
    // Here include the authToken and authzToken in your SMS API request.
    print("Auth token: $authToken");
    print("Authz token: $authzToken");
    try {
      String _result = await sendSMS(message: message, recipients: recipients);
      print(_result);
    } catch (error) {
      print(error.toString());
    }
  }

  void _sendEmail(String subject, String body) async {
    // Here include the authToken and authzToken in your email API request.
    print("Auth token: $authToken");
    print("Authz token: $authzToken");
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'client@example.com', // Replace with the client's email
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    try {
      await launch(_emailLaunchUri.toString());
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Messaging App with Auth and Authz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Client Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Service Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String clientName = nameController.text;
                String serviceDescription = descriptionController.text;

                String smsMessage = 'Hello $clientName! Service needed: $serviceDescription';
                String emailSubject = 'Service Request from $clientName';
                String emailBody = 'Client: $clientName\nDescription: $serviceDescription';

                _sendSMS(smsMessage, ['1234567890']);
                _sendEmail(emailSubject, emailBody);
              },
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
