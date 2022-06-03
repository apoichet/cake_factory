import 'cake_model.dart';
import 'steps/cake_compliance.dart';
import 'steps/cake_cooking.dart';
import 'steps/cake_price_calculator.dart';

class CakeFactory {

  static CakeSteps makeCakeFrom({required Cake initial}) {
    return CakeCompliance
        .withNext(CakeCooking
        .withNext(CakePriceCalculator()))
        .doActions(CakeSteps(actualStep: CakeStep(cake: initial)));
  }
}
