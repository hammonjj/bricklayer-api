// ignore_for_file: avoid_dynamic_calls, strict_raw_type

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final configFile = File('admin_config.json');
  final configContent = await configFile.readAsString();
  final config = jsonDecode(configContent) as Map<String, dynamic>;

  final templateFile = File('public/admin_template.html');
  final templateContent = await templateFile.readAsString();

  final sectionsHtml = _generateSectionsHtml(config['sections'] as List);
  final html = templateContent.replaceAll('{{sections}}', sectionsHtml);

  return Response(body: html, headers: {'Content-Type': 'text/html'});
}

String _generateSectionsHtml(List sections) {
  return sections.map((section) {
    final sectionName = section['name'];
    final tableList = (section['tables'] as List).map((table) {
      return '<li><a href="/admin/$table">$table</a></li>';
    }).join();

    return '''
      <div class="section">
        <div class="section-header">$sectionName</div>
        <ul class="table-list">$tableList</ul>
      </div>
    ''';
  }).join();
}
