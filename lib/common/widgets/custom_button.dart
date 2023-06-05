import 'package:amazonclone/constants/global_variable.dart';
import 'package:flutter/material.dart';

class AmazonButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const AmazonButton({super.key, required this.name, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(GlobalVariables.secondaryColor),
          // shape:RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12.0),
          // ),
        ),
      ),
    );
  }
}
