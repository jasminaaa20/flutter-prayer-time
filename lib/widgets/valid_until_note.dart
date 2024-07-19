import 'package:flutter/material.dart';

class ValidUntilNote extends StatelessWidget {
  final String endDate;

  const ValidUntilNote({
    super.key,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: Theme.of(context).primaryColorDark,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Until $endDate',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}