import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';



class MovieDetailsModel extends MovieDetailsEntity {
  MovieDetailsModel({
    required super.id,
    required super.title,
    required super.titleLong,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.genres,
    required super.description,
    required super.backgroundImage,
    required super.largeCoverImage,
    required super.ytTrailerCode,
    required super.torrents,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleLong: json['title_long'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,

      genres: List<String>.from(
        json['genres'] ?? [],
      ),

      description: json['description_full'] ?? '',

      backgroundImage:
          json['background_image'] ?? '',

      largeCoverImage:
          json['large_cover_image'] ?? '',

      ytTrailerCode:
          json['yt_trailer_code'] ?? '',

      torrents: (json['torrents'] as List? ?? [])
          .map(
            (torrent) => TorrentModel.fromJson(torrent),
          )
          .toList(),
    );
  }
}

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

  factory TorrentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TorrentModel(
      url: json['url'] ?? '',
      quality: json['quality'] ?? '',
      type: json['type'] ?? '',
      videoCodec: json['video_codec'] ?? '',
      audioChannels: json['audio_channels'] ?? '',
      seeds: json['seeds'] ?? 0,
      peers: json['peers'] ?? 0,
      size: json['size'] ?? '',
    );
  }
}