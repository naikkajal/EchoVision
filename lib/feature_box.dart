import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String header;
  final String description;
  const FeatureBox({super.key, required this.color, required this.header, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(
          top:10
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                
                child: Text(header, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              
                Text(description, style: TextStyle(fontSize: 15)),
              
            ],
          ),
        ),
      ),
    );
  }
}
