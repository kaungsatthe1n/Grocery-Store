import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store/components/grocery_tile.dart';
import 'package:grocery_store/models/grocery_item.dart';
import 'package:grocery_store/screens/grocery_screen.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(
        hour: date.hour,
        minute: date.minute,
      );
      _dueDate = date;
    }
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('grocery item screen building');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final groceryItem = GroceryItem(
                  id: widget.originalItem?.id ?? const Uuid().v1(),
                  name: _nameController.text,
                  importance: _importance,
                  color: _currentColor,
                  quantity: _currentSliderValue,
                  date: DateTime(
                    _dueDate.year,
                    _dueDate.month,
                    _dueDate.day,
                    _timeOfDay.hour,
                    _timeOfDay.minute,
                  ),
                );
                if (widget.isUpdating) {
// 2
                  widget.onUpdate(groceryItem);
                } else {
// 3
                  widget.onCreate(groceryItem);
                }
              },
              icon: const Icon(Icons.check))
        ],
        title: const Text(
          'Grocery Item',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              buildNameField(),
              const SizedBox(height: 10.0),
              buildImportantField(),
              const SizedBox(height: 10.0),
              buildDateField(context),
              const SizedBox(height: 10.0),
              buildTimePicker(),
              const SizedBox(height: 10.0),
              buildColorPicker(),
              const SizedBox(height: 10.0),
              buildQuantityField(),
              const SizedBox(height: 10.0),
              GroceryTile(
                item: GroceryItem(
                  id: 'previewMode',
                  name: _name,
                  importance: _importance,
                  color: _currentColor,
                  quantity: _currentSliderValue,
                  date: DateTime(
                    _dueDate.year,
                    _dueDate.month,
                    _dueDate.day,
                    _timeOfDay.hour,
                    _timeOfDay.minute,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
              hintText: 'Eg .Apples,Banana, 1 Bag of salt',
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _currentColor),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: _currentColor),
              )),
        ),
      ],
    );
  }

  Widget buildImportantField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
                selectedColor: Colors.blue,
                label: const Text(
                  'low',
                  style: TextStyle(color: Colors.white),
                ),
                selected: _importance == Importance.low,
                onSelected: (_) {
                  setState(() {
                    _importance = Importance.low;
                  });
                }),
            ChoiceChip(
              selectedColor: Colors.blue,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.medium,
              onSelected: (_) {
                setState(() {
                  _importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
                selectedColor: Colors.blue,
                label: const Text(
                  'high',
                  style: TextStyle(color: Colors.white),
                ),
                selected: _importance == Importance.high,
                onSelected: (_) {
                  setState(() {
                    _importance = Importance.high;
                  });
                }),
          ],
        )
      ],
    );
  }

  Widget buildDateField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              onPressed: () async {
                final _currentDate = DateTime.now();
                final _selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _currentDate,
                  firstDate: _currentDate,
                  lastDate: DateTime(_currentDate.year + 5),
                );
                setState(() {
                  if (_selectedDate != null) {
                    _dueDate = _selectedDate;
                  }
                });
              },
              child: const Text('Select'),
            )
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
      ],
    );
  }

  Widget buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of day',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
              child: const Text('Select'),
            )
          ],
        ),
        Text(_timeOfDay.format(context)),
      ],
    );
  }

  Widget buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (color) {
                          setState(() {
                            _currentColor = color;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        )
                      ],
                    ));
          },
          child: const Text('Select'),
        )
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18.0),
            )
          ],
        ),
        Slider(
          value: _currentSliderValue.toDouble(),
          min: 0.0,
          max: 100.0,
          divisions: 100,
          label: _currentSliderValue.toInt().toString(),
          onChanged: (value) {
            setState(() {
              _currentSliderValue = value.toInt();
            });
          },
        )
      ],
    );
  }
}
