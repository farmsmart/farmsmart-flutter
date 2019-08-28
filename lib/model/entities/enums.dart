enum CropComplexity { BEGINNER, INTERMEDIATE, ADVANCED, UNDEFINED }

final begAdvValues = EnumValues({
  "ADVANCED": CropComplexity.ADVANCED,
  "BEGINNER": CropComplexity.BEGINNER,
  "INTERMEDIATE": CropComplexity.INTERMEDIATE
});

enum CropType { SINGLE, ROTATION }

final cropTypeValues =
    EnumValues({"ROTATION": CropType.ROTATION, "SINGLE": CropType.SINGLE});

enum LoHi { LOW, MEDIUM, HIGH, UNDEFINED }

final loHiValues =
    EnumValues({"HIGH": LoHi.HIGH, "LOW": LoHi.LOW, "MEDIUM": LoHi.MEDIUM});

enum Status { DRAFT, PUBLISHED }

final statusValues =
    EnumValues({"DRAFT": Status.DRAFT, "PUBLISHED": Status.PUBLISHED});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
