import 'package:flutter/material.dart';

void main() => runApp(const ShopTopApp());

class Product {
  final String name, image, category;
  final int price, oldPrice;
  final double rating;
  Product(this.name, this.image, this.category, this.price, this.oldPrice, this.rating);
}

final products = [
  Product('Nike Air Force 1', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800', 'Fashion', 2499, 4999, 4.5),
  Product('Smart Watch', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800', 'Electronics', 3999, 7999, 4.4),
  Product('Wireless Headphones', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800', 'Electronics', 1999, 3999, 4.6),
  Product('Travel Backpack', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800', 'Fashion', 1299, 2499, 4.3),
];

class ShopTopApp extends StatelessWidget {
  const ShopTopApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Shop Top',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4B24D4)),
      scaffoldBackgroundColor: const Color(0xFFF8F8FC),
      fontFamily: 'Arial',
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  final cart = <Product>[];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(context),
      _categories(context),
      _wishlist(context),
      _cart(context),
      _account(context),
    ];
    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Wishlist'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  Widget _home(BuildContext context) => CustomScrollView(
    slivers: [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
        sliver: SliverToBoxAdapter(child: Row(
          children: [
            Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFF4B24D4), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.shopping_bag, color: Colors.white)),
            const SizedBox(width: 10),
            const Text.rich(TextSpan(children: [
              TextSpan(text: 'Shop ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4B24D4))),
              TextSpan(text: 'Top', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange)),
            ])),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ],
        )),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        sliver: SliverToBoxAdapter(child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for products, brands and more...',
            prefixIcon: const Icon(Icons.search),
            filled: true, fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          ),
        )),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
        sliver: SliverToBoxAdapter(child: Container(
          height: 150, padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF332080), Color(0xFF6544D9)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Top Deals', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
            Text('Up to 70% Off', style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 14),
            Chip(label: Text('Shop Now')),
          ]),
        )),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        sliver: SliverToBoxAdapter(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Best Selling Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('See All', style: TextStyle(color: Color(0xFF4B24D4))),
          ],
        )),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(18),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .68),
          delegate: SliverChildBuilderDelegate((_, i) => _productCard(products[i]), childCount: products.length),
        ),
      ),
    ],
  );

  Widget _productCard(Product p) => Card(
    elevation: 0, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.antiAlias,
    child: InkWell(onTap: () => _details(p), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Image.network(p.image, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 50))),
      Padding(padding: const EdgeInsets.fromLTRB(10, 8, 10, 10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('₹${p.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text('₹${p.oldPrice}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12)),
        Row(children: [const Icon(Icons.star, size: 15, color: Colors.amber), Text(' ${p.rating}')]),
      ])),
    ])),
  );

  void _details(Product p) => showModalBottomSheet(
    context: context, isScrollControlled: true,
    builder: (_) => Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(borderRadius: BorderRadius.circular(18), child: Image.network(p.image, height: 240, width: double.infinity, fit: BoxFit.cover)),
      const SizedBox(height: 15),
      Text(p.name, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      Text('⭐ ${p.rating}   ${p.category}', style: const TextStyle(color: Colors.grey)),
      const SizedBox(height: 8),
      Text('₹${p.price}', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      SizedBox(width: double.infinity, child: FilledButton(
        onPressed: () { setState(() => cart.add(p)); Navigator.pop(context); setState(() => tab = 3); },
        child: const Text('Add to Cart'),
      )),
      const SizedBox(height: 8),
    ])),
  );

  Widget _categories(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text('Categories', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      ...['Mobiles','Fashion','Electronics','Home & Living','Beauty','Sports','Toys & Kids','Books'].map((x) => Card(
        child: ListTile(leading: CircleAvatar(child: Icon(Icons.category_outlined)), title: Text(x), trailing: const Icon(Icons.chevron_right)),
      )),
    ],
  );

  Widget _wishlist(BuildContext context) => const Center(child: Text('Your wishlist is empty', style: TextStyle(fontSize: 18)));

  Widget _cart(BuildContext context) {
    final total = cart.fold<int>(0, (s, p) => s + p.price);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('My Cart', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        if (cart.isEmpty) const Padding(padding: EdgeInsets.only(top: 100), child: Center(child: Text('Your cart is empty'))),
        ...cart.map((p) => Card(child: ListTile(
          leading: Image.network(p.image, width: 55, fit: BoxFit.cover),
          title: Text(p.name),
          subtitle: Text('₹${p.price}'),
          trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => cart.remove(p))),
        ))),
        if (cart.isNotEmpty) ...[
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text('₹$total', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 15),
          FilledButton(onPressed: () => _checkout(total), child: const Text('Proceed to Checkout')),
        ],
      ],
    );
  }

  void _checkout(int total) => showDialog(context: context, builder: (_) => AlertDialog(
    title: const Text('Checkout'),
    content: Text('Total: ₹$total\n\nPayment integration can be connected next (UPI, cards, COD).'),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
  ));

  Widget _account(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const CircleAvatar(radius: 38, child: Icon(Icons.person, size: 40)),
      const SizedBox(height: 12),
      const Center(child: Text('Welcome to Shop Top', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
      const SizedBox(height: 25),
      ...['My Orders','My Addresses','Wishlist','Wallet & Payments','Help & Support','Settings'].map((x) => Card(child: ListTile(title: Text(x), trailing: const Icon(Icons.chevron_right)))),
    ],
  );
}
