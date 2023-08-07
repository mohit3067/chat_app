import 'package:flutter/material.dart';

class button extends StatelessWidget {
   button({required this.color,required this.label,required this.ontap});

final Color color;
final Function ontap;
final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: color,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: (){ ontap();},
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
  }
}