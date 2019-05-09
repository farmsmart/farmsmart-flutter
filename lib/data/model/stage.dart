// Maybe we can separate ui and data model with this class.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/enums.dart';

class CropEntity {
  String name;
  String crop;
  Status status;
  String content;
  String relatedArticles; // TODO proper design on FARM-95

  CropEntity({
    this.name,
    this.crop,
    this.status,
    this.content,
    this.relatedArticles
  });

  factory CropEntity.cropFromDocument(DocumentSnapshot cropDocument) =>
      CropEntity(
        name: cropDocument.data["stageName"],
        crop: cropDocument.data["crop"],
        status: statusValues.map[cropDocument.data["status"]],
        content: cropDocument.data["content"],
        cropsInRotation: extractListOfString(cropDocument, "cropsInRotation"),
        cropType: cropTypeValues.map[cropDocument.data["cropType"]],
        imagePathReference: cropDocument.data["image"].first.path,
        imageUrl: "",
        nonCompanionPlants:
            extractListOfString(cropDocument, "nonCompanionPlants"),
        profitability: extractProfitability(cropDocument),
        setupCost: extractSetupCost(cropDocument),
        soilType: extractListOfString(cropDocument, "soilType"),
        stagesPathReference: extractStagesPaths(cropDocument),
        summary: cropDocument.data["summary"],
        waterRequirement: extractWaterRequirements(cropDocument),
      );

  /*
   ## Image url is referenced from Firebase Storage, thus, needs to be deducted from firestore's Document, asynchronously and then saved.
   */
  void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  void setStages(String stages) {
    this.stages = stages;
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
