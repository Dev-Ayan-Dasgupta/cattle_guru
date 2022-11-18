class RoomTileModel{
  final String title;
  final String description;
  final List membersPhotos;
  final List membersNames;
  final DateTime startedOn;

  RoomTileModel({
    required this.title, 
    required this.description, 
    required this.membersPhotos, 
    required this.membersNames,
    required this.startedOn,
  });
}