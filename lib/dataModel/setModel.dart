class SetModel{
  String id;
  double weight;
  int repetition;
  String exerciseRef;

  SetModel({this.weight, this.repetition, this.exerciseRef});

  SetModel.fromMap(Map snapshot, String id) :
    id = id ?? '',
    weight = snapshot['weight'] ?? 0.0,
    repetition = snapshot['repetition'] ?? 0,
    exerciseRef = snapshot['exerciseRef'] ?? '';

  Map<String, dynamic> toJson(){
    return {
      "weight" : weight,
      "repetition" : repetition,
      "exerciseRef" : exerciseRef,
    };
  }

}