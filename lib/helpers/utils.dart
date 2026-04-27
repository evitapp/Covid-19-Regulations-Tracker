import 'package:flutter/material.dart';
import 'package:theme_example/helpers/country.dart';

class Utils {
  static List<Category> getMockedCategories() {
    return [
      Category(
        country: "Denmark",
        region: "Copenhagen",
        color: Colors.amber,
        imgName: "denmark",
        restrictions: [
          "General Restrictions: No Restrictions",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: No Additional Restrictions",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
      Category(
        country: "Greece",
        region: "Athens",
        color: Colors.amber,
        imgName: "greece",
        restrictions: [
          "General Restrictions: Face Mask",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: Vaccination OR PCR Test",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
      Category(
        country: "Greece",
        region: "Central Macedonia",
        color: Colors.amber,
        imgName: "greece",
        restrictions: [
          "General Restrictions: Face Mask",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: Vaccination OR PCR Test",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
      Category(
        country: "Germany",
        region: "Berlin",
        color: Colors.amber,
        imgName: "germany",
        restrictions: [
          "General Restrictions: Face Mask",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: Vaccination OR PCR Test",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
      Category(
        country: "Germany",
        region: "Hamburg",
        color: Colors.amber,
        imgName: "germany",
        restrictions: [
          "General Restrictions: Face Mask",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: Vaccination OR PCR Test",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
      Category(
        country: "France",
        region: "Paris",
        color: Colors.amber,
        imgName: "france",
        restrictions: [
          "General Restrictions: Face Mask",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: Vaccination OR PCR Test",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
      Category(
        country: "France",
        region: "Bordeaux",
        color: Colors.amber,
        imgName: "france",
        restrictions: [
          "General Restrictions: Face Mask",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: Vaccination OR PCR Test",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
      Category(
        country: "United Kingdom",
        region: "London",
        color: Colors.amber,
        imgName: "united-kingdom",
        restrictions: [
          "General Restrictions: Face Mask",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: No Additional Restrictions",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
      Category(
        country: "United Kingdom",
        region: "Southampton",
        color: Colors.amber,
        imgName: "united-kingdom",
        restrictions: [
          "General Restrictions: Face Mask",
          "Airport: Vaccination OR PCR Test",
          "Indoor Places: No Additional Restrictions",
          "Outdoor Places: No Additional Restrictions",
        ],
      ),
    ];
  }
}
