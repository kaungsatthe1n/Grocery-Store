import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store/models/grocery_item.dart';
import 'package:intl/intl.dart';

class GroceryTile extends StatelessWidget {
  GroceryTile({
    Key? key,
    required this.item,
    this.onComplete,
  })  : textDecoration =
            item.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
        super(key: key);
  final GroceryItem item;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 5.0, color: item.color),
// 3
          const SizedBox(width: 16.0),
// 4
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// 5
              Text(
                item.name,
                style: GoogleFonts.lato(
                    decoration: textDecoration,
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4.0),
              buildDate(),
              const SizedBox(height: 4.0),
              buildImportance(),
            ],
          ),
          Row(
            children: [
// 7
              Text(
                item.quantity.toString(),
                style: GoogleFonts.lato(
                    decoration: textDecoration, fontSize: 21.0),
              ),
// 8
              buildCheckbox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImportance() {
    if (item.importance == Importance.low) {
      return Text(
        'Low',
        style: GoogleFonts.lato(decoration: textDecoration),
      );
    } else if (item.importance == Importance.medium) {
      return Text(
        'Medium',
        style: GoogleFonts.lato(decoration: textDecoration),
      );
    } else if (item.importance == Importance.high) {
      return Text(
        'High',
        style: GoogleFonts.lato(decoration: textDecoration),
      );
    } else {
      throw Exception('This importance type does not exist');
    }
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(item.date);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }

  Widget buildCheckbox() {
    return Checkbox(
// 1
      value: item.isComplete,
// 2
      onChanged: onComplete,
    );
  }
}
