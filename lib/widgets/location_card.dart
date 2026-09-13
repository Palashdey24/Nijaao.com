import 'package:flutter/material.dart';
import 'package:nijaao_web/theme/app_theme.dart';
import 'package:nijaao_web/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  Future<void> _launchMapsUrl() async {
    final Uri googleMapsUrl = Uri.parse(
      'https://maps.app.goo.gl/Qip1PCxvjaxfc1BT6',
    );
    if (!await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch maps URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppTheme.darkGreen.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkGreen.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Responsive(
        mobile: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIconAndTitle(),
            const SizedBox(height: 16),
            _buildAddressText(),
            const SizedBox(height: 24),
            _buildDirectionsButton(),
          ],
        ),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIconAndTitle(),
                  const SizedBox(height: 12),
                  _buildAddressText(),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(flex: 3, child: _buildDirectionsButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildIconAndTitle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.darkGreen.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.location_on_rounded,
            color: AppTheme.darkGreen,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        const Text(
          'OUR SHOP LOCATION',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            color: AppTheme.darkGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'দোকান নম্বরঃ ০৩,\nঅনন্তরণপ্রভা মার্কেট,\nকমল মুন্সিরহাট,\nচক্রশালা, পটিয়া',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textBlack,
            height: 1.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Patiya, Chattagong, Bangladesh',
          style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
        ),
      ],
    );
  }

  Widget _buildDirectionsButton() {
    return ElevatedButton.icon(
      onPressed: _launchMapsUrl,
      icon: const Icon(Icons.directions_rounded),
      label: const Text('GET DIRECTIONS'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.darkGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
