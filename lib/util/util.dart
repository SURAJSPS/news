import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/headline_model.dart';



class HeadingUtil {
  static List<Headlines> headLineList = [];

  static Future<List<Headlines>?> fetchHeadLines() async {
    
    try {
      String url =
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=bce363eec9924b0abbd073fdd6fdd983';
      final response = await http.get(Uri.parse(url));
      
      var data = jsonDecode(response.body);
      
      List<dynamic> list = data["articles"]
          .map((result) => new Headlines.fromJson(result))
          .toList();
      headLineList.clear();
      for (int b = 0; b < list.length; b++) {
        Headlines headLinetModel = list[b] as Headlines;
        headLineList.add(headLinetModel);
        
      }
     
      return headLineList;
    } catch (e) {
      print("Exception________$e");
    }
  }

  static Future<List<Headlines>?> filter({
    String? fromDate,
    String? toDate,
    String? sortBy,
    String? lang,
  }) async {
    try {
      

      String url = 'https://newsapi.org/v2/everything?q=apple&from=' +
          // ignore: unnecessary_brace_in_string_interps
          '${fromDate}' +
          '&to=' +
          // ignore: unnecessary_brace_in_string_interps
          '${toDate}' +
          '&language=' +
          // ignore: unnecessary_brace_in_string_interps
          '${lang}' +
          '&sortBy=' +
          // ignore: unnecessary_brace_in_string_interps
          '${sortBy}' +
          '&apiKey=bce363eec9924b0abbd073fdd6fdd983';

      final response = await http.get(Uri.parse(url));

      var data = jsonDecode(response.body);
      List<dynamic> list = data["articles"]
          .map((result) => new Headlines.fromJson(result))
          .toList();
      headLineList.clear();
      for (int b = 0; b < list.length; b++) {
        Headlines everyThingModel = list[b] as Headlines;
        headLineList.add(everyThingModel);
      }

      return headLineList;
    } catch (e) {
      print("Exception________$e");
    }
  }
}
