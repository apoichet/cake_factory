import 'dart:math';

import '../cake_model.dart';
import 'cooking_service.dart';

const randomCookFrancComtoise = 3;
const randomCookFrangipane = 4;

class RandomCookService extends CookingService{

  final RandomService randomService;

  RandomCookService({RandomService? randomService}) : randomService = randomService ?? RandomService();

  @override
  bool cookCake(CakeType cakeType) {
    if(cakeType == CakeType.francComtoise) {
      return _cookFrancComtoiseCake();
    } else if(cakeType == CakeType.frangipane) {
      return _cookFrangipaneCake();
    } else {
      return false;
    }
  }

  bool _cookFrancComtoiseCake() => _cook(randomCookFrancComtoise);

  bool _cookFrangipaneCake() => _cook(randomCookFrangipane);

  bool _cook(int maxRandom) => randomService.random(maxRandom) != maxRandom - 1;

}

class RandomService {

    final Random _random;

    RandomService() : _random = Random();

    int random(int max) => _random.nextInt(max);

}
