import 'package:flutter/material.dart';
import 'package:nijaao_web/theme/app_theme.dart';
import 'package:nijaao_web/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  Future<void> _launchFacebook() async {
    final Uri facebookUrl = Uri.parse('https://www.facebook.com/Nijaao');
    if (!await launchUrl(facebookUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Facebook link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppTheme.darkGreen.withOpacity(0.04),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Responsive(
                mobile: Column(
                  children: [
                    _buildLogoSection(),
                    const SizedBox(height: 32),
                    _buildSocialLinks(),
                  ],
                ),
                desktop: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildLogoSection(), _buildSocialLinks()],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Divider(color: Color(0xFFEEEEEE)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© ${DateTime.now().year} Nijaao. All rights reserved.',
                    style: const TextStyle(
                      color: AppTheme.textGrey,
                      fontSize: 13,
                    ),
                  ),
                  const Text(
                    'See You Soon!',
                    style: TextStyle(
                      color: AppTheme.darkGreen,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo/logo.png',
          height: 44,
          errorBuilder: (context, error, stackTrace) => const SizedBox(),
        ),
        const SizedBox(height: 8),
        const Text(
          'NIJAAO',
          style: TextStyle(
            color: AppTheme.darkGreen,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'QUALITY PRODUCTS FOR A BETTER TOMORROW',
          style: TextStyle(
            color: AppTheme.textGrey,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return InkWell(
      onTap: _launchFacebook,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.darkGreen.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.facebook, color: AppTheme.darkGreen, size: 20),
            const SizedBox(width: 10),
            const Text(
              'Follow us on Facebook',
              style: TextStyle(
                color: AppTheme.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
