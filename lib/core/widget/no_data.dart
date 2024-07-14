import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataWidget extends StatelessWidget {
  final String title ;
  const NoDataWidget({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/svg/no_data.svg',
            width: 200,
          ),
          SizedBox(height: 10,),
          Text(title)
        ],
      ),
    );
  }
}