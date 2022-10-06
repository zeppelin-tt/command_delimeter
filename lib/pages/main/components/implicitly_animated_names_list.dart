import 'package:command_delimeter/model/person.dart';
import 'package:command_delimeter/pages/main/components/item_transitions.dart';
import 'package:command_delimeter/pages/main/components/list_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

class ImplicitlyAnimatedNamesList extends StatelessWidget {
  final List<Person> names;
  final double separatorSize;
  final double borderRadius;
  final ValueChanged<Person> onDelete;
  final ScrollController scrollController;

  ImplicitlyAnimatedNamesList({
    required this.names,
    required this.separatorSize,
    required this.borderRadius,
    required this.onDelete,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedList<Person>(
      controller: scrollController,
      items: names,
      areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
      removeItemBuilder: (context, animation, person) {
        return ItemTransitions(
          animation: animation,
          slideSide: -1,
          child: ListName(
            person: person,
            onDelete: (person) => onDelete(person),
          ),
        );
      },
      itemBuilder: (context, animation, person, index) {
        return ItemTransitions(
          animation: animation,
          slideSide: 1,
          child: ListName(
            person: person,
            onDelete: (person) => onDelete(person),
          ),
        );
      },
    );
  }
}
