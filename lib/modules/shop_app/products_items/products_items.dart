import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsItems extends StatelessWidget {
  const ProductsItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: NetworkImage("https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg"),
              width: 300,height: 300,
              ),
              SizedBox(height: 20,),
              Text('Describtisad',style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Text('Describtisad',style: TextStyle(fontSize: 10,color: Colors.grey),),
              SizedBox(height: 20,),
              Row(
                children: [
                  Spacer(),
                  Icon(Icons.import_contacts_sharp),
                  SizedBox(width: 20,),
                  Icon(Icons.import_contacts_sharp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
