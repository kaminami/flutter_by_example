import 'package:youtube_explode_example/youtube_explode_example.dart' as yt;

void main(List<String> arguments) async {
  await yt.retrieveChannelData();
  await yt.retrieveChannelVideoDataList();
  await yt.retrieveVideoData(); 
}
