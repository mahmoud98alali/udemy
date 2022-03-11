import 'dart:math';
import 'package:flutter/material.dart';

import '../IBM_reuslt/IBMResult.dart';



class IBmScreen extends StatefulWidget {
  const IBmScreen({Key? key}) : super(key: key);

  @override
  _IBmScreenState createState() => _IBmScreenState();
}

class _IBmScreenState extends State<IBmScreen> {
  bool isMale = true ;
  double height = 160 ;
  int weight = 40 ;
  int age = 20 ;
  Color style = Colors.red ;
  Color? styleBack = Colors.grey[400] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI"),

      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isMale = true ;
                            });
                          },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isMale ?  style : styleBack
                        ) ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.ac_unit,
                              size: 70,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text('MALE',style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = false ;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: isMale ? styleBack : style
                        ) ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.ac_unit,
                              size: 70,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text('FEMALE',style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: styleBack
                ) ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("HEIGHT",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children:  [
                        Text("${height.round()}",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                        Text("CM",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Slider(value: height,
                        max: 220.0,
                        min: 80.0,
                        onChanged: (value){
                           setState(() {
                             height = value ;
                           });
                        } ,)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: styleBack
                      ) ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('WEIGHT',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),),
                           Text('${weight.round()}',style: const TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                heroTag: 'weight-' ,
                                onPressed: (){
                                  setState(() {
                                    weight --;
                                  });
                                },mini: true,
                                child: const Icon(
                                  Icons.remove,
                                ),
                              ),
                              FloatingActionButton(
                                heroTag: 'weight+' ,
                                onPressed: (){
                                  setState(() {
                                    weight++;
                                  }
                                  );
                                },mini: true,
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),

                            ],
                          )
                            ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: styleBack
                      ) ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('AGE',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),),
                           Text('${age.round()}',style: const TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                heroTag: 'age----' ,
                                onPressed: (){
                                  setState(() {
                                    age --;
                                  });
                                },mini: true,
                                child: const Icon(
                                  Icons.remove,
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    age++;
                                  });
                                },
                                heroTag: 'age+++' ,
                                mini: true,
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: MaterialButton(
              color: style,
              onPressed: (){
                var result = weight / pow(height/100,2);
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>IBMResult(

                  age: age,
                  isMale: isMale,
                  result: result,
                ))
                );
              },
              child: const Text("CALCULATE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),


            ),
          )

        ],
      ),
    );
  }
}
