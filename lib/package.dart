import 'dart:async';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/bookmark/local_database_provider.dart';

import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_search_list_provider.dart';
import 'package:restaurant_app/provider/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/provider/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/provider/static/restaurant_search_result_state.dart';
import 'package:restaurant_app/widgets/widgets_package.dart';
import 'package:restaurant_app/provider/provider_package.dart';

part 'views/main/home_screen.dart';
part 'views/main/detail_screen.dart';
part 'views/bookmark/bookmark_screen.dart';
part 'views/main_screen.dart';
