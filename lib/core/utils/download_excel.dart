import 'dart:typed_data';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<void> downloadExcelToAppDocs(
  BuildContext context, {
  required String urlOrPath,
  String? fileName, // "Result_123.xlsx"
}) async {
  // Resolve your URL like before (absolute or /api/media/{path})
  String resolve(String path) {
    const base = 'https://d9024ba6d1e0.ngrok-free.app';
    if (path.startsWith('http')) return path;
    if (path.startsWith('/')) return '$base$path';
    return '$base/api/media/$path';
  }

  final url = resolve(urlOrPath);
  try {
    final res = await Dio().get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = Uint8List.fromList(res.data ?? const []);
    if (bytes.isEmpty) throw Exception('File is empty');

    final docsDir = await getApplicationDocumentsDirectory();
    final name = (fileName?.trim().isNotEmpty ?? false)
        ? fileName!.trim()
        : 'AST_Result_${DateTime.now().millisecondsSinceEpoch}.xlsx';
    final fullPath = p.join(docsDir.path, name);

    final out = File(fullPath);
    await out.writeAsBytes(bytes);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved: $fullPath')),
      );
    }
    await OpenFilex.open(fullPath);
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Download failed: $e')));
    }
  }
}
