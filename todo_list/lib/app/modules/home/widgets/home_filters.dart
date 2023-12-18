import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extension.dart';
import 'package:todo_list/app/modules/home/widgets/todo_filter_card.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({super.key});

  @override
  State<HomeFilters> createState() => _GomeFiltersState();
}

class _GomeFiltersState extends State<HomeFilters> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoFilterCard(),
              TodoFilterCard(),
              TodoFilterCard(),
              TodoFilterCard(),
              TodoFilterCard(),
            ],
          ),
        )
      ],
    );
  }
}
