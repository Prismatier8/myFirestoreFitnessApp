class SetModel{
  String id;
  int sequence;
  double weight;
  int repetition;
  String exerciseRef;

  SetModel({this.weight, this.repetition, this.exerciseRef, this.sequence});

  SetModel.fromMap(Map<String, dynamic> snapshot) :
    weight = snapshot['weight'] ?? 0.0,
    repetition = snapshot['repetition'] ?? 0,
    exerciseRef = snapshot['exerciseRef'] ?? '',
    sequence = snapshot['sequence'] ?? 0;

  Map<String, dynamic> toJson(){
    return {
      "weight" : weight,
      "repetition" : repetition,
      "exerciseRef" : exerciseRef,
      "sequence" : sequence,
    };
  }

}