import 'package:flutter/material.dart';
import 'package:nijaao_web/theme/app_theme.dart';
import 'package:nijaao_web/utils/responsive.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onExploreProducts;
  final VoidCallback onGetNotified;
  final VoidCallback onSendMessage;
  final VoidCallback onFollowUs;

  const AppHeader({
    super.key,
    required this.onExploreProducts,
    required this.onGetNotified,
    required this.onSendMessage,
    required this.onFollowUs,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundIvory.withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.darkGreen.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/logo/logo.png',

                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.darkGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'NIJAAO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 2,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  if (!isMobile)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'NIJAAO',
                          style: TextStyle(
                            color: AppTheme.darkGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'QUALITY PRODUCTS FOR A BETTER TOMORROW',
                          style: TextStyle(
                            color: AppTheme.naturalGreen,
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              if (!isMobile)
                Row(
                  children: [
                    _HeaderButton(
                      label: 'Home',
                      onPressed: () {},
                      isActive: true,
                    ),
                    const SizedBox(width: 16),
                    _HeaderButton(
                      label: 'Explore Products',
                      onPressed: onExploreProducts,
                    ),
                    const SizedBox(width: 16),
                    _HeaderButton(
                      label: 'Visit Shop',
                      onPressed: onSendMessage,
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: onFollowUs,
                      icon: const Icon(Icons.facebook, size: 18),
                      label: const Text('Facebook'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.darkGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppTheme.darkGreen,
                    size: 28,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  const _HeaderButton({
    required this.label,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  State<_HeaderButton> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<_HeaderButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppTheme.darkGreen.withOpacity(0.05)
                : (_isHovered
                      ? AppTheme.darkGreen.withOpacity(0.02)
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isActive || _isHovered
                  ? AppTheme.darkGreen
                  : AppTheme.textGrey,
              fontWeight: widget.isActive || _isHovered
                  ? FontWeight.bold
                  : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
