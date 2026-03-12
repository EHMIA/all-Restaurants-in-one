import 'package:flutter/material.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';

class ConstantData {
  //restaurant categories data
  static List<Map<String, dynamic>> restaurants = [
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Zeba Restaurant",
      "resPeopleRate": "800",
      "resRate": "4.8",
      "resSpace": "2.4 km",
      "category": "Egyptian",
    },
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Koshary El Tahrir",
      "resPeopleRate": "1200",
      "resRate": "4.6",
      "resSpace": "1.8 km",
      "category": "Koshary",
    },

    /// Pizza
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Roma Pizza",
      "resPeopleRate": "650",
      "resRate": "4.5",
      "resSpace": "3.1 km",
      "category": "Pizza",
    },
    {
      "isFavorite": false,
      "isOpen": false,
      "image": AppAssets.image,
      "resName": "Italiano Pizza",
      "resPeopleRate": "540",
      "resRate": "4.3",
      "resSpace": "2.7 km",
      "category": "Pizza",
    },

    /// Burger
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Burger House",
      "resPeopleRate": "900",
      "resRate": "4.7",
      "resSpace": "2.2 km",
      "category": "Burger",
    },
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Smash Burger",
      "resPeopleRate": "720",
      "resRate": "4.4",
      "resSpace": "3.6 km",
      "category": "Burger",
    },

    /// Seafood
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Ocean Basket",
      "resPeopleRate": "510",
      "resRate": "4.5",
      "resSpace": "5.1 km",
      "category": "Seafood",
    },

    /// Cafe
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Cafe Latte",
      "resPeopleRate": "330",
      "resRate": "4.6",
      "resSpace": "1.2 km",
      "category": "Cafe",
    },

    /// Desserts
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Sweet Corner",
      "resPeopleRate": "410",
      "resRate": "4.5",
      "resSpace": "2.0 km",
      "category": "Desserts",
    },
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Sugar Rush",
      "resPeopleRate": "350",
      "resRate": "4.4",
      "resSpace": "2.3 km",
      "category": "Desserts",
    },

    /// Grill
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Grill House",
      "resPeopleRate": "690",
      "resRate": "4.4",
      "resSpace": "3.3 km",
      "category": "Grill",
    },

    /// Healthy
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Green Bowl",
      "resPeopleRate": "260",
      "resRate": "4.3",
      "resSpace": "2.5 km",
      "category": "Healthy",
    },

    /// Asian
    {
      "isFavorite": false,
      "isOpen": true,
      "image": AppAssets.image,
      "resName": "Tokyo Sushi",
      "resPeopleRate": "540",
      "resRate": "4.7",
      "resSpace": "4.8 km",
      "category": "Asian",
    },
  ];
  static List<Map<String, dynamic>> categories = [
    {
      'title': 'Egyptian',
      'icon': Icons.ramen_dining,
      'color': Color(0xffE23744).withValues(alpha: 0.1),
      'iconColor': Color(0xffE23744),
    },
    {
      'title': 'Italian',
      'icon': Icons.local_pizza,
      'color': Color(0xffFF6D00).withValues(alpha: 0.1),
      'iconColor': Color(0xffFF6D00),
    },
    {
      'title': 'Indian',
      'icon': Icons.bakery_dining,
      'color': Color(0xffFFD54F).withValues(alpha: 0.1),
      'iconColor': Color(0xffFFD54F),
    },
    {
      'title': 'Seafood',
      'icon': Icons.set_meal,
      'color': Color(0xffDBEAFE),
      'iconColor': Color(0xff2563EB),
    },
    {
      'title': 'Cafe',
      'icon': Icons.coffee,
      'color': Color(0xffFEF3C7),
      'iconColor': Color(0xff92400E)
    },
    {
      'title': 'Grill',
      'icon': Icons.outdoor_grill,
      'color': Color(0xffFCE7F3),
      'iconColor': Color(0xffDB2777),
    },
    {
      'title': 'Sweets',
      'icon': Icons.cake,
      'color': Color(0xffFEE2E2),
      'iconColor': Color(0xffB91C1C),
    },
    {
      'title': 'Healthy',
      'icon': Icons.eco,
      'color': Color(0xff4CAF50).withValues(alpha: 0.1),
      'iconColor': Color(0xff4CAF50),
    },
    {
      'title': 'Assian',
      'icon': Icons.rice_bowl,
      'color': Color(0xffE0E7FF),
      'iconColor': Color(0xff4F46E5),
    },
    ///==================================
  ];

  static List<Map<String, dynamic>> category = [
    {'title': 'All', 'icon': Icons.restaurant_menu},
    {'title': 'Pizza', 'icon': Icons.local_pizza},
    {'title': 'Koshary', 'icon': Icons.soup_kitchen},
    {'title': 'Cafe', 'icon': Icons.coffee},
    {'title': 'Grill', 'icon': Icons.outdoor_grill},
    {'title': 'Desserts', 'icon': Icons.cake},
    {'title': 'Burger', 'icon': Icons.fastfood},
    {'title': 'Healthy', 'icon': Icons.eco},
    {'title': 'Seafood', 'icon': Icons.set_meal},
    {'title': 'Asian', 'icon': Icons.rice_bowl},
  ];

}

