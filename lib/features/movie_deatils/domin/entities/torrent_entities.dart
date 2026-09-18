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