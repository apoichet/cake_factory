import '../cake_factory_step.dart';
import '../cake_model.dart';

const shapeMsgError = 'Le diametre ne correspond à aucune galette !';
ingredientsMsgError(CakeType type) => "Pas assez d'ingrédients pour faire une galette $type !";

class CakeCompliance extends CakeFactoryStep {
  CakeCompliance();

  CakeCompliance.withNext(CakeFactoryStep nextStep) : super.withNext(nextStep);

  CakeStep compliance(CakeStep step) {
    if (step.cake.hasShapeFor(CakeType.francComtoise)) {
      return _complianceIngredients(step, type: CakeType.francComtoise);
    } else if (step.cake.hasShapeFor(CakeType.frangipane)) {
      return _complianceIngredients(step, type: CakeType.frangipane);
    } else {
      return step.copyWithMsgError(shapeMsgError);
    }
  }

  CakeStep _complianceIngredients(CakeStep step, {required CakeType type}) {
    return step.cake.hasEnoughIngredientsFor(type)
        ? step.copyWithCake(step.cake.copyWith(type: type))
        : step.copyWithMsgError(ingredientsMsgError(type));
  }

  @override
  CakeStep doAction(CakeStep cake) => compliance(cake);
}

extension on Cake {

  bool hasEnoughIngredientsFor(CakeType type) => ingredients.isEnoughFor(type);

  bool hasShapeFor(CakeType type) {
    switch (type) {
      case CakeType.frangipane:
        return diameterShape == diameterShapeFrangipane;
      case CakeType.francComtoise:
        return diameterShape == diameterShapeFrancComtoise;
      default:
        return false;
    }
  }
}

extension on Ingredients {
  bool isEnoughFor(CakeType type) {
    switch (type) {
      case CakeType.frangipane:
        return butter >= butterFrangipane && eggs >= eggsFrangipane && sugar >= sugarFrangipane;
      case CakeType.francComtoise:
        return butter >= butterFrancComtoise && eggs >= eggsFrancComtoise && sugar >= sugarFrancComtoise;
      default:
        return false;
    }
  }
}
