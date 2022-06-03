
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/cake_model.dart';
import '../../bin/service/random_cook_service.dart';
import '../../bin/steps/cake_price_calculator.dart';
import '../fixtures.dart';

class RandomCookServiceMock extends Mock implements RandomCookService {}

main() {
  late CakePriceCalculator calculator;

  setUp(() {
    calculator = CakePriceCalculator();
  });

  test('should calculate price when cake cooked and type ${CakeType.francComtoise}', () {
    //Given
    var input = CakeStep(cake: givenFrancComtoiseCake().copyWith(cooked: true));
    //When
    var output = calculator.calculatePrice(input);
    //Then
    expect(output.cake.price, priceFrancComtoiseCake);
  });

  test('should not calculate price when cake not cooked and type ${CakeType.francComtoise}', () {
    //Given
    var input = CakeStep(cake: givenFrancComtoiseCake().copyWith(cooked: false));
    //When
    var output = calculator.calculatePrice(input);
    //Then
    expect(output.cake.price, 0.0);
    expect(output.stepError?.msg, priceCakeNotCookedMsgError);
  });

  test('should calculate price when cake cooked and type ${CakeType.frangipane}', () {
    //Given
    var input = CakeStep(cake: givenFrangipaneCake().copyWith(cooked: true));
    //When
    var output = calculator.calculatePrice(input);
    //Then
    expect(output.cake.price, priceFrangipaneCake);
  });

  test('should not calculate price when cake not cooked and type ${CakeType.frangipane}', () {
    //Given
    var input = CakeStep(cake: givenFrangipaneCake().copyWith(cooked: false));
    //When
    var output = calculator.calculatePrice(input);
    //Then
    expect(output.cake.price, 0.0);
    expect(output.stepError?.msg, priceCakeNotCookedMsgError);
  });

  test('should not calculate price when cake cooked and type ${CakeType.unknown}', () {
    //Given
    var input = CakeStep(cake: givenFrangipaneCake().copyWith(type: CakeType.unknown, cooked: true));
    //When
    var output = calculator.calculatePrice(input);
    //Then
    expect(output.cake.price, 0.0);
    expect(output.stepError?.msg, priceCakeMsgError);
  });

  test('should not calculate price when cake not cooked and type ${CakeType.unknown}', () {
    //Given
    var input = CakeStep(cake: givenFrangipaneCake().copyWith(type: CakeType.unknown, cooked: false));
    //When
    var output = calculator.calculatePrice(input);
    //Then
    expect(output.cake.price, 0.0);
    expect(output.stepError?.msg, priceCakeMsgError);
  });


}
