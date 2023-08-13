import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plant.dart';

class PlantRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Plant>> fetchAllPlants() async {
    List<Plant> plants = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('plants').get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? productData = documentSnapshot.data() as Map<String, dynamic>?;
        print("productData: $productData");
        if (productData != null) {
          Plant plant = Plant(
            plantType: productData['category'] ?? '',
            plantName: productData['Name'] ?? '',
            plantPrice: (productData['Price'] ?? 0).toDouble(),
            stars: (productData['stars'] ?? 0).toDouble(),
            image: productData['image_url'] ?? '',
            metrics: PlantMetrics(
              productData['Height'] ?? '',
              productData['Humidity'] ?? '',
              productData['Width'] ?? '',
            ),
          );

          plants.add(plant);
        }
      }
    } catch (e) {
      print('Error fetching plants: $e');
    }
    return plants;
  }
}

