import 'package:flutter/material.dart';

class ElementsList extends StatefulWidget {
  ElementsList({Key key}) : super(key: key);
  List elements;

  @override
  State<ElementsList> createState() => _ElementsListState();

  Widget buildListElement(BuildContext context, var element, int index) {}
}

class _ElementsListState extends State<ElementsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: this.widget.elements.length,
      itemBuilder: (BuildContext context, int index) {
        return this
            .widget
            .buildListElement(context, this.widget.elements[index], index);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

Widget buildListElementBase(Widget text, Function onEdit, Function onRemove,
    {Color color = Colors.blue}) {
  List<Widget> actions = [];
  if (onEdit != null) {
    actions.add(IconButton(
        icon: Icon(Icons.edit), color: Colors.black, onPressed: onEdit));
  }
  if (onRemove != null) {
    actions.add(IconButton(
      icon: Icon(Icons.delete),
      color: Colors.black,
      onPressed: onRemove,
    ));
  }
  return Container(
    height: 50,
    color: color,
    child: Align(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(padding: EdgeInsets.all(8.0), child: text),
      Padding(padding: EdgeInsets.all(8.0), child: Row(children: actions))
    ])),
    alignment: Alignment.centerRight,
  );
}
