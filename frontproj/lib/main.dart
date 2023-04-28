import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtém o diretório de documentos do dispositivo
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  // Copia o arquivo db.sqlite3 da pasta de ativos para o diretório de documentos
  final dbAssetPath = await rootBundle.load('assets/database/db.sqlite3');
  final dbPath = path.join(appDocumentDir.path, 'db.sqlite3');
  final dbFile = File(dbPath);
  await dbFile.writeAsBytes(dbAssetPath.buffer.asUint8List(), flush: true);

  // Inicializa o Hive e abre a caixa
  Hive.init(appDocumentDir.path);
  await Hive.openBox('hello_post');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Post',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final String boxName = 'hello_post';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Post'),
      ),
      body: FutureBuilder(
        future: Hive.openBox(boxName),
        builder: (BuildContext context, AsyncSnapshot<Box> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error.toString()}'),
              );
            } else {
              final postsBox = Hive.box(boxName);
              final posts = postsBox.values.toList();
              if (posts.isEmpty) {
                return Center(
                  child: Text('Não há posts'),
                );
              } else {
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = posts[index];
                    return ListTile(
                      title: Text(post['title']),
                      subtitle: Text(post['body']),
                    );
                  },
                );
              }
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
