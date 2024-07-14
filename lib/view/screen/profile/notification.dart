import 'package:flutter/material.dart';

import '../../../core/shared/theming/text_style.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاشعارات',
          style: TextStyles.font18BlackBold,
        ),
      ),
      body: Column(
        children: [
          ItemSwitchingNotification(name: 'الصوت', value: true, onChanged: (v){},),
          ItemSwitchingNotification(name: 'اشعارات عامة', value: true, onChanged: (v){},),
          ItemSwitchingNotification(name: 'تحديث التطبيق', value: true, onChanged: (v){},),
          ItemSwitchingNotification(name: 'نصائح جديدة متاحة', value: true, onChanged: (v){},),
        ],
      ),
    );
  }
}

class ItemSwitchingNotification extends StatelessWidget {
   final String name ;
   final bool value;
   final  void Function(bool)? onChanged;
  const ItemSwitchingNotification({
    super.key, required this.name, required this.value, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(bottom: 20),
      child: SwitchListTile(
          value: value, title: Text(name), onChanged:onChanged),
    );
  }
}
