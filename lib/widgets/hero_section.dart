import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'responsive_builder.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isTablet = ResponsiveBreakpoints.of(context).largerThan(MOBILE) &&
        !ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              isDesktop ? 48.0 : (isTablet ? 32.0 : 16.0),
              32.0,
              isDesktop ? 48.0 : (isTablet ? 32.0 : 16.0),
              32.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and Company Name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'company-logo',
                    child: Icon(
                      Icons.local_shipping_rounded,
                      color: theme.colorScheme.onPrimary,
                      size: isDesktop ? 60.0 : (isTablet ? 50.0 : 42.0),
                    ),
                  ),
                  SizedBox(width: isDesktop ? 16.0 : 8.0),
                  Text(
                    'SpeedCel',
                    style: (isDesktop ? theme.textTheme.displayMedium :
                    (isTablet ? theme.textTheme.displaySmall : theme.textTheme.headlineLarge))?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isDesktop ? 16.0 : 8.0),
              // Tagline with animated text
              DefaultTextStyle(
                style: (isDesktop ? theme.textTheme.headlineMedium :
                (isTablet ? theme.textTheme.titleLarge : theme.textTheme.titleMedium))!.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(0.9),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Swift. Reliable. Efficient.',
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Your Package, Our Priority.',
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Delivery That Never Disappoints.',
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  repeatForever: true,
                  pause: const Duration(seconds: 3),
                ),
              ),
              SizedBox(height: isDesktop ? 60.0 : (isTablet ? 50.0 : 40.0)),
              // Animation for delivery - Responsive height
              // Container(
              //   height: 80,
              //   width: isDesktop ? screenSize.width * 0.5 : double.infinity,
              //   child: Lottie.network(
              //     'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/S.json',
              //     fit: BoxFit.contain,
              //     animate: true,
              //   ),
              // ),
              // SizedBox(height: isDesktop ? 48.0 : (isTablet ? 40.0 : 32.0)),
              // Key metrics in a row or column based on screen size
              Container(
                padding: EdgeInsets.symmetric(vertical: isDesktop ? 24.0 : 16.0),
                child: isTablet || isDesktop ?
                // Row layout for larger screens
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMetric(context, '98%', 'On-Time Delivery', isDesktop, isTablet),
                    _buildDivider(context),
                    _buildMetric(context, '20+', 'Cities Covered', isDesktop, isTablet),
                    _buildDivider(context),
                    _buildMetric(context, '5K+', 'Daily Shipments', isDesktop, isTablet),
                  ],
                ) :
                    // SizedBox()
                // Column layout for mobile
                Column(
                  children: [
                    _buildMetric(context, '98%', 'On-Time Delivery', isDesktop, isTablet),
                    const SizedBox(height: 24),
                    _buildMetric(context, '20+', 'Cities Covered', isDesktop, isTablet),
                    const SizedBox(height: 24),
                    _buildMetric(context, '5K+', 'Daily Shipments', isDesktop, isTablet),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(BuildContext context, String value, String label, bool isDesktop, bool isTablet) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: (isDesktop ? theme.textTheme.headlineMedium :
          (isTablet ? theme.textTheme.headlineSmall : theme.textTheme.titleLarge))?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: isDesktop ? 8.0 : 4.0),
        Text(
          label,
          style: (isDesktop ? theme.textTheme.bodyMedium :
          (isTablet ? theme.textTheme.bodySmall : theme.textTheme.bodySmall))?.copyWith(
            color: theme.colorScheme.onPrimary.withOpacity(0.9),

          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isTablet = ResponsiveBreakpoints.of(context).largerThan(MOBILE) &&
        !ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      height: isDesktop ? 60 : (isTablet ? 50 : 40),
      width: 1,
      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
    );
  }
}