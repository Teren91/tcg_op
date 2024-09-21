import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final Function(List<String>, double, double, String, String) onApplyFilters;
  const FilterWidget({super.key, required this.onApplyFilters});
 

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}
class _FilterWidgetState extends State<FilterWidget> {
  final List<Map<String, dynamic>> colorOptions = [
    {"name": "black", "color": Colors.black},
    {"name": "red", "color": Colors.red},
    {"name": "green", "color": Colors.green},
    {"name": "yellow", "color": Colors.yellow},
    {"name": "blue", "color": Colors.blue},
    {"name": "purple", "color": Colors.purple},
  ];

  List<String> colorFilter = [];
  double costFilter = 0;
  double powerFilter = 0;
  String codeFilter = "";
  String nameFilter = "";

  void handleColorChange(String color) {
    setState(() {
      if (colorFilter.contains(color)) {
        colorFilter.remove(color);
      } else {
        colorFilter.add(color);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,                
                children: colorOptions.map((color) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(color['name'][0].toUpperCase()),
                      selected: colorFilter.contains(color['name']),
                      onSelected: (_) => handleColorChange(color['name']),
                      backgroundColor: color['color'],
                      selectedColor: color['color'],
                      labelStyle: const TextStyle(color: Colors.white),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Cost:', style: TextStyle(fontSize: 14)),
                Expanded(
                  child: Slider(
                    value: costFilter,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: costFilter.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        costFilter = value;
                      });
                    },
                  ),
                ),
                Text('${costFilter.round()}', style: const TextStyle(fontSize: 14)),
              ],
            ),
            Row(
              children: [
                const Text('Power:', style: TextStyle(fontSize: 14)),
                Expanded(
                  child: Slider(
                    value: powerFilter,
                    min: 0,
                    max: 15000,
                    divisions: 15,
                    label: powerFilter.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        powerFilter = value;
                      });
                    },
                  ),
                ),
                Text('${powerFilter.round()}', style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    onChanged: (value) {
                      setState(() {
                        nameFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Code',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    onChanged: (value) {
                      setState(() {
                        codeFilter = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApplyFilters(colorFilter, costFilter, powerFilter, codeFilter, nameFilter);
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}