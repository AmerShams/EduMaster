// ignore_for_file: non_constant_identifier_names, unused_local_variable, file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

SendM(title, message, Tok) async {
  var headersList = {
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer ya29.c.c0ASRK0GZXgPqNg1zx3yprxxqE2SmaC5GBOfLSRihx5rNRxhBuCigSStHsC8Z58IkZzeWH40Yo4HcKVvRH6brzjmdrAC9RTSe9WMfCVEuWGwngVqx__FDgpmj7GX8q36Ax-h9qUuQBkB67-sMRwxWSTjHA1xBsi6z87AFwHgXN_sgC6Ty_VO2v01g3LIrKglAuhwBXcKSEX2-iy5G5DKZNI8COI69vAtmN0dpAxzhbpwr2j5Eel1jWJumiMIqO4j_4Spd_bTQUncTbxTGHbhE_UVC6T_GFuUAdfp6GnIB8pdRZKii0Kl2XzPd7Jw_jQo6fIqqFV4W5RTzNSF6IDOYtdgnKsHyqw6nY3hcvc06h-ht9HzXC4K_2klJYZlcH388C9XOe8a9bQQMbygr9M6rv9bowQnbVSX47qftJvUlhidtgjxI3_tdlJS68ssO1Fb3MSJj9Bu7Uzy7JpSsfad1bgsgfFWUuWO3x3tpIwlBUXJsVYr78V4UscFQplQF49OYa0qngYZ2BIXOo0dRdyibrtwu7ZqZ-8I-QszZ25eqix2yZV0cVYFIWFUj26l3mJoBJ-pOUexOlVFUuwOji03OFX53ViRX53ifqrIZV00r3zXQgSzvfkVJIpRvIyQqOXX4ggMFXvI1t5kM702-Ye1e8gp05vMIcz1frub1uMt3XRxIU9xq7xXlsZ-zoyVtF-3RO9qpJ3WtO4IhxpXaps4u_QgRVZcqIBn7VopFmJBpZ2thsQQR84Y1pjo5peBI2Ynrn6l_Ubswwlku7FdzVYt0-5__rJRmj5MzqpUSJhb_Rfg0zlM0rW0OSknyY1Fhltekqx67g3f8BxJyM-aSo8_Otu5ascz5ix9rQ6VZcJOOYF9WtkRuzeMhxJxR27n7chzp0_F1qS5o6xci2YFbpW2hfggR49VivFrb7s28Fs5vW6nzvXvy76pzVoJoWJ7mVi2o_3fIi5newZQQk7_W77O6e8FB5q2yknukiv03VbBtY'
  };

  var url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/courses-5b9b1/messages:send');
  var body = {
    "message": {
      "token": "$Tok",
      "notification": {
        "title": title,
        "body": message,
      },
      "android": {
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default"
        }
      },
      "apns": {
        "payload": {
          "aps": {"content_available": true}
        }
      },
      "data": {
        "type": "type",
        "id": "userId",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    }
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);
  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode <= 300) {
    // print(resBody);
  } else {
    // print(res.reasonPhrase);
  }
}
