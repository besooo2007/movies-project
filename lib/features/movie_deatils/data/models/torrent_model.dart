import 'package:app/features/movie_deatils/domin/entities/torrent_entities.dart';



class TorrentModel extends TorrentEntity {
  TorrentModel({
    required super.url,
    required super.quality,
    required super.type,
    required super.videoCodec,
    required super.audioChannels,
    required super.seeds,
    required super.peers,
    required super.size,
  });

  factory TorrentModel.fromJson(Map<String, dynamic> json) {
    return TorrentModel(
      url: json['url'],
      quality: json['quality'],
      type: json['type'],
      videoCodec: json['video_codec'],
      audioChannels: json['audio_channels'],
      seeds: json['seeds'],
      peers: json['peers'],
      size: json['size'],
    );
  }
}