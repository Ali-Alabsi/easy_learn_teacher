// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controller/add_controller.dart';
//
// class TeastDrop extends StatelessWidget {
//   TeastDrop({Key? key}) : super(key: key);
//
//   // final List<String> genderItems = [
//   //   'Male',
//   //   'Female',
//   // ];
//
//   String? selectedValue;
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: _formKey,
//         child: GetBuilder<AddController>(
//             init: AddController(),
//             builder: (controller) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 80),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 30),
//                     DropdownButtonFormField2<String>(
//                       isExpanded: true,
//                       decoration: InputDecoration(
//                         // Add Horizontal padding using menuItemStyleData.padding so it matches
//                         // the menu padding when button's width is not specified.
//                         contentPadding:
//                             const EdgeInsets.symmetric(vertical: 16),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         // Add more decoration..
//                       ),
//                       hint: const Text(
//                         'S\elect Your Gender',
//                         style: TextStyle(fontSize: 14),
//                       ),
//                       items: controller.listCategoriesCourses
//                           .map((item) => DropdownMenuItem<String>(
//                                 value: item,
//                                 child: Text(
//                                   item,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select gender.';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         //Do something when selected item is changed.
//                       },
//
//                       onSaved: (value) {
//                         selectedValue = value.toString();
//                       },
//                       buttonStyleData: const ButtonStyleData(
//                         padding: EdgeInsets.only(right: 8),
//                       ),
//                       iconStyleData: const IconStyleData(
//                         icon: Icon(
//                           Icons.arrow_drop_down,
//                           color: Colors.black45,
//                         ),
//                         iconSize: 24,
//                       ),
//                       dropdownStyleData: DropdownStyleData(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       menuItemStyleData: const MenuItemStyleData(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     TextButton(
//                       onPressed: () {
//                         controller.addDataToListCategoriesCourses();
//                       },
//                       child: const Text('Submit Button'),
//                     )
//                   ],
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
