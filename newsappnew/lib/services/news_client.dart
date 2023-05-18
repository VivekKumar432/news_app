import 'package:http/http.dart' as http;

class NewsClient {
  static Future<http.Response> getNewsByQuery(String query) {
    String URL =
        "https://newsapi.org/v2/everything?q=$query&apiKey=36d6bcaa97b94bc19aed1a91c4e09f31"
        //"https://newsapi.org/v2/everything?q=$query&from=2022-08-10&sortBy=popularity&apiKey=36d6bcaa97b94bc19aed1a91c4e09f31"
        // "https://newsapi.org/v2/top-headlines?sources=$query&apiKey=36d6bcaa97b94bc19aed1a91c4e09f31"
        ;
    Future<http.Response> future = http.get(Uri.parse(URL));
    print(future);
    return future;
  }
}
