import 'package:courseproject/controller/HomeController.dart';
import 'package:courseproject/views/CourseDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 15),
          padding: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      hintText: 'بحث',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final filteredCourses = controller.courses.where((course) {
              final title = course['title'] ?? '';
              final query = controller.searchQuery.value.toLowerCase();
              return title.toLowerCase().contains(query);
            }).toList();

            if (filteredCourses.isEmpty) {
              return const Center(child: Text("No courses available"));
            } else {
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.68,
                ),
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  final rating =
                      double.tryParse(course['rating'].toString()) ?? 0.0;
                  final imageUrl = course['imagePath'] ?? '';

                  return GestureDetector(
                    onTap: () {
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
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Container(
                              height: 75,
                              color: Colors.grey[300],
                              child: imageUrl.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/ajpg.jpg',
                                        fit: BoxFit.cover,
                                      ),
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
                                Text(
                                  'Coach: ${course['coachName'] ?? 'بدون اسم مدرب'}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 7.0),
                                Text(
                                  'Category: ${course['category'] ?? 'بدون تصنيف'}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 7.0),
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
          }),
        ),
      ],
    );
  }
}
