import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();
  final _repository = Repository();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _repository.loadData();
    _firstNameController.text = _repository.firstName;
    _lastNameController.text = _repository.lastName;
    _phoneNumberController.text = _repository.phoneNumber;
    _emailController.text = _repository.email;
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }

  Future<void> _saveData() async {
    _repository.firstName = _firstNameController.text;
    _repository.lastName = _lastNameController.text;
    _repository.phoneNumber = _phoneNumberController.text;
    _repository.email = _emailController.text;
    await _repository.saveData();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('URL is not supported on this device $url'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton.icon(
                  onPressed: () {
                    _launchURL('tel:${_phoneNumberController.text}');
                  },
                  icon: const Icon(Icons.call),
                  label: const Text('Call'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton.icon(
                  onPressed: () {
                    _launchURL('sms:${_phoneNumberController.text}');
                  },
                  icon: const Icon(Icons.message),
                  label: const Text('SMS'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton.icon(
                  onPressed: () {
                    _launchURL('mailto:${_emailController.text}');
                  },
                  icon: const Icon(Icons.mail),
                  label: const Text('Mail'),
                ),
              ],
            ),
            if (username != null) ...[
              const SizedBox(height: 16.0),
              Text('Welcome back, $username!'),
            ],
          ],
        ),
      ),
    );
  }
}