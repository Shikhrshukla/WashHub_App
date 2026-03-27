class LaundromatModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String promoTag;
  final bool isVerified;
  final String ownerUid;

  LaundromatModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.promoTag,
    this.isVerified = false,
    required this.ownerUid,
  });

  // Convert Firestore Map to Model
  factory LaundromatModel.fromMap(Map<String, dynamic> map, String docId) {
    return LaundromatModel(
      id: docId,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      promoTag: map['promoTag'] ?? '',
      isVerified: map['isVerified'] ?? false,
      ownerUid: map['ownerUid'] ?? '',
    );
  }
}