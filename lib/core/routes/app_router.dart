import 'package:flutter/material.dart';
import '../../data/models/product.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/product_details/presentation/product_details_screen.dart';
import '../../features/purchase/presentation/purchase_screen.dart';
import '../../features/orders/presentation/my_orders_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String productDetails = '/product-details';
  static const String purchase = '/purchase';
  static const String myOrders = '/my-orders';
}

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case AppRoutes.productDetails:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
          settings: settings,
        );

      case AppRoutes.purchase:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => PurchaseScreen(product: product),
          settings: settings,
        );

      case AppRoutes.myOrders:
        return MaterialPageRoute(
          builder: (_) => const MyOrdersScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const _NotFoundScreen(),
          settings: settings,
        );
    }
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '404 — Page not found',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
