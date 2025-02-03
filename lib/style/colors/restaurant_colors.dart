import 'package:flutter/material.dart';
 
enum RestaurantColors {
 cyan("Cyan", Colors.cyan);
 
 const RestaurantColors(this.name, this.color);
 
 final String name;
 final Color color;
}