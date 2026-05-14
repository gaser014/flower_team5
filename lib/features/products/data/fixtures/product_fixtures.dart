import 'package:flowers_app/features/products/domain/entities/product_entity.dart';

class ProductFixtures {
  ProductFixtures._();

  static List<ProductEntity> get dummyProducts => List.generate(
        60,
        (index) => ProductEntity(
          id: '${index + 1}',
          title: 'Wdding Flower ${index + 1}',
          slug: 'wdding-flower ${index + 1}',
          description: 'This is a Pack of White Widding Flowers ${index + 1}',
          imgCover: 'https://flower.elevateegy.com/uploads/fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png ${index + 1}',
          images: ['https://flower.elevateegy.com/uploads/66c36d5d-c067-46d9-b339-d81be57e0149-image_one.png', 'https://flower.elevateegy.com/uploads/f27e1903-74cf-4ed6-a42c-e43e35b6dd14-image_three.png', 'https://flower.elevateegy.com/uploads/500fe197-0e16-4b01-9a0d-031ccb032714-image_two.png'],
          price: 250 + index,
          priceAfterDiscount: 100 + index,
          discount: 60 + index,
          rateAvg: 0 + index,
          rateCount: 0 + index,
          sold: 34 + index,
          quantity: 186 + index,
          category: '69d988704461df0f939b57cc ${index + 1}',
          occasion: '69d988724461df0f939b57ea ${index + 1}',
          isSuperAdmin: index % 2 == 0,
          createdAt: DateTime(2026, 1, index + 1),
          updatedAt: DateTime(2026, 1, index + 1),
          favoriteId: null,
          isInWishlist: index % 2 == 0,
        ),
      );
}
