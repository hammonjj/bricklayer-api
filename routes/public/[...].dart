import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:mime/mime.dart';

Future<Response> onRequest(RequestContext context, String page) async {
  final file = File('public/$page');
  if (!file.existsSync()) {
    return Response(statusCode: 404);
  }

  final fileBytes = await file.readAsBytes();
  return Response.bytes(
    body: fileBytes,
    headers: {'Content-Type': lookupMimeType(file.path) ?? 'application/octet-stream'},
  );
}
