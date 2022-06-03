
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/cake_model.dart';
import '../../bin/service/cooking_service.dart';
import '../../bin/service/random_cook_service.dart';
import '../../bin/steps/cake_cooking.dart';
import '../fixtures.dart';

class RandomCookServiceMock extends Mock implements RandomCookService {}

main() {
  late CakeCooking cooking;
  late CookingService cookServiceMock;

  setUp(() {
    cookServiceMock = RandomCookServiceMock();
    cooking = CakeCooking(cookService: cookServiceMock);
  });

  test('should cook cake type ${CakeType.francComtoise}', () {
    //Given
    var input = CakeStep(cake: givenFrancComtoiseCake());
    when(() => cookServiceMock.cookCake(CakeType.francComtoise)).thenReturn(true);
    //When
    var output = cooking.cook(input);
    //Then
    expect(output.cake.cooked, true, reason: 'cake type ${CakeType.francComtoise} cooked should be true');
    verify(() => cookServiceMock.cookCake(CakeType.francComtoise));
    verifyNever(() => cookServiceMock.cookCake(CakeType.frangipane));
  });

  test('should cook cake type ${CakeType.frangipane}', () {
    //Given
    var input = CakeStep(cake: givenFrangipaneCake());
    when(() => cookServiceMock.cookCake(CakeType.frangipane)).thenReturn(true);
    //When
    var output = cooking.cook(input);
    //Then
    expect(output.cake.cooked, true, reason: 'cake type ${CakeType.frangipane} cooked should be true');
    verify(() => cookServiceMock.cookCake(CakeType.frangipane));
    verifyNever(() => cookServiceMock.cookCake(CakeType.francComtoise));
  });

  test('should not cook cake type ${CakeType.unknown}', () {
    //Given
    var input = CakeStep(cake: givenFrangipaneCake().copyWith(type: CakeType.unknown));
    //When
    var output = cooking.cook(input);
    //Then
    expect(output.stepError?.msg, cookingCakeMsgError);
    expect(output.cake.cooked, false, reason: 'cake type ${CakeType.unknown} cooked should be false');
    verifyNever(() => cookServiceMock.cookCake(CakeType.frangipane));
    verifyNever(() => cookServiceMock.cookCake(CakeType.francComtoise));
  });

  test('should not cook cake type ${CakeType.francComtoise} when $RandomCookService fail', () {
    //Given
    var input = CakeStep(cake: givenFrancComtoiseCake());
    when(() => cookServiceMock.cookCake(CakeType.francComtoise)).thenReturn(false);
    //When
    var output = cooking.cook(input);
    //Then
    expect(output.stepError?.msg, cookingCakeTypeMsgError(CakeType.francComtoise));
    expect(output.cake.cooked, false, reason: 'cake type ${CakeType.francComtoise} cooked should be false');
    verify(() => cookServiceMock.cookCake(CakeType.francComtoise));
    verifyNever(() => cookServiceMock.cookCake(CakeType.frangipane));
  });

  test('should not cook cake type ${CakeType.frangipane} when $RandomCookService fail', () {
    //Given
    var input = CakeStep(cake: givenFrangipaneCake());
    when(() => cookServiceMock.cookCake(CakeType.frangipane)).thenReturn(false);
    //When
    var output = cooking.cook(input);
    //Then
    expect(output.stepError?.msg, cookingCakeTypeMsgError(CakeType.frangipane));
    expect(output.cake.cooked, false, reason: 'cake type ${CakeType.frangipane} cooked should be false');
    verify(() => cookServiceMock.cookCake(CakeType.frangipane));
    verifyNever(() => cookServiceMock.cookCake(CakeType.francComtoise));
  });

}
