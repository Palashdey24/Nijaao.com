import 'package:flutter/material.dart';
import 'package:nijaao_web/theme/app_theme.dart';
import 'package:nijaao_web/utils/responsive.dart';
import 'package:nijaao_web/widgets/app_footer.dart';
import 'package:nijaao_web/widgets/app_header.dart';
import 'package:nijaao_web/widgets/construction_hero.dart';
import 'package:nijaao_web/widgets/contact_dialog.dart';
import 'package:nijaao_web/widgets/interactive_action_card.dart';
import 'package:nijaao_web/widgets/location_card.dart';
import 'package:nijaao_web/widgets/notification_dialog.dart';
import 'package:nijaao_web/widgets/product_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  void _showProductPreview(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const ProductDialog(),
    );
  }

  void _showNotificationSignUp(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const NotificationDialog(),
    );
  }

  void _showContactForm(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const ContactDialog(),
    );
  }

  Future<void> _launchFacebook() async {
    final Uri facebookUrl = Uri.parse('https://www.facebook.com/Nijaao');
    if (!await launchUrl(facebookUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Facebook link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final double horizontalPadding = isMobile ? 16 : 40;

    return Scaffold(
      appBar: AppHeader(
        onExploreProducts: () => _showProductPreview(context),
        onGetNotified: () => _showNotificationSignUp(context),
        onSendMessage: () => _showContactForm(context),
        onFollowUs: _launchFacebook,
      ),
      endDrawer: isMobile ? _buildMobileDrawer(context) : null,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. Hero / Under Construction Section
            const ConstructionHero(),
            const SizedBox(height: 40),

            // 2. Interactive Experience Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'While We Build, You Can...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.darkGreen,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Get involved and explore what Nijaao is cooking up for the near future.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppTheme.textGrey),
                  ),
                  const SizedBox(height: 40),

                  // Responsive Action Grid Layout
                  isMobile
                      ? Column(children: _buildActionCards(context))
                      : GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: Responsive.isTablet(context) ? 2 : 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: Responsive.isTablet(context)
                              ? 1.5
                              : 0.95,
                          children: _buildActionCards(context),
                        ),
                ],
              ),
            ),

            const SizedBox(height: 80),

            // 3. Shop Location Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              constraints: const BoxConstraints(maxWidth: 1200),
              child: const LocationCard(),
            ),

            const SizedBox(height: 100),

            // 4. Footer Section
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActionCards(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final cardPadding = isMobile
        ? const EdgeInsets.only(bottom: 16)
        : EdgeInsets.zero;

    return [
      Padding(
        padding: cardPadding,
        child: InteractiveActionCard(
          icon: Icons.shopping_bag_outlined,
          title: 'EXPLORE PRODUCTS',
          subtitle: 'See what’s coming',
          onTap: () => _showProductPreview(context),
        ),
      ),
      Padding(
        padding: cardPadding,
        child: InteractiveActionCard(
          icon: Icons.notifications_none_rounded,
          title: 'GET NOTIFIED',
          subtitle: 'Be the first to know',
          onTap: () => _showNotificationSignUp(context),
        ),
      ),
      Padding(
        padding: cardPadding,
        child: InteractiveActionCard(
          icon: Icons.chat_bubble_outline_rounded,
          title: 'SEND A MESSAGE',
          subtitle: 'Have a question?',
          onTap: () => _showContactForm(context),
        ),
      ),
      Padding(
        padding: cardPadding,
        child: InteractiveActionCard(
          icon: Icons.facebook_rounded,
          title: 'FOLLOW US',
          subtitle: 'Updates, products & offers',
          onTap: _launchFacebook,
        ),
      ),
    ];
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.backgroundIvory,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logo/logo.png',
                    height: 40,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppTheme.darkGreen),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _buildDrawerItem(
                icon: Icons.home_outlined,
                label: 'Home',
                onTap: () => Navigator.of(context).pop(),
              ),
              _buildDrawerItem(
                icon: Icons.shopping_bag_outlined,
                label: 'Explore Products',
                onTap: () {
                  Navigator.of(context).pop();
                  _showProductPreview(context);
                },
              ),
              _buildDrawerItem(
                icon: Icons.notifications_none_rounded,
                label: 'Get Notified',
                onTap: () {
                  Navigator.of(context).pop();
                  _showNotificationSignUp(context);
                },
              ),
              _buildDrawerItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Send Message',
                onTap: () {
                  Navigator.of(context).pop();
                  _showContactForm(context);
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _launchFacebook();
                  },
                  icon: const Icon(Icons.facebook),
                  label: const Text('Follow on Facebook'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.darkGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.darkGreen, size: 22),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
