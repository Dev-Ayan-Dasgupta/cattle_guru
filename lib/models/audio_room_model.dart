class AudioRoomModel{
  final String createdBy;
  final String roomName;
  final String roomDescription;
  final List membersNames;
  final List membersPhotos;
  final List membersUids;
  final DateTime startedAt;

  AudioRoomModel({
    required this.createdBy, 
    required this.roomName, 
    required this.roomDescription, 
    required this.membersNames,
    required this.membersPhotos,
    required this.membersUids,
    required this.startedAt,
  });

  Map<String, dynamic> toMap(){
    return {
      "createdBy": createdBy,
      "roomName": roomName,
      "roomDescription": roomDescription,
      "membersNames": membersNames,
      "membersPhotos": membersPhotos,
      "currentUserIds": membersUids,
      "startedAt": startedAt,
    };
  }
}