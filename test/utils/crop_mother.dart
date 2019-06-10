import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/enums.dart';

class CropMother {
  CropEntity get crop {
    return CropEntity(
        companionPlants: ['Maize, Cowpeas'],
        complexity: CropComplexity.ADVANCED,
        content: 'Content Ipsum',
        cropsInRotation: ['Tomatoes', 'Okra'],
        cropType: CropType.ROTATION,
        imagePathReference: '/sized/360/image.png',
        imageUrl: Future.value(null),
        name: 'Crop Rotation A',
        nonCompanionPlants: ['Onions', 'Cabbage'],
        profitability: LoHi.HIGH,
        setupCost: LoHi.LOW,
        soilType: ['Loamy', 'Volcanic'],
        stages: List(),
        stagesPathReference: ['stage/path'],
        status: Status.PUBLISHED,
        summary: 'Summary Ipsum',
        waterRequirement: LoHi.MEDIUM);
  }
}
