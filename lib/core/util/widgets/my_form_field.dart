import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFormField extends StatelessWidget {
  final String label;

  final IconData? suffixIcon;

  final TextEditingController controller;

  final TextInputType keyboardType;

  final String validatorText;

  final String hintText;



  final bool readOnly ;

  final VoidCallback? onTap ;

  const MyFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.suffixIcon,
    required this.keyboardType,
    required this.validatorText,

    this.onTap ,
    this.readOnly = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline6!.copyWith(

          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(

            onTap: onTap,
            readOnly: readOnly,

            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              filled: true,
              hintText: hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: Icon(suffixIcon),
            ),
            controller: controller,
            keyboardType: keyboardType,
            validator: (value) {
              if(value!.isEmpty) {
                return validatorText;
              }
            },
          ),
        ),
      ],
    );
  }
}
