import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grizzly_io/io_loader.dart' as loader;

late List<Map<String, dynamic>> propertyMaps;

Future<void> loadTsv() async {
  final tsvString = await rootBundle.loadString('assets/tsv/quoted.tsv');
  final tsv = loader.parseLTsv(tsvString);

  propertyMaps = tsv.toMap().toList();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadTsv();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TSV Reading Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TSV Reading Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Table(
        border: TableBorder.all(
          color: Colors.black26,
        ),
        children: [
          for (final propertyMap in propertyMaps) _buildTableRow(propertyMap),
        ],
      ),
    );
  }

  TableRow _buildTableRow(Map<String, dynamic> propertyMap) {
    return TableRow(
      children: [
        _buildTableCell(propertyMap['House']),
        _buildTableCell(propertyMap['Name']),
        _buildTableCell(propertyMap['Age']),
      ],
    );
  }

  TableCell _buildTableCell(dynamic value) {
    return TableCell(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text("$value"),
      ),
    );
  }
}
