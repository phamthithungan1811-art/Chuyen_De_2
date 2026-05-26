import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../screens/product/add_product_screen.dart';
import '../../core/utils/format_utils.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    final product = productProvider.getById(productId);

    // =========================
    // PRODUCT NOT FOUND
    // =========================

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Sản phẩm không tồn tại')),

        body: const Center(
          child: Text('Sản phẩm đã bị xóa hoặc không tồn tại.'),
        ),
      );
    }

    // =========================
    // UI
    // =========================

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              // IMAGE
              SizedBox(
                height: 240,

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),

                  child: Image.network(
                    product.imageUrl,

                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.toys, size: 48));
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // NAME
              Text(
                product.name,

                style: const TextStyle(
                  fontSize: 22,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // DESCRIPTION
              Text(product.description, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 16),

              // PRICE
              Text(
                'Giá: ${product.price.toVnd()}',

                style: const TextStyle(
                  fontSize: 18,

                  color: Colors.redAccent,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // STOCK
              Text(
                'Tồn kho: ${product.stock}',

                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // EDIT BUTTON
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) => AddProductScreen(product: product),
                    ),
                  );
                },

                child: const Text('Sửa sản phẩm'),
              ),

              const SizedBox(height: 12),

              // DELETE BUTTON
              OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),

                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,

                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Xóa sản phẩm'),

                        content: const Text(
                          'Bạn có chắc muốn xóa sản phẩm này?',
                        ),

                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },

                            child: const Text('Hủy'),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },

                            child: const Text('Xóa'),
                          ),
                        ],
                      );
                    },
                  );

                  // =========================
                  // DELETE PRODUCT
                  // =========================

                  if (confirmed == true) {
                    final success = await context
                        .read<ProductProvider>()
                        .deleteProduct(product.id);

                    if (context.mounted) {
                      if (success) {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Xóa sản phẩm thành công'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Xóa sản phẩm thất bại'),
                          ),
                        );
                      }
                    }
                  }
                },

                child: const Text('Xóa sản phẩm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
