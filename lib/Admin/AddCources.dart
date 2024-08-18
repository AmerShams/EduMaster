// ignore_for_file: file_names

import 'package:courseproject/controller/AddCoursesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class AddCourses extends StatelessWidget {
  const AddCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final AddCoursesController controller = Get.put(AddCoursesController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<AddCoursesController>(
          builder: (_) {
            return Form(
              key: controller.formstate,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildTextFormField(
                    controller: controller.title,
                    label: 'Title',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the title'
                        : null,
                  ),
                  _buildTextFormField(
                    controller: controller.describition,
                    label: 'Description',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the description'
                        : null,
                  ),
                  _buildTextFormField(
                    controller: controller.category,
                    label: 'Category',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the category'
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: SpinBox(
                      min: 1,
                      max: 5,
                      value: 1,
                      onChanged: (value) {
                        controller.rating.text = value.toString();
                      },
                      decoration: InputDecoration(
                        labelText: 'Rating',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                      ),
                    ),
                  ),
                  _buildTextFormField(
                    controller: controller.coachname,
                    label: 'Coach Name',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the coach name'
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: InkWell(
                      onTap: () async {
                        await controller.getImage();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.imageUrl.text.isEmpty
                                    ? 'Choose Image'
                                    : 'Image Selected',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              controller.uploadProgress.value > 0 &&
                                      controller.uploadProgress.value < 1
                                  ? CircularProgressIndicator(
                                      value: controller.uploadProgress.value)
                                  : Icon(Icons.image, color: Colors.grey[600]),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  _buildTextFormField(
                    controller: controller.courseUrl,
                    label: 'Course URL',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the course URL'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  controller.isloading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            if (controller.formstate.currentState?.validate() ??
                                false) {
                              controller.setLoading(true);
                              await controller.addCourse();
                              controller.setLoading(false);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Add Course'),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        ),
        validator: validator,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
