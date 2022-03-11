import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/shop_app/search/cubit/cubit.dart';
import 'package:udemy/modules/shop_app/search/cubit/states.dart';
import 'package:udemy/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      onSubmit: (String text) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context)
                              .search(searchController.text);
                        }
                      },
                      controller: searchController,
                      keyboardType: TextInputType.name,
                      labelText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please search any things';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).searchModel!.data!.data[index],context,isOldPrice: false),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
