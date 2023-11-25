import 'package:recipes_app/features/index.dart';

class IngredientModel extends IngredientEntity {
  const IngredientModel({
    required String text,
    required num quantity,
    required String measure,
    required String food,
    required double weight,
    required String foodCategory,
    required String foodId,
    required String image,
  }) : super(
          text: text,
          quantity: quantity,
          measure: measure,
          food: food,
          weight: weight,
          foodCategory: foodCategory,
          foodId: foodId,
          image: image,
        );

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      text: json['text'] ?? '',
      quantity: json['quantity'] != null ? json['quantity'] as num : 0,
      measure: json['measure'] ?? '',
      food: json['food'] ?? '',
      weight: json['weight'] != null ? (json['weight'] as num).toDouble() : 0,
      foodCategory: json['foodCategory'] ?? '',
      foodId: json['foodId'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "quantity": quantity,
      "measure": measure,
      "food": food,
      "weight": weight,
      "foodCategory": foodCategory,
      "foodId": foodId,
      "image": image,
    };
  }

  IngredientEntity toEntity() {
    return IngredientEntity(
      text: text,
      quantity: quantity,
      measure: measure,
      food: food,
      weight: weight,
      foodCategory: foodCategory,
      foodId: foodId,
      image: image,
    );
  }
}
