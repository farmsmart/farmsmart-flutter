// Maybe we can separate ui and data model with this class.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/model/stage.dart';
import 'package:farmsmart_flutter/model/enums.dart';

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
  List<Stage> stages;
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
        companionPlants: extractListOfString(cropDocument, "companionPlants"),
        complexity: extractComplexity(cropDocument),
        content: cropDocument.data["content"],
        cropsInRotation: extractListOfString(cropDocument, "cropsInRotation"),
        cropType: cropTypeValues.map[cropDocument.data["cropType"]],
        imagePathReference: cropDocument.data["image"].first.path,
        imageUrl: "",
        name: cropDocument.data["name"],
        nonCompanionPlants:
            extractListOfString(cropDocument, "nonCompanionPlants"),
        profitability: extractProfitability(cropDocument),
        setupCost: extractSetupCost(cropDocument),
        soilType: extractListOfString(cropDocument, "soilType"),
        stages: List(),
        stagesPathReference: extractStagesPaths(cropDocument),
        status: statusValues.map[cropDocument.data["status"]],
        summary: cropDocument.data["summary"],
        waterRequirement: extractWaterRequirements(cropDocument),
      );

  /*
   ## Image url is referenced from Firebase Storage, thus, needs to be deducted from firestore's Document, asynchronously and then saved.
   */
  void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  void addStage(Stage stage) {
    this.stages.add(stage);
  }
}

List<String> extractListOfString(
    DocumentSnapshot document, String valueToBeExtracted) {
  if (document.data[valueToBeExtracted] != null) {
    return List<String>.from(document.data[valueToBeExtracted].map((x) => x));
  }
  return null;
}

List<String> extractStagesPaths(DocumentSnapshot document) {
  if (document.data["stages"] != null) {
    return List<String>.from(
        document.data["stages"].map((x) => x["cropStage"].path));
  }
  return null;
}

CropComplexity extractComplexity(DocumentSnapshot document) {
  if (document.data["complexity"] != null) {
    return begAdvValues.map[document.data["complexity"]];
  }
  return null;
}

LoHi extractProfitability(DocumentSnapshot document) {
  if (document.data["profitability"] != null) {
    return loHiValues.map[document.data["profitability"]];
  }
  return null;
}

LoHi extractSetupCost(DocumentSnapshot document) {
  if (document.data["setupCost"] != null) {
    return loHiValues.map[document.data["setupCost"]];
  }
  return null;
}

LoHi extractWaterRequirements(DocumentSnapshot document) {
  if (document.data["waterRequirement"] != null) {
    return loHiValues.map[document.data["waterRequirement"]];
  }
  return null;
}
