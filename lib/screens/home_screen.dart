import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../services/tracking_service.dart';
import '../widgets/hero_section.dart';
import '../widgets/features_section.dart';
import '../widgets/tracking_form.dart';
import '../widgets/responsive_builder.dart';
import 'tracking_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingService _trackingService = TrackingService();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: ResponsiveBuilder(
          builder: (context, isDesktop, isTablet, isMobile) {
            final heroOffset = isDesktop ? -100.0 : (isTablet ? -80.0 : -60.0);
            final featuresOffset = isDesktop ? -60.0 : (isTablet ? -50.0 : -40.0);

            return Stack(
              children: [
                // Main content
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Hero section with company branding
                      const HeroSection(),
                      
                      SizedBox(height: 50,),
                      TrackingForm(
                        onTrackPackage: _handleTrackPackage,
                      ),
                      // Tracking form (slightly overlapping hero section)
                      // Transform.translate(
                      //   offset: Offset(0, heroOffset),
                      //   child: TrackingForm(
                      //     onTrackPackage: _handleTrackPackage,
                      //   ),
                      // ),

                      // Features section (with negative top margin to account for overlap)
                      Transform.translate(
                        offset: Offset(0, featuresOffset),
                        child: const FeaturesSection(),
                      ),

                      // Footer
                      _buildFooter(),
                    ],
                  ),
                ),

                // Loading overlay
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: isDesktop ? 5.0 : (isTablet ? 4.0 : 3.0),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Handle tracking submission
  Future<void> _handleTrackPackage(String trackingId) async {
    setState(() => _isLoading = true);
    try {
      final package = await _trackingService.getPackageByTrackingId(trackingId);

      if (package != null) {
        if (!mounted) return;

        // Navigate to tracking details screen
        Navigator.pushNamed(
          context,
          '/tracking',
          arguments: package,
        );
      } else {
        // Show error if package not found
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
              'Package not found. Please check the tracking number and try again.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Show error if something goes wrong
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            'An error occurred. Please try again later.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Footer widget
  Widget _buildFooter() {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isTablet = ResponsiveBreakpoints.of(context).largerThan(MOBILE) &&
        !ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 60.0 : (isTablet ? 50.0 : 40.0),
        horizontal: isDesktop ? 48.0 : (isTablet ? 32.0 : 16.0),
      ),
      color: theme.colorScheme.primary.withOpacity(0.05),
      child:
      // Mobile and tablet layout - vertical
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_shipping_rounded,
                color: theme.colorScheme.primary,
                size: isTablet ? 38 : 32,
              ),
              SizedBox(width: isTablet ? 12 : 8),
              Text(
                'SpeedCel',
                style: (isTablet ? theme.textTheme.headlineSmall : theme.textTheme.titleLarge)?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 20 : 16),
          Text(
            'Your trusted partner for fast and reliable courier services.',
            style: isTablet ? theme.textTheme.titleSmall : theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isTablet ? 32 : 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.language, theme, isDesktop, isTablet),
              _buildSocialIcon(Icons.facebook, theme, isDesktop, isTablet),
              _buildSocialIcon(Icons.insights, theme, isDesktop, isTablet),
              _buildSocialIcon(Icons.shopping_cart, theme, isDesktop, isTablet),
            ],
          ),
          SizedBox(height: isTablet ? 32 : 24),
          Text(
            '© ${DateTime.now().year} SpeedCel. All rights reserved.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, ThemeData theme, bool isDesktop, bool isTablet) {
    final iconSize = isDesktop ? 60.0 : (isTablet ? 50.0 : 40.0);
    final iconPadding = isDesktop ? 12.0 : (isTablet ? 10.0 : 8.0);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: iconPadding),
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: isDesktop ? 2 : 1,
            blurRadius: isDesktop ? 5 : 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: isDesktop ? 28 : (isTablet ? 24 : 20),
        ),
      ),
    );
  }
}