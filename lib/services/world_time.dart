import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {

  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint

  WorldTime( this.location, this.flag, this.url , this.time );

  Future<void> getTime() async {
    try{
    Uri uri = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
    // make the request
    http.Response response = await http.get(uri);
    Map data = jsonDecode(response.body);

    // get properties from json
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);

    // create DateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    print(now);

    // set the time property
    this.time = now.toString();

    }catch(e){
        print(e);
    }
  }

}

