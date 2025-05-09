import '../models/package_model.dart';

class SamplePackages {
  static final Map<String, Package> packages = {
    'S-250507-001': Package(
      trackingId: 'S-250507-001',
      status: 'PACKAGE_LEFT',
      origin: 'Thakkarnagar, Bapunagar, Ahmedabad',
      destination: 'TRP Mall, Bopal, Ahmedabad',
      // 2025-05-07T16:25:37.854+00:00
      shipmentDate : DateTime(2025, 5, 7, 16, 25, 37),
      estimatedDelivery: DateTime.now().add(const Duration(days: 3)),
      currentLocation: 'Bapunagar, Ahmedabad',
      recipientName: 'Jeemit',
      packageWeight: '10 kg',
      packageType: 'Express Parcel',
      events: [
        //["PACKAGE_ARRIVED", "PACKAGE_LEFT", "PACKAGE_ON_THE_WAY", "PACKAGE_DELIVERED"],
        TrackingEvent(
          status: 'Order Placed',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          location: 'Thakkarnagar, Bapunagar, Ahmedabad',
          description: 'Package order has been placed',
        ),
        TrackingEvent(
          status: 'PACKAGE_ARRIVED',
          timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 12)),
          location: 'Thakkarnagar, Bapunagar, Ahmedabad',
          description: 'Package has been processed at our facility',
        ),
        TrackingEvent(
          status: 'PACKAGE_LEFT',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          location: 'Thakkarnagar, Bapunagar, Ahmedabad',
          description: 'Package has departed from origin facility',
        ),
        TrackingEvent(
          status: 'PACKAGE_ON_THE_WAY',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          location: 'Bopal, Ahmedabad',
          description: 'Package is out for delivery',
        ),
        TrackingEvent(
          status: 'PACKAGE_DELIVERED',
          timestamp: DateTime.now().subtract(const Duration(hours: 6)),
          location: 'TRP Mall, Bopal, Ahmedabad',
          description: 'Package has arrived at the destination facility',
        ),
      ],
    ),
    'SP7654321': Package(
      trackingId: 'SP7654321',
      status: 'Delivered',
      origin: 'Seattle, WA',
      destination: 'Miami, FL',
      shipmentDate: DateTime.now().subtract(const Duration(days: 5)),
      estimatedDelivery: DateTime.now().subtract(const Duration(days: 1)),
      currentLocation: 'Miami, FL',
      recipientName: 'Maria Rodriguez',
      packageWeight: '1.8 kg',
      packageType: 'Standard Delivery',
      events: [
        TrackingEvent(
          status: 'Order Placed',
          timestamp: DateTime.now().subtract(const Duration(days: 6)),
          location: 'Seattle, WA',
          description: 'Package order has been placed',
        ),
        TrackingEvent(
          status: 'Processed',
          timestamp: DateTime.now().subtract(const Duration(days: 5, hours: 12)),
          location: 'Seattle, WA',
          description: 'Package has been processed at origin facility',
        ),
        TrackingEvent(
          status: 'Shipped',
          timestamp: DateTime.now().subtract(const Duration(days: 5)),
          location: 'Seattle, WA',
          description: 'Package has departed from origin facility',
        ),
        TrackingEvent(
          status: 'In Transit',
          timestamp: DateTime.now().subtract(const Duration(days: 4)),
          location: 'Salt Lake City, UT',
          description: 'Package is in transit to the next facility',
        ),
        TrackingEvent(
          status: 'In Transit',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          location: 'Dallas, TX',
          description: 'Package has arrived at regional sorting facility',
        ),
        TrackingEvent(
          status: 'In Transit',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          location: 'Atlanta, GA',
          description: 'Package is in transit to the destination city',
        ),
        TrackingEvent(
          status: 'Out for Delivery',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
          location: 'Miami, FL',
          description: 'Package is out for delivery',
        ),
        TrackingEvent(
          status: 'Delivered',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          location: 'Miami, FL',
          description: 'Package has been delivered',
        ),
      ],
    ),
    'SP9876543': Package(
      trackingId: 'SP9876543',
      status: 'Processing',
      origin: 'Chicago, IL',
      destination: 'Houston, TX',
      shipmentDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(const Duration(days: 4)),
      currentLocation: 'Chicago, IL',
      recipientName: 'David Johnson',
      packageWeight: '5.2 kg',
      packageType: 'Priority Shipment',
      events: [
        TrackingEvent(
          status: 'Order Placed',
          timestamp: DateTime.now().subtract(const Duration(hours: 12)),
          location: 'Chicago, IL',
          description: 'Package order has been placed',
        ),
        TrackingEvent(
          status: 'Processing',
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          location: 'Chicago, IL',
          description: 'Package is being processed at origin facility',
        ),
      ],
    ),
  };

  static Package? getPackageByTrackingId(String trackingId) {
    return packages[trackingId];
  }
}