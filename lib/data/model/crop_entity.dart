// Maybe we can separate ui and data model with this class.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/enums.dart';

class CropEntity {
  List<String> companionPlants;
  CropComplexity complexity;
  String content;
  List<String> cropsInRotation;
  CropType cropType;
  String image; // TODO Update when images are needed
  String name;
  List<String> nonCompanionPlants;
  LoHi profitability;
  LoHi setupCost;
  List<String> soilType;
  String stages; // TODO Update when stages are needed
  Status status;
  String summary;
  LoHi waterRequirement;

  CropEntity({
    this.companionPlants,
    this.complexity,
    this.content,
    this.cropsInRotation,
    this.cropType,
    this.image,
    this.name,
    this.nonCompanionPlants,
    this.profitability,
    this.setupCost,
    this.soilType,
    this.stages,
    this.status,
    this.summary,
    this.waterRequirement,
  });

//  CropEntity.cropFromDocument(DocumentSnapshot cropDocument) {
//    summary = cropDocument.data["summary"];
//    imagePath = getImageFromPath(cropDocument.data["image"]);
//    relatedArticles = cropDocument.data["relatedArticles"]
//        .toString(); // TODO Treated as a string until we need to develop articles
//    id = cropDocument.data["id"];
//    title = cropDocument.data["title"];
//    content = cropDocument.data["content"];
//    status = Status.values.firstWhere(
//        (value) => value.toString() == "Status." + cropDocument.data["status"],
//        orElse: () => null); // Tricky but didnt find another solution
//  }


  factory CropEntity.cropFromDocument(DocumentSnapshot cropDocument) => new CropEntity(
    companionPlants: cropDocument.data["companionPlants"] == null ? null : new List<String>.from(cropDocument.data["companionPlants"].map((x) => x)),
    complexity: cropDocument.data["complexity"] == null ? null : begAdvValues.map[cropDocument.data["complexity"]],
    content: cropDocument.data["content"],
    cropsInRotation: cropDocument.data["cropsInRotation"] == null ? null : new List<String>.from(cropDocument.data["cropsInRotation"].map((x) => x)),
    cropType: cropTypeValues.map[cropDocument.data["cropType"]],
    image: "",
    name: cropDocument.data["name"],
    nonCompanionPlants: cropDocument.data["nonCompanionPlants"] == null ? null : new List<String>.from(cropDocument.data["nonCompanionPlants"].map((x) => x)),
    profitability: cropDocument.data["profitability"] == null ? null : loHiValues.map[cropDocument.data["profitability"]],
    setupCost: cropDocument.data["setupCost"] == null ? null : loHiValues.map[cropDocument.data["setupCost"]],
    soilType: cropDocument.data["soilType"] == null ? null : new List<String>.from(cropDocument.data["soilType"].map((x) => x)),
    stages: "",
    status: statusValues.map[cropDocument.data["status"]],
    summary: cropDocument.data["summary"],
    waterRequirement: cropDocument.data["waterRequirement"] == null ? null : loHiValues.map[cropDocument.data["waterRequirement"]],
  );
}


String getImageFromPath(data) {
  String image = "";
  if (data != null) {
    data[0].get().then((snapshot) {
      image = snapshot.toString();
    });
  }
  return image;
}
