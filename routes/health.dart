import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  if (context.request.method == HttpMethod.get) {
    return _get(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Response _get(RequestContext context) {
  return Response.json(body: jsonEncode({'health': 'ok'}));
}
