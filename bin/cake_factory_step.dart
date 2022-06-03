import 'cake_model.dart';

abstract class CakeFactoryStep {

  final CakeFactoryStep? next;

  CakeFactoryStep({this.next});

  CakeFactoryStep.withNext(CakeFactoryStep nextStep): next = nextStep;

  CakeSteps doActions(CakeSteps cakeSteps) {
    var newCakeSteps = cakeSteps.addStep(doAction(cakeSteps.last));
    if(newCakeSteps.last.hasError) {
      return newCakeSteps;
    }
    return next?.doActions(newCakeSteps) ?? newCakeSteps;
  }

  CakeStep doAction(CakeStep cakeStep);

}

extension on CakeStep {
  bool get hasError => stepError != null;
}
