class BandModel {
  String id;
  String name;
  int votes;

  BandModel({
    this.id,
    this.name,
    this.votes
  });

  factory BandModel.fromMap( Map<String, dynamic> obj)
    => BandModel(
      id: obj['id'],
      name: obj['name'],
      votes: obj['votes']
    );

}