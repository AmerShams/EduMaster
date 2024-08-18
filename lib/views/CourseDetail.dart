// ignore_for_file: must_be_immutable, file_names, deprecated_member_use

import 'package:courseproject/controller/DetailaController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CourseDetailPage extends StatelessWidget {
  final Map<dynamic, dynamic> course;

  CourseDetailPage({super.key, required this.course});
  DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    final rating = double.tryParse(course['rating'].toString()) ?? 0.0;
    final imageUrl = course['imagePath'] ?? '';
    final courseUrl = course['courseUrl'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(course['title'] ?? 'تفاصيل الكورس'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // صورة الكورس
            Container(
              height: 205,
              color: Colors.grey[300],
              child: imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16.0)),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/ajpg.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Image.asset(
                      'assets/images/ajpg.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  Text(
                    course['title'] ?? 'بدون عنوان',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // اسم المدرب
                  Text(
                    'المدرب: ${course['coachName'] ?? 'بدون اسم مدرب'}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // التقييم
                  Row(
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        Icons.star,
                        color: starIndex < rating ? Colors.amber : Colors.grey,
                        size: 20,
                      );
                    }),
                  ),
                  const SizedBox(height: 8.0),
                  // التصنيف
                  Text(
                    'التصنيف: ${course['category'] ?? 'بدون تصنيف'}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // الوصف
                  Text(
                    course['description'] ?? 'بدون وصف',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // الزرين
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (courseUrl.isNotEmpty) {
                              await launch(courseUrl);
                            }
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('تحميل الكورس'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue, // لون النص والرمز
                          ),
                        ),
                      ),
                      const SizedBox(width: 10), // مسافة بين الزرين
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final coursefav = {
                              'title': course['title'] ?? 'بدون عنوان',
                              'description':
                                  course['description'] ?? 'بدون وصف',
                              'category': course['category'] ?? 'بدون تصنيف',
                              'rating': course['rating'] ?? '0',
                              'coachName':
                                  course['coachName'] ?? 'بدون اسم مدرب',
                              'imagePath': course['imagePath'] ?? '',
                              'courseUrl': course['courseUrl'] ?? '',
                            };

                            controller.addToFavorites(coursefav);
                          },
                          icon: const Icon(Icons.favorite),
                          label: const Text('إضافة للمفضلة'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red, // لون النص والرمز
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
