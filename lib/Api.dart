import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyDYdyoHo3sSf9PrZvTtUrWRdAQu4m-vRqo";
const ID_CANAL = "UC02PI4wk4MIw6w107sss_jA";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    http.Response response = await http.get(
      Uri.parse(
        URL_BASE +
            "search"
                "?part=snippet"
                "&type=video"
                "&maxResults=20"
                "&order=date"
                "&key=$CHAVE_YOUTUBE_API"
                "&channelId=$ID_CANAL"
                "&q=$pesquisa",
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson["items"].map<Video>((map) {
        return Video.fromJason(map);
        //return converterJson(map);
      }).toList();
      return videos;

      /*for (var video in dadosJson["items"]) {
        print("Resuldato: " + video.toString());
      }*/

      /* print(
          "resultado: " + dadosJson["items"][1]["snippet"]["title"].toString());*/
    } else {
      return null!;
    }
  }
}
