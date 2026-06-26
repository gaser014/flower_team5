import 'package:equatable/equatable.dart';

class TrackOrderItemEntity extends Equatable {
  final String title;
  final String description;
  final String image;
  final num price;
  final int quantity;

  const TrackOrderItemEntity({
    required this.title,
    required this.price,
    required this.quantity,
    this.description = '',
    this.image = '',
  });

  @override
  List<Object?> get props => [title, description, image, price, quantity];
}
