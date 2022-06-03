import 'package:test/test.dart';

import '../../bin/cake_model.dart';
import '../../bin/steps/cake_compliance.dart';
import '../fixtures.dart';

main() {
  late CakeCompliance cakeCompliance;

  setUp(() {
    cakeCompliance = CakeCompliance();
  });

  test('should cakeCompliance cake type ${CakeType.francComtoise}', () {
    //Given
    CakeStep input = CakeStep(cake: _givenComplianceFrancComtoiseCake());
    //When
    var output = cakeCompliance.compliance(input);
    //Then
    expect(output.cake.type, CakeType.francComtoise);
  });

  test('should cakeCompliance cake type ${CakeType.frangipane}', () {
    //Given
    var input = CakeStep(cake: _givenComplianceFrangipaneCake());
    //When
    var output = cakeCompliance.compliance(input);
    //Then
    expect(output.cake.type, CakeType.frangipane);
  });

  test('should cakeCompliance cake type ${CakeType.frangipane} with more ingredients', () {
    //Given
    var input = CakeStep(cake: _givenComplianceFrangipaneCake().moreIngredient(sugar: 25));
    //When
    var output = cakeCompliance.compliance(input);
    //Then
    expect(output.cake.type, CakeType.frangipane);
  });

  test('should cakeCompliance cake type ${CakeType.francComtoise} with more ingredients', () {
    //Given
    var input = CakeStep(cake: _givenComplianceFrancComtoiseCake().moreIngredient(sugar: 25));
    //When
    var output = cakeCompliance.compliance(input);
    //Then
    expect(output.cake.type, CakeType.francComtoise);
  });

  test('should give error when not enough ingredients for ${CakeType.francComtoise}', () {
    //Given
    var input = CakeStep(cake: _givenComplianceFrancComtoiseCake().lessIngredient(butter: 10));
    //When
    var output = cakeCompliance.compliance(input);
    //Then
    expect(output.stepError?.msg, ingredientsMsgError(CakeType.francComtoise));
    expect(output.cake.type, CakeType.unknown);
  });

  test('should give error when not enough ingredients for ${CakeType.frangipane}', () {
    //Given
    var input = CakeStep(cake: _givenComplianceFrangipaneCake().lessIngredient(butter: 10));
    //When
    var output = cakeCompliance.compliance(input);
    //Then
    expect(output.stepError?.msg, ingredientsMsgError(CakeType.frangipane));
    expect(output.cake.type, CakeType.unknown);
  });

  test(
      'should give error when diameter shape not corresponding for ${CakeType.francComtoise} ingredients',
      () {
    //Given
    var input = CakeStep(cake: _givenComplianceFrancComtoiseCake().copyWith(diameterShape: 10));
    //When
    var output = cakeCompliance.compliance(input);
    //Then
    expect(output.stepError?.msg, shapeMsgError);
    expect(output.cake.type, CakeType.unknown);
  });

  test('should give error when diameter shape not corresponding for ${CakeType.frangipane} ingredients',
      () {
    //Given
    var input = CakeStep(cake: _givenComplianceFrangipaneCake().copyWith(diameterShape: 10));
    //When
    var output = cakeCompliance.compliance(input);
    //Then
    expect(output.stepError?.msg, shapeMsgError);
    expect(output.cake.type, CakeType.unknown);
  });
}

Cake _givenComplianceFrancComtoiseCake() => givenFrancComtoiseCake().copyWith(type: CakeType.unknown);

Cake _givenComplianceFrangipaneCake() => givenFrangipaneCake().copyWith(type: CakeType.unknown);

extension on Cake {
  Cake lessIngredient({
    int? butter,
    int? sugar,
    int? eggs,
  }) {
    return copyWith(
        ingredients: ingredients.copyWith(
      butter: ingredients.butter - (butter ?? 0),
      sugar: ingredients.sugar - (sugar ?? 0),
      eggs: ingredients.eggs - (eggs ?? 0),
    ));
  }

  Cake moreIngredient({
    int? butter,
    int? sugar,
    int? eggs,
  }) {
    return copyWith(
        ingredients: ingredients.copyWith(
      butter: ingredients.butter + (butter ?? 0),
      sugar: ingredients.sugar + (sugar ?? 0),
      eggs: ingredients.eggs + (eggs ?? 0),
    ));
  }
}
