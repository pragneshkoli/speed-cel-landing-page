import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'responsive_builder.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isTablet = ResponsiveBreakpoints.of(context).largerThan(MOBILE) &&
        !ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48.0 : (isTablet ? 32.0 : 16.0),
        vertical: isDesktop ? 60.0 : (isTablet ? 50.0 : 40.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose SpeedCel?',
            style: (isDesktop ? theme.textTheme.displaySmall :
            (isTablet ? theme.textTheme.headlineLarge : theme.textTheme.headlineMedium))?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0)),
          Text(
            'Experience the difference with our world-class courier services',
            style: (isDesktop ? theme.textTheme.headlineSmall :
            (isTablet ? theme.textTheme.titleLarge : theme.textTheme.bodyLarge))?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: isDesktop ? 48.0 : (isTablet ? 40.0 : 32.0)),

          // Features in a grid - responsive grid count
          GridView.count(
            crossAxisCount: isDesktop ? 4 : (isTablet ? 3 : 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0),
            mainAxisSpacing: isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0),
            childAspectRatio: isDesktop ? 1.0 : (isTablet ? 0.95 : 0.9),
            children: [
              _buildFeatureCard(
                context,
                Icons.speed_rounded,
                'Express Delivery',
                'Same-day and next-day delivery options available for urgent shipments',
                theme.colorScheme.primary,
              ),
              _buildFeatureCard(
                context,
                Icons.location_on_rounded,
                'Global Reach',
                'Delivering to 20+ cities worldwide with local expertise',
                theme.colorScheme.secondary,
              ),
              _buildFeatureCard(
                context,
                Icons.security_rounded,
                'Secure Handling',
                'Advanced tracking and secure packaging for peace of mind',
                theme.colorScheme.tertiary,
              ),
              _buildFeatureCard(
                context,
                Icons.savings_rounded,
                'Competitive Rates',
                'Cost-effective shipping solutions for businesses of all sizes',
                theme.colorScheme.primary.withGreen(150),
              ),
            ],
          ),

          SizedBox(height: isDesktop ? 60.0 : (isTablet ? 50.0 : 40.0)),

          // Customer testimonial - responsive layout
          Container(
            padding: EdgeInsets.all(isDesktop ? 36.0 : (isTablet ? 30.0 : 24.0)),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: isDesktop ? 15.0 : (isTablet ? 12.0 : 10.0),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: isDesktop || isTablet ?
            // Horizontal layout for desktop and tablet
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.format_quote,
                            color: theme.colorScheme.primary,
                            size: isDesktop ? 40.0 : 32.0,
                          ),
                          SizedBox(width: isDesktop ? 12.0 : 8.0),
                          Text(
                            'Customer Story',
                            style: (isDesktop ? theme.textTheme.headlineSmall : theme.textTheme.titleMedium)?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24.0),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SpeedCel has revolutionized our logistics. Their reliable service and real-time tracking have significantly improved our customer satisfaction rates.',
                        style: (isDesktop ? theme.textTheme.titleLarge : theme.textTheme.bodyLarge)?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: isDesktop ? 24.0 : 16.0),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: theme.colorScheme.secondary,
                            radius: isDesktop ? 28.0 : 20.0,
                            child: Icon(
                              Icons.person,
                              color: theme.colorScheme.onSecondary,
                              size: isDesktop ? 32.0 : 24.0,
                            ),
                          ),
                          SizedBox(width: isDesktop ? 16.0 : 12.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sarah Johnson',
                                style: (isDesktop ? theme.textTheme.titleMedium : theme.textTheme.titleSmall)?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Supply Chain Manager, TechCorp',
                                style: isDesktop ? theme.textTheme.bodyMedium : theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
                :
            // Vertical layout for mobile
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.format_quote,
                      color: theme.colorScheme.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Customer Story',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'SpeedCel has revolutionized our logistics. Their reliable service and real-time tracking have significantly improved our customer satisfaction rates.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.secondary,
                      radius: 20,
                      child: Icon(
                        Icons.person,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sarah Johnson',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Supply Chain Manager, TechCorp',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String title, String description, Color color) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}