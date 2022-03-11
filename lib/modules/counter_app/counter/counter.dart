import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';



class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child:BlocConsumer<CounterCubit,CounterStates>(
        listener: (BuildContext context,CounterStates state) {
          if(state is CounterMinusState){
          }
          if(state is CounterPlusState){
          }
        },
        builder: (BuildContext context,CounterStates state)=> Scaffold(
          appBar: AppBar(title: Text("Counter Page"),),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (){

                      CounterCubit.get(context).minus();
                    },
                    child: Text("Minus",
                      style: TextStyle(
                          fontSize: 30.0
                      ),)),

                SizedBox(width: 10,),

                Text("${CounterCubit.get(context).counter}",
                  style: TextStyle(fontSize: 35.0),),

                SizedBox(width: 10,),

                TextButton(
                    onPressed: (){
                      CounterCubit.get(context).plus();
                    },
                    child: Text("Plus",
                      style: TextStyle(
                          fontSize: 30.0
                      ),)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
