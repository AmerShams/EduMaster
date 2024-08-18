// ignore_for_file: unused_local_variable, file_names

import 'package:courseproject/controller/favoriteController.dart';
import 'package:courseproject/static/static.dart';
import 'package:courseproject/views/CourseDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritCourse extends StatelessWidget {
  const FavoritCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('الكورسات المفضلة'),
      ),
      body: GetBuilder<FavoriteController>(
        builder: (controller) {
          if (favoritecourses.isEmpty) {
            return const Center(child: Text("لا توجد كورسات مفضلة"));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.68,
              ),
              itemCount: favoritecourses.length,
              itemBuilder: (context, index) {
                final course = favoritecourses[index];
                final rating =
                    double.tryParse(course['rating'].toString()) ?? 0.0;
                final imageUrl = course['imagePath'] ?? '';

                return GestureDetector(
                  onTap: () {
                    // Navigate to course details page
                    Get.to(CourseDetailPage(course: course));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // صورة الكورس
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Container(
                            height: 75,
                            color: Colors.grey[300],
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/ajpg.jpg',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/images/ajpg.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // العنوان
                              Text(
                                course['title'] ?? 'بدون عنوان',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5.0),
                              // اسم المدرب
                              Text(
                                'Coach: ${course['coachName'] ?? 'بدون اسم مدرب'}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 7.0),
                              // التصنيف
                              Text(
                                'Category: ${course['category'] ?? 'بدون تصنيف'}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 7.0),
                              // التقييم
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(5, (starIndex) {
                                  return Icon(
                                    Icons.star,
                                    color: starIndex < rating
                                        ? Colors.amber
                                        : Colors.grey,
                                    size: 18,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
