import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../models/package_model.dart';
import '../widgets/responsive_builder.dart';

class TrackingDetailsScreen extends StatelessWidget {
  const TrackingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, isDesktop, isTablet, isMobile) {
        final theme = Theme.of(context);
        final package = ModalRoute.of(context)!.settings.arguments as Package;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Package Details',
              style: context.responsiveTextStyle(
                mobile: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                tablet: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                desktop: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: theme.colorScheme.surface,
            toolbarHeight: isDesktop ? 80 : (isTablet ? 70 : 56),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: theme.colorScheme.primary,
                size: isDesktop ? 32 : (isTablet ? 28 : 24),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: isDesktop
          // Desktop layout - two column
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column: Package info
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildStatusCard(context, package),
                      const SizedBox(height: 24),
                      _buildPackageDetails(context, package),
                    ],
                  ),
                ),
              ),
              // Vertical divider
              Container(
                height: double.infinity,
                width: 1,
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
              // Right column: Timeline
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDeliveryTimeline(context, package),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          )
          // Mobile/Tablet layout - single column
              : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24.0 : 16.0,
                vertical: isTablet ? 24.0 : 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Package status card
                  _buildStatusCard(context, package),

                  // Package details
                  _buildPackageDetails(context, package),

                  // Delivery timeline
                  _buildDeliveryTimeline(context, package),

                  SizedBox(height: isTablet ? 60 : 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusCard(BuildContext context, Package package) {
    final theme = Theme.of(context);
    final DateFormat formatter = DateFormat('MMM dd, yyyy');

    Color statusColor;
    IconData statusIcon;

    // Determine status color and icon
    switch (package.status.toLowerCase()) {
      case 'package_delivered':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'package_on_thw_way':
        statusColor = Colors.blue;
        statusIcon = Icons.local_shipping;
        break;
      case 'in transit':
        statusColor = theme.colorScheme.primary;
        statusIcon = Icons.airport_shuttle;
        break;
      case 'package_left':
        statusColor = theme.colorScheme.tertiary;
        statusIcon = Icons.inventory;
        break;
      case 'package_arrived':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      default:
        statusColor = theme.colorScheme.primary;
        statusIcon = Icons.local_shipping;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withBlue(220),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tracking ID: ${package.trackingId}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      package.status,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildRouteInfo(
                  context,
                  Icons.flight_takeoff_rounded,
                  'From',
                  package.origin,
                  Colors.white70,
                  Colors.white,
                ),
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Icon(
                  Icons.east_rounded,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Expanded(
                child: _buildRouteInfo(
                  context,
                  Icons.flight_land_rounded,
                  'To',
                  package.destination,
                  Colors.white70,
                  Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateInfo(
                context,
                'Shipment Date',
                formatter.format(package.shipmentDate),
                Colors.white70,
                Colors.white,
              ),
              _buildDateInfo(
                context,
                'Expected Delivery',
                "Not available",
                Colors.white70,
                Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo(BuildContext context, IconData icon, String label, String value, Color labelColor, Color valueColor) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: labelColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: labelColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDateInfo(BuildContext context, String label, String value, Color labelColor, Color valueColor) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: labelColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPackageDetails(BuildContext context, Package package) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Package Details',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            Icons.person_outline_rounded,
            'Recipient',
            package.recipientName,
          ),
          const Divider(height: 24),
          _buildDetailRow(
            context,
            Icons.inventory_2_outlined,
            'Package Type',
            package.packageType,
          ),
          const Divider(height: 24),
          _buildDetailRow(
            context,
            Icons.scale_outlined,
            'Weight',
            package.packageWeight,
          ),
          const Divider(height: 24),
          _buildDetailRow(
            context,
            Icons.location_on_outlined,
            'Current Location',
            "Not available",
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryTimeline(BuildContext context, Package package) {
    final theme = Theme.of(context);
    final DateFormat dateFormatter = DateFormat('MMM dd, yyyy');
    final DateFormat timeFormatter = DateFormat('hh:mm a');

    return Container(
      margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Timeline',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: package.events.length,
              itemBuilder: (context, index) {
                final event = package.events[index];
                final isFirst = index == 0;
                final isLast = index == package.events.length - 1;
                int currentIndex = package.events.indexWhere((e) => e.status == package.status);
                print(package.trackingId);
                print(package.status);
                return TimelineTile(
                  isFirst: isFirst,
                  isLast: isLast,
                  alignment: TimelineAlign.manual,
                  lineXY: 0.2,
                  indicatorStyle: IndicatorStyle(
                    width: 20,
                    height: 20,
                    indicator: Container(
                      decoration: BoxDecoration(
                        color: index <= currentIndex
                            ? theme.colorScheme.primary
                            : theme.colorScheme.primary.withOpacity(0.5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.surface,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                  beforeLineStyle: LineStyle(
                    color: index <= currentIndex
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primary.withOpacity(0.5),
                    thickness: 2,
                  ),
                  afterLineStyle: LineStyle(
                    color: index <= currentIndex
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primary.withOpacity(0.5),
                    thickness: 2,
                  ),
                  endChild: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatStatus (event.status),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isFirst
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.description,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.location,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  startChild: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          dateFormatter.format(event.timestamp),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          timeFormatter.format(event.timestamp),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatStatus(String status) {
    return status.replaceAll('_', ' ').toUpperCase();
  }
}