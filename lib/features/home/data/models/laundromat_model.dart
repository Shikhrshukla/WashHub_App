class LaundromatModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;final String distance;
  final String promoText;
  final bool isVerified;

  LaundromatModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    this.promoText = "",
    this.isVerified = false,
  });

  // Factory to convert DB map to Dart Object
  factory LaundromatModel.fromMap(Map<String, dynamic> map, String id) {
    return LaundromatModel(
      id: id,
      name: map['name'] ?? 'Washub Partner',
      imageUrl: map['imageUrl'] ?? 'https://via.placeholder.com/300',
      rating: (map['rating'] ?? 0.0).toDouble(),
      distance: map['distance'] ?? 'Near you',
      promoText: map['promoText'] ?? '',
      isVerified: map['isVerified'] ?? false,
    );
  }
}