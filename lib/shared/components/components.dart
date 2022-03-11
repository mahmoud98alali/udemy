import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/styles/colors.dart';
import '../../layout/shop_app/shop_layout/cubit/cubit.dart';
import '../../modules/news_app/web_view/webview.dart';

Widget defaultButton({
  double height = 40.0,
  double width = double.infinity,
  Color background = defaultColor,
  double radius = 10.0,
  bool isUpperCase = true,
  required Function() function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      height: height,
      width: width,

      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? labelText,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  bool isPassword = false,
  required FormFieldValidator<String> validator,
  IconData? suffixIcon,
  Function()? suffixPressed,
  Function()? onTap,
  ToolbarOptions? toolbarOptions,
  bool? showCursor,
  TextStyle? labelStyle,
  Widget? prefixIcon,
  InputBorder? enabledBorder,
  Color? focusColor,
  Color? cursorColor,
  InputBorder? focusedBorder,
  TextStyle? suffixStyle,
  bool readOnly = false,
  bool autofocus = false,
  TextStyle? style,
  StrutStyle? strutStyle,
  Color? colorSuffixIcon,
}) =>
    TextFormField(
      autofocus:autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      style: style,
      strutStyle:strutStyle ,
      cursorColor: cursorColor,
      toolbarOptions: toolbarOptions,
      obscureText: isPassword,
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon:
        IconButton(icon: Icon(suffixIcon,), onPressed: suffixPressed,color: colorSuffixIcon ,),
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        enabledBorder: enabledBorder,
        focusColor: focusColor,
        focusedBorder: focusedBorder,
        suffixStyle: suffixStyle,
        border: const OutlineInputBorder(),
      ),
      onTap: onTap,
      validator: validator,

    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
        Icons.arrow_back_ios
    ),
  ),
  title: Text('$title'),
  titleSpacing: 5.0,
  actions: actions,
);
Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text('${model['time']}'),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${model['date']}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context)
                .updateData(status: "done", id: model['id']);
          },
          icon: const Icon(
            Icons.check_box,
            color: Colors.green,
          ),
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context)
                .updateData(status: "archive", id: model['id']);
          },
          icon: const Icon(
            Icons.archive,
            color: Colors.black38,
          ),
        ),
      ],
    ),
  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
          itemBuilder: (context, indext) =>
              buildTaskItem(tasks[indext], context),
          separatorBuilder: (context, indext) => myDivider(),
          itemCount: tasks.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No tasks_app Yet, Please Add Some tasks_app',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey,
);

Widget buildArticleItem(article, context) => InkWell(
  onTap: () {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage("${article['urlToImage']}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch
      ? Container()
      : const Center(child: CircularProgressIndicator()),
);

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false);

Widget defaultTextButton(
    {required Function()? onPressed,
      required String title,
      TextStyle? style,
      bool isUpperCase = true,

    }) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        isUpperCase ? title.toUpperCase() : title,
        style: style,
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


Widget buildListProduct(model,context,{isOldPrice = true})=>Padding(
  padding:const EdgeInsets.all(10.0),
  child: SizedBox(
    height: 120,
    child: Row(

      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 120,
              height: 120,
              // fit: BoxFit.contain,
            ),
            if (model.discount != 0 && isOldPrice)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 3.0,left: 8,right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                  child: Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15.0, height: 1.2),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: const TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavoritesData(model.id!);

                        },
                        icon: CircleAvatar(
                            radius: 17,
                            backgroundColor: ShopCubit.get(context).favorites![model.id]! ? defaultColor :Colors.grey,

                            child: Icon(Icons.favorite_sharp,size: 20,
                              color: ShopCubit.get(context).favorites![model.id]! ? Colors.red :Colors.white,)),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);