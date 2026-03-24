class Source {
  final String id, title, resourceId, type;

  const Source({
    required this.id,
    required this.title,
    required this.resourceId,
    required this.type,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['resource']['id'] as String,
      title: json['resource']['title'] as String,
      resourceId: json['resource']['id'] as String,
      type: json['resource']['type'] as String,
    );
  }
}