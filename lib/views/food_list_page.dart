import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';
import '../models/food_model.dart';
import 'food_detail_page.dart';
import '../models/cart_model.dart';

class FoodListPage extends StatelessWidget {
  final List<Food> foods = [
    Food(
      id: 1,
      title: 'Pizza',
      description: 'Delicious cheesy pizza',
      image: 'assets/images/food/pizza.jpg',
      price: 9.99,
    ),
    Food(
      id: 2,
      title: 'Burger',
      description: 'Juicy burger yummy',
      image: 'assets/images/food/burger.jpg',
      price: 5.99,
    ),
    Food(
      id: 3,
      title: 'Pasta',
      description: 'Creamy Alfredo pasta',
      image: 'assets/images/food/pasta.jpeg',
      price: 7.49,
    ),
    Food(
      id: 4,
      title: 'Sushi',
      description: 'Fresh raw sushi',
      image: 'assets/images/food/sushi.jpeg',
      price: 12.99,
    ),
    Food(
      id: 5,
      title: 'Salad',
      description: 'Healthy green salad',
      image: 'assets/images/food/salad.jpeg',
      price: 4.99,
    ),
    Food(
      id: 6,
      title: 'Steak',
      description: 'Tender juicy steak',
      image: 'assets/images/food/steak.jpg',
      price: 14.99,
    ),
    Food(
      id: 7,
      title: 'Tacos',
      description: 'Spicy crunchy tacos',
      image: 'assets/images/food/tacos.jpeg',
      price: 6.49,
    ),
    Food(
      id: 8,
      title: 'Fried Chicken',
      description: 'Crispy golden chicken',
      image: 'assets/images/food/fried_chicken.jpeg',
      price: 8.49,
    ),
    Food(
      id: 9,
      title: 'Nasi Goreng',
      description: 'Fried rice dish',
      image: 'assets/images/food/nasi_goreng.jpeg',
      price: 7.99,
    ),
    Food(
      id: 10,
      title: 'Sate',
      description: 'Grilled skewered meat',
      image: 'assets/images/food/sate.jpeg',
      price: 6.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Food",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent,
        actions: [
          Consumer<CartController>(
            builder: (context, cartController, child) {
              final itemCount = cartController.cartItems.length;
              return IconButton(
                icon: Stack(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    if (itemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            '$itemCount',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: foods.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final food = foods[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailPage(food: food),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.asset(
                          food.image,
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          food.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          food.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${food.price}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                final cartController =
                                    Provider.of<CartController>(context,
                                        listen: false);
                                cartController.addToCart(CartItem(
                                  id: food.id,
                                  title: food.title,
                                  image: food.image,
                                  price: food.price,
                                ));

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("${food.title} added to cart")),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
