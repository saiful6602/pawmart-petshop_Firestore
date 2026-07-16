import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routes/app_router.dart';
import '../../../data/models/product.dart';
import '../../../data/sources/product_repository.dart';
import '../widgets/product_grid_card.dart';

/// Home screen — entry point of the app.
/// Streams the product catalogue from Cloud Firestore in real time.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductRepository _productRepository = ProductRepository();
  String _selectedCategory = 'All';

  static const List<String> _categories = [
    'All',
    'Dog Food',
    'Cat Food',
    'Toys',
    'Accessories',
    'Grooming',
    'Health & Wellness',
    'Bedding',
    'Aquarium',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: StreamBuilder<List<Product>>(
        stream: _productRepository.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _ErrorState(message: '${snapshot.error}');
          }

          final allProducts = snapshot.data ?? [];
          final isLoading = snapshot.connectionState == ConnectionState.waiting;

          final filteredProducts = _selectedCategory == 'All'
              ? allProducts
              : allProducts.where((p) => p.category == _selectedCategory).toList();

          return CustomScrollView(
            slivers: [
              _buildAppBar(context, colorScheme, textTheme),
              const SliverToBoxAdapter(child: _HeroBanner()),
              _buildCategoryFilter(colorScheme, textTheme),
              _buildSectionHeader(colorScheme, textTheme, filteredProducts.length),
              if (isLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (filteredProducts.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyState(hasAnyProducts: allProducts.isNotEmpty),
                )
              else
                _buildProductGrid(filteredProducts),
            ],
          );
        },
      ),
    );
  }

  SliverAppBar _buildAppBar(
      BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 1,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(AppConstants.radiusSM),
            ),
            child: Icon(Icons.pets_rounded, size: 18, color: colorScheme.onPrimary),
          ),
          const SizedBox(width: AppConstants.spacingSM),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConstants.appName,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              Text(
                AppConstants.tagline,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.myOrders),
          icon: const Icon(Icons.receipt_long_outlined),
          tooltip: 'My Orders',
        ),
        const SizedBox(width: AppConstants.spacingXS),
      ],
    );
  }

  SliverToBoxAdapter _buildCategoryFilter(ColorScheme colorScheme, TextTheme textTheme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppConstants.spacingMD,
          bottom: AppConstants.spacingSM,
        ),
        child: SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMD),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppConstants.spacingSM),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingMD,
                    vertical: AppConstants.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppConstants.radiusXL),
                  ),
                  child: Text(
                    category,
                    style: textTheme.labelMedium?.copyWith(
                      color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildSectionHeader(
      ColorScheme colorScheme, TextTheme textTheme, int count) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spacingMD, AppConstants.spacingSM, AppConstants.spacingMD, AppConstants.spacingSM,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Text(
              _selectedCategory,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(width: AppConstants.spacingSM),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingSM, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppConstants.radiusSM),
              ),
              child: Text(
                '$count',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildProductGrid(List<Product> products) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spacingMD, 0, AppConstants.spacingMD, AppConstants.spacingXL,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ProductGridCard(product: products[index]),
          childCount: products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppConstants.spacingSM,
          mainAxisSpacing: AppConstants.spacingSM,
          childAspectRatio: 0.68,
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spacingMD, AppConstants.spacingSM, AppConstants.spacingMD, 0,
      ),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                Icons.pets_rounded,
                size: 130,
                color: colorScheme.onPrimary.withValues(alpha: 0.08),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingSM, vertical: 3),
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                    ),
                    child: Text(
                      'Trusted by pet parents',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSM),
                  Text(
                    'Quality care for\nevery furry friend',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
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

class _EmptyState extends StatelessWidget {
  final bool hasAnyProducts;
  const _EmptyState({required this.hasAnyProducts});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pets_outlined, size: 56, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
            const SizedBox(height: AppConstants.spacingSM),
            Text(
              hasAnyProducts ? 'No products in this category.' : 'No products available yet.',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            if (!hasAnyProducts) ...[
              const SizedBox(height: AppConstants.spacingXS),
              Text(
                'Add some from the Firebase Console to get started.',
                style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        child: Text('Something went wrong:\n$message', textAlign: TextAlign.center),
      ),
    );
  }
}
