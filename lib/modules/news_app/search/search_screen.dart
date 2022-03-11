import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/news_app/cubit/cubit.dart';
import 'package:udemy/layout/news_app/cubit/states.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: defaultFormField(
                  showCursor: true,
                  controller: controllerSearch,
                  keyboardType: TextInputType.text,
                  labelText: "Search",
                  labelStyle: const TextStyle(color: Colors.deepPurple),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple,
                    ),
                  ),
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                  },
                  focusColor: Colors.white,
                  // suffixStyle:TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.deepPurple,
                  ),
                  style: TextStyle(color: Colors.deepPurple,fontSize: 16,letterSpacing: 1),
                    cursorColor:Colors.deepPurple,
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
