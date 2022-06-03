import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/cake_model.dart';
import '../../bin/service/random_cook_service.dart';

class RandomServiceMock extends Mock implements RandomService {}

main() {

  late RandomCookService randomCookService;
  late RandomService randomServiceMock;

  setUp(() {
    randomServiceMock = RandomServiceMock();
    randomCookService = RandomCookService(randomService: randomServiceMock);
  });

  test('should cook cake type ${CakeType.francComtoise} when random ok', () {
    //Given
    when(() => randomServiceMock.random(randomCookFrancComtoise)).thenReturn(0);
    //When
    var cooked = randomCookService.cookCake(CakeType.francComtoise);
    //Then
    expect(cooked, true, reason: 'randomCookService should cook ${CakeType.francComtoise} when random ok');
  });

  test('should not cook cake type ${CakeType.francComtoise} when random ko', () {
    //Given
    when(() => randomServiceMock.random(randomCookFrancComtoise)).thenReturn(randomCookFrancComtoise - 1);
    //When
    var cooked = randomCookService.cookCake(CakeType.francComtoise);
    //Then
    expect(cooked, false, reason: 'randomCookService should cook ${CakeType.francComtoise} when random ko');
  });

  test('should cook cake type ${CakeType.frangipane} when random ok', () {
    //Given
    when(() => randomServiceMock.random(randomCookFrangipane)).thenReturn(0);
    //When
    var cooked = randomCookService.cookCake(CakeType.frangipane);
    //Then
    expect(cooked, true, reason: 'randomCookService should cook ${CakeType.frangipane} when random ok');
  });

  test('should not cook cake type ${CakeType.frangipane} when random ko', () {
    //Given
    when(() => randomServiceMock.random(randomCookFrangipane)).thenReturn(randomCookFrangipane - 1);
    //When
    var cooked = randomCookService.cookCake(CakeType.frangipane);
    //Then
    expect(cooked, false, reason: 'randomCookService should cook ${CakeType.frangipane} when random ko');
  });

}
