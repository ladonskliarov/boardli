enum ResourceType {
  file,
  link;

  static ResourceType fromJson(String? jsonValue) {
    if (jsonValue == 'url' || jsonValue == 'link') {
      return ResourceType.link;
    }
    return ResourceType.file; 
  }
}

class Resource {
  final String id;
  final ResourceType type;
  final String title;
  final String? companyId;
  final String? employeeId;
  final bool processed;
  final String? fileName;
  final String? mimeType;
  final int? fileSize;
  final String? filePath;
  final String? fileUrl;
  final String? url;
  final String? originalUrl;
  final int? contentLength;
  final String? extractedContent;

  const Resource({
    required this.id,
    required this.type,
    required this.title,
    required this.companyId,
    this.employeeId,
    required this.processed,
    this.fileName,
    this.mimeType,
    this.fileSize,
    this.filePath,
    this.fileUrl,
    this.url,
    this.originalUrl,
    this.contentLength,
    this.extractedContent,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      id: json['id'],
      type: ResourceType.fromJson(json['type']),
      title: json['title'],
      companyId: json['companyId'],
      employeeId: json['employeeId'],
      processed: json['processed'],
      fileName: json['fileName'],
      mimeType: json['mimeType'],
      fileSize: json['fileSize'],
      filePath: json['filePath'],
      fileUrl: json['fileUrl'],
      url: json['url'],
      originalUrl: json['originalUrl'],
      contentLength: json['contentLength'],
      extractedContent: json['extractedContent'],
    );
  }
}