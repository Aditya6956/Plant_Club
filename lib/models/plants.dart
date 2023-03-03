import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  final String uid;
  final int plantId;
  final int price;
  final String size;
  final double rating;
  final int humidity;
  final String temperature;
  final String category;
  final String plantName;
  final String imageURL;
  bool isFavorated;
  final String decription;
  bool isSelected;

  Plant(
      {required this.uid,
      required this.plantId,
      required this.price,
      required this.category,
      required this.plantName,
      required this.size,
      required this.rating,
      required this.humidity,
      required this.temperature,
      required this.imageURL,
      required this.isFavorated,
      required this.decription,
      required this.isSelected});

// Retrieve the plants list from firestore database and store it in a list
  static Set<Plant> plantList = <Plant>{};

  // ignore: non_constant_identifier_names
  static Set<Plant> getDataOnce_getAllDocuments() { 
    FirebaseFirestore.instance
        .collection('plansts')
        .get()
        .then((QuerySnapshot querySnapshot) {
          plantList = <Plant>{}; // CLear the list
      for (var doc in querySnapshot.docs) {
        final doc1 = doc.data() as Map<dynamic, dynamic>;
        plantList.add(Plant(
            uid: doc1['uid'],
            plantId: doc1['plantId'] as int,
            price: doc1['price'] as int,
            category: doc1['category'],
            plantName: doc1['plantName'],
            size: doc1['size'],
            rating: doc1['rating'] as double,
            humidity: doc1['humidity'],
            temperature: doc1['temperature'],
            imageURL: doc1['imageURL'],
            isFavorated: doc1['isFavorated'],
            decription: doc1['decription'],
            isSelected: doc1['isSelected']));
      }
    });
    return plantList;
  }

  //List of Plants data
  // static Set<Plant> plantList = {
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',         
  //       plantId: 0,
  //       price: 22,
  //       category: 'Indoor',
  //       plantName: 'Sanseviera',
  //       size: 'Small',
  //       rating: 4.5,
  //       humidity: 34,
  //       temperature: '23 - 34',
  //       imageURL: 'assets/images/plant-one.png',
  //       isFavorated: true,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',
  //       plantId: 1,
  //       price: 11,
  //       category: 'Outdoor',
  //       plantName: 'Philodendron',
  //       size: 'Medium',
  //       rating: 4.8,
  //       humidity: 56,
  //       temperature: '19 - 22',
  //       imageURL: 'assets/images/plant-two.png',
  //       isFavorated: false,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',
  //       plantId: 2,
  //       price: 18,
  //       category: 'Indoor',
  //       plantName: 'Beach Daisy',
  //       size: 'Large',
  //       rating: 4.7,
  //       humidity: 34,
  //       temperature: '22 - 25',
  //       imageURL: 'assets/images/plant-three.png',
  //       isFavorated: false,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',
  //       plantId: 3,
  //       price: 30,
  //       category: 'Outdoor',
  //       plantName: 'Big Bluestem',
  //       size: 'Small',
  //       rating: 4.5,
  //       humidity: 35,
  //       temperature: '23 - 28',
  //       imageURL: 'assets/images/plant-one.png',
  //       isFavorated: false,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',
  //       plantId: 4,
  //       price: 24,
  //       category: 'Recommended',
  //       plantName: 'Big Bluestem',
  //       size: 'Large',
  //       rating: 4.1,
  //       humidity: 66,
  //       temperature: '12 - 16',
  //       imageURL: 'assets/images/plant-four.png',
  //       isFavorated: true,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',
  //       plantId: 5,
  //       price: 24,
  //       category: 'Outdoor',
  //       plantName: 'Meadow Sage',
  //       size: 'Medium',
  //       rating: 4.4,
  //       humidity: 36,
  //       temperature: '15 - 18',
  //       imageURL: 'assets/images/plant-five.png',
  //       isFavorated: false,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',
  //       plantId: 6,
  //       price: 19,
  //       category: 'Garden',
  //       plantName: 'Plumbago',
  //       size: 'Small',
  //       rating: 4.2,
  //       humidity: 46,
  //       temperature: '23 - 26',
  //       imageURL: 'assets/images/plant-six.png',
  //       isFavorated: false,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',
  //       plantId: 7,
  //       price: 23,
  //       category: 'Garden',
  //       plantName: 'Tritonia',
  //       size: 'Medium',
  //       rating: 4.5,
  //       humidity: 34,
  //       temperature: '21 - 24',
  //       imageURL: 'assets/images/plant-seven.png',
  //       isFavorated: false,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  //   Plant(
  //       uid: 'RE2d7MLN0Rce6PmbTu9uKTJezaI2',
  //       plantId: 8,
  //       price: 46,
  //       category: 'Recommended',
  //       plantName: 'Tritonia',
  //       size: 'Medium',
  //       rating: 4.7,
  //       humidity: 46,
  //       temperature: '21 - 25',
  //       imageURL: 'assets/images/plant-eight.png',
  //       isFavorated: false,
  //       decription:
  //           'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
  //           'even the harshest weather condition.',
  //       isSelected: false),
  // };

  //Get the plant list
  static Set<Plant> getPlantsList() {
    // ignore: no_leading_underscores_for_local_identifiers
    Set<Plant> _plantList = getDataOnce_getAllDocuments();
    return _plantList;
  }

  //Get the favorated items
  static List<Plant> getFavoritedPlants() {
    // ignore: no_leading_underscores_for_local_identifiers
    Set<Plant> _plantList = getDataOnce_getAllDocuments();
    return _plantList.where((element) => element.isFavorated == true).toList();
  }

  //Get the cart items
  static List<Plant> addedToCartPlants() {
    // ignore: no_leading_underscores_for_local_identifiers
    Set<Plant> _plantList = getDataOnce_getAllDocuments();
    return _plantList.where((element) => element.isSelected == true).toList();
  }
}
