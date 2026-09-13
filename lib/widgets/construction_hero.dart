import 'package:flutter/material.dart';
import 'package:nijaao_web/theme/app_theme.dart';
import 'package:nijaao_web/utils/responsive.dart';

class ConstructionHero extends StatefulWidget {
  const ConstructionHero({super.key});

  @override
  State<ConstructionHero> createState() => _ConstructionHeroState();
}

class _ConstructionHeroState extends State<ConstructionHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 0.85).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad),
        )..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final double headlineSize = isMobile ? 42 : 72;
    final double underSize = isMobile ? 46 : 84;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 40 : 80,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/page_background.png')),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWarningStripe(),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accentGold.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppTheme.accentGold.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.construction_rounded,
                      color: AppTheme.accentGold,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'NIJAAO PREPARING FOR LAUNCH',
                      style: TextStyle(
                        color: AppTheme.darkGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'WEBSITE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: headlineSize,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 4,
                  color: AppTheme.textBlack.withOpacity(0.7),
                  height: 1.0,
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppTheme.darkGreen, AppTheme.naturalGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  'UNDER\nCONSTRUCTION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: underSize,
                    fontWeight: FontWeight.w900,
                    letterSpacing: isMobile ? -1 : -2,
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'We’re building a better shopping experience for you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 20,
                  color: AppTheme.textGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.darkGreen.withOpacity(0.04),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: AppTheme.darkGreen.withOpacity(0.05),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'WE’LL BE LIVE ON',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: AppTheme.textGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'DEC 1',
                      style: TextStyle(
                        fontSize: isMobile ? 36 : 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                        color: AppTheme.darkGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 56),
              _buildProgressBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningStripe() {
    return Container(
      height: 6,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        gradient: LinearGradient(
          colors: List.generate(6, (index) {
            return index % 2 == 0 ? AppTheme.accentGold : AppTheme.darkGreen;
          }),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.repeated,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final double percentage = _progressAnimation.value;
    final int displayPct = (percentage * 100).toInt();
    final int filledBlocks = (percentage * 10).round();
    final String blockString = '█' * filledBlocks + '░' * (10 - filledBlocks);

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BUILDING YOUR EXPERIENCE...',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: AppTheme.darkGreen.withOpacity(0.6),
                ),
              ),
              Text(
                '$blockString $displayPct%',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 8,
              width: double.infinity,
              color: AppTheme.darkGreen.withOpacity(0.08),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                          colors: [AppTheme.accentGold, AppTheme.naturalGreen],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
