import '../cake_factory_step.dart';
import '../cake_model.dart';

const priceFrancComtoiseCake = 8.0;
const priceFrangipaneCake = 9.0;
const priceCakeMsgError = 'Impossible de définir un prix pour une galette de type inconnue !';
const priceCakeNotCookedMsgError = 'Impossible de définir un prix pour une galette pas cuite !';

class CakePriceCalculator extends CakeFactoryStep {
  CakeStep calculatePrice(CakeStep step) {
    if (step.cake.isFrancComtoise) {
      return _buildPriceOrError(step, price: priceFrancComtoiseCake, msgError: priceCakeNotCookedMsgError);
    } else if (step.cake.isFrangipane) {
      return _buildPriceOrError(step, price: priceFrangipaneCake, msgError: priceCakeNotCookedMsgError);
    } else {
      return step.copyWithMsgError(priceCakeMsgError);
    }
  }

  CakeStep _buildPriceOrError(CakeStep step, {required double price, required String msgError}) {
    return step.cake.cooked ? step.copyWithCake(step.cake.copyWith(price: price)) : step.copyWithMsgError(msgError);
  }

  @override
  CakeStep doAction(CakeStep step) => calculatePrice(step);
}
