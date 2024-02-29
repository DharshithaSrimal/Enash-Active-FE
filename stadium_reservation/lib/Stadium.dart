class Stadium {
  final String name;
  final String description;
  final String location;
  final bool availability;
  final String ordID; // Assuming this corresponds to some ID
  final double hourlyRate;

  Stadium({
    required this.name,
    required this.description,
    required this.location,
    required this.availability,
    required this.ordID,
    required this.hourlyRate,
  });
}
