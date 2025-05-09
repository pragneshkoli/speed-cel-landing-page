class Package {
  final String trackingId;
  final String status;
  final String origin;
  final String destination;
  final DateTime shipmentDate;
  final DateTime estimatedDelivery;
  final String currentLocation;
  final List<TrackingEvent> events;
  final String recipientName;
  final String packageWeight;
  final String packageType;

  Package({
    required this.trackingId,
    required this.status,
    required this.origin,
    required this.destination,
    required this.shipmentDate,
    required this.estimatedDelivery,
    required this.currentLocation,
    required this.events,
    required this.recipientName,
    required this.packageWeight,
    required this.packageType,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      trackingId: json['trackingId'],
      status: json['status'],
      origin: json['origin'],
      destination: json['destination'],
      shipmentDate: DateTime.parse(json['shipmentDate']),
      estimatedDelivery: DateTime.parse(json['estimatedDelivery']),
      currentLocation: json['currentLocation'],
      events: (json['events'] as List)
          .map((event) => TrackingEvent.fromJson(event))
          .toList(),
      recipientName: json['recipientName'],
      packageWeight: json['packageWeight'],
      packageType: json['packageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackingId': trackingId,
      'status': status,
      'origin': origin,
      'destination': destination,
      'shipmentDate': shipmentDate.toIso8601String(),
      'estimatedDelivery': estimatedDelivery.toIso8601String(),
      'currentLocation': currentLocation,
      'events': events.map((event) => event.toJson()).toList(),
      'recipientName': recipientName,
      'packageWeight': packageWeight,
      'packageType': packageType,
    };
  }
}

class TrackingEvent {
  final String status;
  final DateTime timestamp;
  final String location;
  final String description;

  TrackingEvent({
    required this.status,
    required this.timestamp,
    required this.location,
    required this.description,
  });

  factory TrackingEvent.fromJson(Map<String, dynamic> json) {
    return TrackingEvent(
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
      location: json['location'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'location': location,
      'description': description,
    };
  }
}