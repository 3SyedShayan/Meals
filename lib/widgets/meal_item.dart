import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  MealItem({super.key, required this.meal, 
  });
  Meal meal;
  String complexityText() {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1).toLowerCase();
  }

  String affordabilityText() {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MealDetailsScreen(
                  meal: meal,
                );
              },
            ),
          );
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.fill,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      maxLines: 2,
                      meal.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.work,
                          text: complexityText(),
                        ),
                        SizedBox(width: 6),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          text: affordabilityText(),
                        ),
                        SizedBox(width: 6),
                        MealItemTrait(
                            icon: Icons.schedule, text: "${meal.duration} min"),
                      ],
                    ),
                  ],
                ),
              ),
              left: 0,
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }
}
