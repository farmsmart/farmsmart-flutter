// Maybe we can separate ui and data model with this class.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:farmsmart_flutter/model/enums.dart';
import 'package:farmsmart_flutter/data/model/entities_const.dart';

class CropEntity {
  List<String> companionPlants;
  CropComplexity complexity;
  String content;
  List<String> cropsInRotation;
  CropType cropType;
  String imagePathReference;
  String imageUrl;
  String name;
  List<String> nonCompanionPlants;
  LoHi profitability;
  LoHi setupCost;
  List<String> soilType;
  List<StageEntity> stages;
  List<String> stagesPathReference;
  Status status;
  String summary;
  LoHi waterRequirement;

  CropEntity({
    this.companionPlants,
    this.complexity,
    this.content,
    this.cropsInRotation,
    this.cropType,
    this.imagePathReference,
    this.imageUrl,
    this.name,
    this.nonCompanionPlants,
    this.profitability,
    this.setupCost,
    this.soilType,
    this.stages,
    this.stagesPathReference,
    this.status,
    this.summary,
    this.waterRequirement,
  });

  factory CropEntity.cropFromDocument(DocumentSnapshot cropDocument) =>
      CropEntity(
        companionPlants: extractListOfString(cropDocument, COMPANION_PLANTS),
        complexity: extractComplexity(cropDocument),
        content: (cropDocument.data[CONTENT] != null) ? cropDocument.data[CONTENT] : "",
        cropsInRotation: extractListOfString(cropDocument, CROP_ROTATION),
        cropType: cropTypeValues.map[cropDocument.data[CROP_TYPE]],
        imagePathReference: cropDocument.data[IMAGE].first.path,
        imageUrl: "",
        name: cropDocument.data[NAME],
        nonCompanionPlants:
            extractListOfString(cropDocument, NONCOMPANION_PLANTS),
        profitability: extractProfitability(cropDocument),
        setupCost: extractSetupCost(cropDocument),
        soilType: extractListOfString(cropDocument, SOIL_TYPE),
        stages: List(),
        stagesPathReference: extractStagesPaths(cropDocument),
        status: statusValues.map[cropDocument.data[STATUS]],
        summary: cropDocument.data[SUMMARY],
        waterRequirement: extractWaterRequirements(cropDocument),
      );

  /*
   ## Image url is referenced from Firebase Storage, thus, needs to be deducted from firestore's Document, asynchronously and then saved.
   */
  void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  void addStage(StageEntity stage) {
    this.stages.add(stage);
  }
}


List<String> extractListOfString(
    DocumentSnapshot document, String valueToBeExtracted) {
  if (document.data[valueToBeExtracted] != null && document.data[valueToBeExtracted] != "") {
    return List<String>.from(document.data[valueToBeExtracted].map((value) => value));
  }
  return null;
}

List<String> extractStagesPaths(DocumentSnapshot document) {
  if (document.data[STAGES] != null) {
    return List<String>.from(
        document.data[STAGES].map((stage) => stage[CROP_STAGE].path));
  }
  return null;
}

CropComplexity extractComplexity(DocumentSnapshot document) {
  if (document.data[COMPLEXITY] != null) {
    return begAdvValues.map[document.data[COMPLEXITY]];
  }
  return null;
}

LoHi extractProfitability(DocumentSnapshot document) {
  if (document.data[PROFITABILITY] != null) {
    return loHiValues.map[document.data[PROFITABILITY]];
  }
  return null;
}

LoHi extractSetupCost(DocumentSnapshot document) {
  if (document.data[SETUP_COST] != null) {
    return loHiValues.map[document.data[SETUP_COST]];
  }
  return null;
}

LoHi extractWaterRequirements(DocumentSnapshot document) {
  if (document.data[WATER_REQUIREMENT] != null) {
    return loHiValues.map[document.data[WATER_REQUIREMENT]];
  }
  return null;
}
