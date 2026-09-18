import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  MovieDetailsModel({
    required super.id,
    required super.title,
    required super.titleLong,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.likeCount,
    required super.genres,
    required super.description,
    required super.backgroundImage,
    required super.largeCoverImage,
    required super.ytTrailerCode,
    required super.screenshots,
    required super.cast,
    required super.torrents,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      titleLong: json['title_long']?.toString() ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      likeCount: json['like_count'] ?? 0,

      genres: json['genres'] is List
          ? List<String>.from(json['genres'])
          : <String>[],

      description: json['description_full']?.toString() ?? '',
      backgroundImage: json['background_image']?.toString() ?? '',
      largeCoverImage: json['large_cover_image']?.toString() ?? '',
      ytTrailerCode: json['yt_trailer_code']?.toString() ?? '',

      // Screenshots
      screenshots: <String>[
        if (json['large_screenshot_image1'] != null)
          json['large_screenshot_image1'].toString(),

        if (json['large_screenshot_image2'] != null)
          json['large_screenshot_image2'].toString(),

        if (json['large_screenshot_image3'] != null)
          json['large_screenshot_image3'].toString(),
      ],

      // Cast
      cast: json['cast'] is List
          ? (json['cast'] as List)
              .map(
                (item) => CastModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList()
          : <CastModel>[],

      // Torrents
      torrents: json['torrents'] is List
          ? (json['torrents'] as List)
              .map(
                (torrent) => TorrentModel.fromJson(
                  Map<String, dynamic>.from(torrent),
                ),
              )
              .toList()
          : <TorrentModel>[],
    );
  }
}

class CastModel extends CastEntity {
  CastModel({
    required super.name,
    required super.character,
    required super.image,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name']?.toString() ?? '',
      character: json['character_name']?.toString() ?? '',
      image: json['url_small_image']?.toString() ?? '',
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

  factory TorrentModel.fromJson(Map<String, dynamic> json) {
    return TorrentModel(
      url: json['url']?.toString() ?? '',
      quality: json['quality']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      videoCodec: json['video_codec']?.toString() ?? '',
      audioChannels: json['audio_channels']?.toString() ?? '',
      seeds: json['seeds'] ?? 0,
      peers: json['peers'] ?? 0,
      size: json['size']?.toString() ?? '',
    );
  }
}