import 'package:equatable/equatable.dart';

class IngredientEntity extends Equatable {
  final String text;
  final num quantity;
  final String measure;
  final String food;
  final double weight;
  final String foodCategory;
  final String foodId;
  final String image;

  const IngredientEntity({
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
    required this.foodCategory,
    required this.foodId,
    required this.image,
  });

  @override
  List<Object?> get props => [
        text,
        quantity,
        measure,
        food,
        weight,
        foodCategory,
        foodId,
        image,
      ];
}
