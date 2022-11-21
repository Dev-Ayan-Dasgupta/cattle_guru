class AudioRoomModel{
  final String createdBy;
  final String roomName;
  final String roomDescription;
  final List membersNames;
  final List membersPhotos;
  final DateTime startedAt;

  AudioRoomModel({
    required this.createdBy, 
    required this.roomName, 
    required this.roomDescription, 
    required this.membersNames,
    required this.membersPhotos,
    required this.startedAt,
  });

  Map<String, dynamic> toMap(){
    return {
      "createdBy": createdBy,
      "roomName": roomName,
      "roomDescription": roomDescription,
      "membersNames": membersNames,
      "membersPhotos": membersPhotos,
      "startedAt": startedAt,
    };
  }
}