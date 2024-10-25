import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/database/database.dart';

Future<Response> onRequest(RequestContext context, String table) async {
  final db = context.read<AppDatabase>();

  final data = await _fetchTableData(db, table);

  final headers = data.isNotEmpty ? data.first.keys.map((key) => '<th>$key</th>').join() : '<th>No Data</th>';
  final rows = data.isNotEmpty
      ? data.map((row) {
          final id = row['id'];
          final rowData = row.values.map((value) => '<td>$value</td>').join();
          return '''
            <tr>
              $rowData
              <td>
                <button onclick="confirmDelete('$table', $id)">Delete</button>
              </td>
            </tr>
          ''';
        }).join()
      : '<tr><td>No Data Available</td></tr>';

  final templateFile = File('public/table_template.html');
  final templateContent = await templateFile.readAsString();
  final html = templateContent
      .replaceAll('{{table_name}}', table)
      .replaceAll('{{table_headers}}', headers)
      .replaceAll('{{table_rows}}', rows);

  return Response(body: html, headers: {'Content-Type': 'text/html'});
}

Future<List<Map<String, dynamic>>> _fetchTableData(AppDatabase db, String table) async {
  try {
    final result = await db.customSelect('SELECT * FROM $table').get();
    return result.map((row) => row.data).toList();
  } catch (e) {
    return [];
  }
}
