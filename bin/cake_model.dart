import 'package:collection/collection.dart';

const butterFrancComtoise = 70;
const sugarFrancComtoise = 100;
const eggsFrancComtoise = 4;
const diameterShapeFrancComtoise = 33;

const butterFrangipane = 75;
const sugarFrangipane = 100;
const eggsFrangipane = 2;
const diameterShapeFrangipane = 25;

class CakeSteps {

  final List<CakeStep> stepList;
  final CakeStep actualStep;

  CakeSteps({required this.actualStep, List<CakeStep>? stepList}) : stepList = stepList ?? [];

  CakeSteps addStep(CakeStep step) => CakeSteps(actualStep: step, stepList: [...stepList, step]);

  CakeStep get last => stepList.lastOrNull ?? actualStep;

}

class CakeStep {

  final CakeStepError? stepError;
  final Cake cake;

  CakeStep({this.stepError, required this.cake});

  CakeStep copyWithMsgError(String msg) => CakeStep(stepError: CakeStepError(msg), cake: cake.copyWith());

  CakeStep copyWithCake(Cake cake) => CakeStep(cake: cake);

  @override
  String toString() {
    return 'CakeStep{stepError: $stepError, cake: $cake}';
  }
}

class CakeStepError {
  final String msg;
  CakeStepError(this.msg);
  @override
  String toString() {
    return 'CakeStepError{msg: $msg}';
  }
}

class Cake {
  final int diameterShape;
  final Ingredients ingredients;
  final CakeType type;
  final bool cooked;
  final double price;

  Cake({
    required this.ingredients,
    required this.diameterShape,
    this.type = CakeType.unknown,
    this.cooked = false,
    this.price = 0.0,
  });

  bool get isFrancComtoise => type == CakeType.francComtoise;
  bool get isFrangipane => type == CakeType.frangipane;

  copyWith({
    int? diameterShape,
    final Ingredients? ingredients,
    final CakeType? type,
    final bool? cooked,
    final double? price,
  }) {
    return Cake(
      diameterShape: diameterShape ?? this.diameterShape,
      ingredients: ingredients ?? this.ingredients.copyWith(),
      type: type ?? this.type,
      cooked: cooked ?? this.cooked,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'Cake{diameterShape: $diameterShape, ingredients: $ingredients, type: $type, cooked: $cooked, price: $price}';
  }
}

class Ingredients {
  final int butter;
  final int sugar;
  final int eggs;

  copyWith({
    int? butter,
    int? sugar,
    int? eggs,
  }) {
    return Ingredients(
      sugar:  sugar ?? this.sugar,
      eggs: eggs ?? this.eggs,
      butter: butter ?? this.butter,
    );
  }

  Ingredients({
    required this.butter,
    required this.sugar,
    required this.eggs,
  });

  @override
  String toString() {
    return 'Ingredients{butter: $butter, sugar: $sugar, eggs: $eggs}';
  }
}

enum CakeType { francComtoise, frangipane, unknown }
