class MovieDetailsEntity {
  final int id;
  final String title;
  final String titleLong;
  final int year;
  final double rating;
  final int runtime;
  final int likeCount;
  final List<String> genres;
  final String description;

  final String backgroundImage;
  final String largeCoverImage;
  final String ytTrailerCode;

  final List<String> screenshots;
  final List<CastEntity> cast;

  final List<TorrentEntity> torrents;

  MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.likeCount,
    required this.genres,
    required this.description,
    required this.backgroundImage,
    required this.largeCoverImage,
    required this.ytTrailerCode,
    required this.screenshots,
    required this.cast,
    required this.torrents,
  });
}

class CastEntity {
  final String name;
  final String character;
  final String image;

  CastEntity({
    required this.name,
    required this.character,
    required this.image,
  });
}

class TorrentEntity {
  final String url;
  final String quality;
  final String type;
  final String videoCodec;
  final String audioChannels;
  final int seeds;
  final int peers;
  final String size;

  TorrentEntity({
    required this.url,
    required this.quality,
    required this.type,
    required this.videoCodec,
    required this.audioChannels,
    required this.seeds,
    required this.peers,
    required this.size,
  });
}