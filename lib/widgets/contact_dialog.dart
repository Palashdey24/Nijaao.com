import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nijaao_web/theme/app_theme.dart';

class ContactDialog extends StatefulWidget {
  const ContactDialog({super.key});

  @override
  State<ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => Scaffold(
        body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Center(
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppTheme.backgroundIvory,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: AppTheme.darkGreen.withOpacity(0.1)),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isSubmitted ? _buildSuccessState() : _buildFormState(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormState() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppTheme.darkGreen,
                  size: 32,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppTheme.textGrey,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Send a Message',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppTheme.darkGreen,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Have a question? Drop us a line and we will get back to you.',
              style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
            ),
            const SizedBox(height: 28),
            _buildLabel('Full Name'),
            TextFormField(
              controller: _nameController,
              decoration: _buildInputDecoration(
                'Your Name',
                Icons.person_outline,
              ),
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Please enter your name'
                  : null,
            ),
            const SizedBox(height: 20),
            _buildLabel('Email or Phone Number'),
            TextFormField(
              controller: _contactController,
              decoration: _buildInputDecoration(
                'yourname@example.com / +8801...',
                Icons.alternate_email,
              ),
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Please enter contact information'
                  : null,
            ),
            const SizedBox(height: 20),
            _buildLabel('Your Message'),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: _buildInputDecoration(
                'How can we help you?',
                Icons.message_outlined,
              ),
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Please enter your message'
                  : null,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.darkGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Send Message',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppTheme.darkGreen,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: Icon(icon, color: AppTheme.darkGreen, size: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppTheme.darkGreen.withOpacity(0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppTheme.darkGreen.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.darkGreen, width: 2),
      ),
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.naturalGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.done_all_rounded,
            color: AppTheme.naturalGreen,
            size: 48,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Message Sent Successfully!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkGreen,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Thank you for reaching out. Our support team will connect with you via email or phone shortly.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: AppTheme.textGrey, height: 1.4),
        ),
        const SizedBox(height: 32),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Close',
            style: TextStyle(
              color: AppTheme.darkGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
