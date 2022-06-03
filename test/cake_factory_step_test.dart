
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../bin/cake_factory_step.dart';
import '../bin/cake_model.dart';
import 'fixtures.dart';

class CakeFactoryStepImpl extends CakeFactoryStep {

  CakeFactoryStepImpl();

  CakeFactoryStepImpl.withNext(CakeFactoryStep nextStep): super.withNext(nextStep);

  @override
  CakeStep doAction(CakeStep step) {
    return step;
  }
}

class CakeFactoryStepMock extends Mock implements CakeFactoryStep {}

main() {
  late CakeFactoryStepImpl factoryStep;
  late CakeFactoryStepMock factoryStepMock;

  setUp(() {
    factoryStepMock = CakeFactoryStepMock();
    factoryStep = CakeFactoryStepImpl.withNext(factoryStepMock);
  });

  setUpAll(() {
    registerFallbackValue(CakeSteps(actualStep: CakeStep(cake: givenFrangipaneCake())));
  });

  test('should verify next step is called', () {
    //Given
    var input = CakeSteps(actualStep: CakeStep(cake: givenFrangipaneCake()));
    when(() => factoryStepMock.doActions(any())).thenReturn(input);
    //When
    factoryStep.doActions(input);
    //Then
    verify(() => factoryStepMock.doActions(any()));
  });

  test('should not verify next step is called when not exists', () {
    //Given
    factoryStep = CakeFactoryStepImpl();
    var input = CakeSteps(actualStep: CakeStep(cake: givenFrangipaneCake()));
    //When
    factoryStep.doActions(input);
    //Then
    verifyNever(() => factoryStepMock.doActions(any()));
  });

  test('should not verify next step is called when actual step has error', () {
    //Given
    var input = CakeSteps(actualStep: CakeStep(cake: givenFrangipaneCake(), stepError: CakeStepError('Erreur')));
    //When
    factoryStep.doActions(input);
    //Then
    verifyNever(() => factoryStepMock.doActions(any()));
  });

}
