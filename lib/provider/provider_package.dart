import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/static/restaurant_search_result_state.dart';
import 'package:restaurant_app/provider/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main/index_nav_provider.dart';
part 'bookmark/bookmark_list_provider.dart';
part 'bookmark/bookmark_icon_provider.dart';
part 'home/restaurant_list_provider.dart';
part 'home/restaurant_search_list_provider.dart';
part 'detail/restaurant_detail_provider.dart';
part 'bookmark/local_database_provider.dart';
part 'settings/theme_provider.dart';