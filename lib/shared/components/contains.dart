// base url : https://newsapi.org/
// method (url) : v2/everything?
// queries : q=tesla&from=2022-01-20&sortBy=publishedAt&apiKey=API_KEY

//  https://newsapi.org/
//  v2/top-headlines?
//  country=us&category=business&apiKey=d3e5d9a88575490f86e6232066f0eaf8
//  https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d3e5d9a88575490f86e6232066f0eaf8
// https://newsapi.org/v2/everything?q=tesla&from=2022-01-23&sortBy=publishedAt&apiKey=d3e5d9a88575490f86e6232066f0eaf8
// POST
// UPDATE
// DELETE
// GET


import '../../modules/shop_app/login_screen/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void singOut (context)
{
  CacheHelper.removeData(key: 'token').then((value) {

    if (value == true) {

      navigateAndFinish(
          context,
          ShopLoginScreen()
      );
    }
  });
}

void printFullText(String? text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((element) => print(element.group(0)));
}

 String token = '';