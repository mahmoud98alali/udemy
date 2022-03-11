import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IBMResult extends StatelessWidget {

    final bool isMale ;
    final double result ;
    final int age ;
    IBMResult({required this.age, required this.isMale, required this.result});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isMale ? "Gender : Male":"Gender : Female" ,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35
            ),),
            Text("Result : ${result.round()}",style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35
          ),),
            Text("Age : ${age.round()}",style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35
            ),),

          ],
        ),
      ),
    );
  }
}
