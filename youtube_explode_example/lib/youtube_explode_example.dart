import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<void> retrieveChannelData() async {
  final channelId = "UCmKlo3BXt60nzgk2r_JgvwQ"; // 有隣堂しか知らない世界

  final yt = YoutubeExplode();
  final about = await yt.channels.getAboutPage(channelId);

  print("### retrieveChannelData");
  print("title:${about.title}, viewCount:${about.viewCount}");
  about.thumbnails.forEach((element) {
    print("thumnbail: $element");
  });

  yt.close();
}

Future<void> retrieveChannelVideoDataList() async {
  final channelId = "UCmKlo3BXt60nzgk2r_JgvwQ"; // 有隣堂しか知らない世界

  final yt = YoutubeExplode();
  final videoList = await yt.channels.getUploads(channelId).toList();

  print("### retrieveChannelVideosData");

  videoList.asMap().forEach((int i, video) {
    print("$i, url:${video.url}, title:${video.title}, duration:${video.duration}, publishDate:${video.publishDate} views:${video.engagement.viewCount}");
  });

  yt.close();
}

Future<void> retrieveVideoData() async {
  final videoId = 'joXAMsm9u7k'; // 超性能ティッシュ】キレイの概念が変わる！キムワイプの世界～有隣堂しか知らない世界001～

  final yt = YoutubeExplode();
  final video = await yt.videos.get(videoId);

  print("### retrieveVideoData");
  print("url:${video.url}, title:${video.title}, duration:${video.duration}, publishDate:${video.publishDate} views:${video.engagement.viewCount}");

  yt.close();
}
