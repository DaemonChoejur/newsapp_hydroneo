import 'package:flutter/material.dart';

class PullWidget extends StatelessWidget {
  const PullWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.25,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: Colors.black12,
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
