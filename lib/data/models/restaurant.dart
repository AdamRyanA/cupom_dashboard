import 'package:flutter/material.dart';

class Restaurant{
  String? name;
  String? coupon;
  IconData? image;
  Restaurant(this.name, this.coupon, this.image);
  
  factory Restaurant.toNull(){
    return Restaurant(null, null, null);
  }
  
  static List<Restaurant> listRestaurant = [
    Restaurant('Camarão Loriniss', '50% off', Icons.dinner_dining_outlined),
    Restaurant('HMB Artesanal', '2 pratos por 1', Icons.lunch_dining_outlined),
    Restaurant('Estrela Pizzaria', 'Sobremesa grátis', Icons.local_pizza_outlined),
    Restaurant('Poke Leste', '50% off', Icons.dinner_dining_outlined),
  ];

  static List<Restaurant> listLeisure = [
    Restaurant('Cirque du Soleil', '50% off', Icons.festival_outlined),
    Restaurant('Parte Vila Velha', '50% off', Icons.forest_outlined),
    Restaurant('CTT Tours', '50% off', Icons.directions_boat_filled_outlined),
  ];

  static List<Restaurant> listEntertainment = [
    Restaurant('Teatro', '50% off', Icons.theater_comedy_outlined),
    Restaurant('Parque de Divesão', '50% off', Icons.attractions_outlined),
    Restaurant('Campo de Golf', '50% off', Icons.golf_course_outlined),
  ];
}