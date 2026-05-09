import 'package:flowers_app/config/base_response/entity/meta_entity.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MetaEntity', () {
    test('hasNextPage should be true if currentPage < numberOfPages', () {
      const meta = MetaEntity(currentPage: 1, numberOfPages: 5, limit: 20);
      expect(meta.hasNextPage, isTrue);
    });

    test('hasNextPage should be false if currentPage == numberOfPages', () {
      const meta = MetaEntity(currentPage: 5, numberOfPages: 5, limit: 20);
      expect(meta.hasNextPage, isFalse);
    });

    test('isFirstPage should be true if currentPage == 1', () {
      const meta = MetaEntity(currentPage: 1, numberOfPages: 5, limit: 20);
      expect(meta.isFirstPage, isTrue);
    });
  });

  group('ProductsParams', () {
    test('toJson should include category id when not clearing category', () {
      const category = CategoryEntity(id: 'cat_123', name: 'Flowers');
      final params = ProductsParams(
        category: category,
        type: CategoriesType.occasions,
        keyword: 'rose',
        sort: '-price',
      );

      final json = params.toJson();

      expect(json['occasion'], 'cat_123');
      expect(json['keyword'], 'rose');
      expect(json['sort'], '-price');
      expect(json['page'], 1);
    });

    test('toJson should NOT include category id when clearCategory is true', () {
      const category = CategoryEntity(id: 'cat_123', name: 'Flowers');
      final params = ProductsParams(
        category: category,
        clearCategory: true,
      );

      final json = params.toJson();

      expect(json.containsKey('category'), isFalse);
    });
  });
}
