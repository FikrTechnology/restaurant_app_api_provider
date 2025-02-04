import 'dart:async';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_reviews_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_search_list_provider.dart';
import 'package:restaurant_app/provider/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/provider/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/provider/static/restaurant_search_result_state.dart';
import 'package:restaurant_app/routes/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/widgets/widgets_package.dart';
import 'package:restaurant_app/provider/provider_package.dart';

part 'main.dart';
part 'views/main/home_screen.dart';
part 'views/main/detail_screen.dart';
part 'views/bookmark/bookmark_screen.dart';
part 'views/main_screen.dart';
