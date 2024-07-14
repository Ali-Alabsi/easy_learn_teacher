import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewDataForFireBaseWithLoading extends StatelessWidget {
  final Future<Object?>? future;
  final  Widget Function(dynamic)? widgetView;
  const ViewDataForFireBaseWithLoading({
    super.key, required this.future, required this.widgetView,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return widgetView!(snapshot);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}