import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/sample_packages.dart';
import '../models/package_model.dart';

class TrackingService {
  static const String _recentTracksKey = 'recent_tracks';
  static const int _maxRecentTracks = 5;

  // Get package by tracking ID (from sample data for demo)
  Future<Package?> getPackageByTrackingId(String trackingId) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Get package from sample data
    final package = await SamplePackages.getPackageByTrackingId(trackingId);

    // If package exists, save to recent tracks
    if (package != null) {
      await _saveToRecentTracks(package);
    }

    return package;
  }

  // Save package to recent tracks
  Future<void> _saveToRecentTracks(Package package) async {
    final prefs = await SharedPreferences.getInstance();
    final recentTracksJson = prefs.getStringList(_recentTracksKey) ?? [];

    // Convert to list of packages
    final recentTracks = recentTracksJson
        .map((json) => Package.fromJson(jsonDecode(json)))
        .toList();

    // Remove if already exists to avoid duplicates
    recentTracks.removeWhere((p) => p.trackingId == package.trackingId);

    // Add new package at the beginning
    recentTracks.insert(0, package);

    // Trim list if needed
    if (recentTracks.length > _maxRecentTracks) {
      recentTracks.removeLast();
    }

    // Convert back to JSON strings
    final updatedRecentTracksJson = recentTracks
        .map((package) => jsonEncode(package.toJson()))
        .toList();

    // Save updated list
    await prefs.setStringList(_recentTracksKey, updatedRecentTracksJson);
  }

  // Get recent tracks
  Future<List<Package>> getRecentTracks() async {
    final prefs = await SharedPreferences.getInstance();
    final recentTracksJson = prefs.getStringList(_recentTracksKey) ?? [];

    // Convert to list of packages
    return recentTracksJson
        .map((json) => Package.fromJson(jsonDecode(json)))
        .toList();
  }

  // Clear recent tracks
  Future<void> clearRecentTracks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentTracksKey);
  }
}