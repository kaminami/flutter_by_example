import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reading Excel File Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Reading Excel File Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Sheet sheet;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    ByteData data = await rootBundle.load("assets/excel/example.xlsx");
    final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final excel = Excel.decodeBytes(bytes);

    sheet = excel.sheets['Sheet1']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(
            color: Colors.black26,
          ),
          children: [for (int rowIndex = 0; rowIndex < sheet.rows.length; rowIndex++) _buildTableRow(sheet.rows[rowIndex], rowIndex)],
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<Data?> row, int rowIndex) {
    return TableRow(
      children: [
        for (int i = 0; i < row.length; i++)
          TableCell(
            child: Container(
              color: (rowIndex == 0) ? Colors.lightGreen : Colors.white,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: Text("${row[i]!.value}"),
            ),
          ),
      ],
    );
  }
}
