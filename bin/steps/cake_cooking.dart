import '../cake_factory_step.dart';
import '../cake_model.dart';
import '../service/cooking_service.dart';
import '../service/random_cook_service.dart';

typedef OnSuccessCooking = CakeStep Function();
typedef OnErrorCooking = CakeStep Function();
const cookingCakeMsgError = 'La cuisson est impossible car le type de galetette est indeterminée"';
cookingCakeTypeMsgError(CakeType type) => "La cuisson a foiré pour la galette de type $type !";

class CakeCooking extends CakeFactoryStep {
  final CookingService cookService;

  CakeCooking({CookingService? cookService}) : cookService = cookService ?? RandomCookService();

  CakeCooking.withNext(CakeFactoryStep nextStep, {CookingService? cookService})
      : cookService = cookService ?? RandomCookService(),
        super.withNext(nextStep);

  CakeStep cook(CakeStep step) {
    if (step.cake.isFrancComtoise) {
      return cookService.cookCake(CakeType.francComtoise).on(
        success: () => step.copyWithCake(step.cake.copyWith(cooked: true)),
        error: () => step.copyWithMsgError(cookingCakeTypeMsgError(CakeType.francComtoise)),
      );
    } else if (step.cake.isFrangipane) {
      return cookService.cookCake(CakeType.frangipane).on(
        success: () => step.copyWithCake(step.cake.copyWith(cooked: true)),
        error: () => step.copyWithMsgError(cookingCakeTypeMsgError(CakeType.frangipane)),
      );
    } else {
      return step.copyWithMsgError(cookingCakeMsgError);
    }
  }

  @override
  CakeStep doAction(CakeStep step) => cook(step);
}

extension on bool {

  CakeStep on({required OnSuccessCooking success, required OnErrorCooking error}) => this ? success.call() : error.call();

}
