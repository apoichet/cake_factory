import '../bin/cake_model.dart';

Cake givenFrancComtoiseCake() => Cake(
  diameterShape: diameterShapeFrancComtoise,
  type: CakeType.francComtoise,
  ingredients: Ingredients(
    eggs: eggsFrancComtoise,
    butter: butterFrancComtoise,
    sugar: sugarFrancComtoise,
  ),
);

Cake givenFrangipaneCake() => Cake(
  diameterShape: diameterShapeFrangipane,
  type: CakeType.frangipane,
  ingredients: Ingredients(
    eggs: eggsFrangipane,
    butter: butterFrangipane,
    sugar: sugarFrangipane,
  ),
);
