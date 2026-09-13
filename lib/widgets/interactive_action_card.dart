import 'package:flutter/material.dart';
import 'package:nijaao_web/theme/app_theme.dart';

class InteractiveActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const InteractiveActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<InteractiveActionCard> createState() => _InteractiveActionCardState();
}

class _InteractiveActionCardState extends State<InteractiveActionCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isHighlighted = _isHovered || _isPressed;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: isHighlighted
              ? (Matrix4.identity()
                  ..translate(0, -6, 0)
                  ..scale(1.02))
              : Matrix4.identity(),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isHighlighted 
                  ? AppTheme.naturalGreen.withOpacity(0.3)
                  : AppTheme.darkGreen.withOpacity(0.06),
              width: isHighlighted ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isHighlighted
                    ? AppTheme.darkGreen.withOpacity(0.06)
                    : AppTheme.darkGreen.withOpacity(0.02),
                blurRadius: isHighlighted ? 24 : 12,
                offset: isHighlighted
                    ? const Offset(0, 12)
                    : const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? AppTheme.darkGreen
                      : AppTheme.darkGreen.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 300),
                  turns: _isHovered ? 0.05 : 0,
                  child: Icon(
                    widget.icon,
                    color: isHighlighted ? Colors.white : AppTheme.darkGreen,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textBlack,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textGrey,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
