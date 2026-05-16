import '../../domain/entities/category_entity.dart';

class CategoryFixtures {
  CategoryFixtures._();

  static List<CategoryEntity> get dummyCategories => List.generate(
    60,
    (index) => CategoryEntity(
      id: '${index + 1}',
      name: 'cards ${index + 1}',
      slug: 'cards ${index + 1}',
      image:
          'https://flower.elevateegy.com/uploads/06dfd914-95b2-4832-91d1-9affabe9fbd6-card.png',
      isSuperAdmin: index % 2 == 0,
      createdAt: DateTime(2026, 1, index + 1),
      updatedAt: DateTime(2026, 1, index + 1),
      productsCount: 3 + index,
    ),
  );
}
