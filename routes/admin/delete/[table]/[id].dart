import 'dart:async';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/database/database.dart';

Future<Response> onRequest(RequestContext context, String table, String id) async {
  final db = context.read<AppDatabase>();

  try {
    await db.customStatement('DELETE FROM $table WHERE id = ?', [int.parse(id)]);

    return Response(statusCode: 204);
  } catch (e) {
    return Response(statusCode: 500, body: 'Error deleting record - $e');
  }
}
