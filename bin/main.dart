import 'cake_factory.dart';
import 'cake_model.dart';

main() {
  [
    Cake(ingredients: Ingredients(eggs: 4, sugar: 125, butter: 80), diameterShape: 33),
    Cake(ingredients: Ingredients(eggs: 4, sugar: 125, butter: 25), diameterShape: 33),
    Cake(ingredients: Ingredients(eggs: 4, sugar: 125, butter: 25), diameterShape: 25),
    Cake(ingredients: Ingredients(eggs: 4, sugar: 125, butter: 100), diameterShape: 25),
    Cake(ingredients: Ingredients(eggs: 4, sugar: 125, butter: 10), diameterShape: 25)
  ].map((cake) => CakeFactory.makeCakeFrom(initial: cake)).forEach((steps) {
    steps.stepList.forEach((step) => print(step));
    print('----------------------------------------------------------------');
  });
}
