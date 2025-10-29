import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_manager.dart';
import 'cart_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopEasy',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
        fontFamily: 'Suwannaphum',
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: Colors.indigo.shade700,
      letterSpacing: 0.5,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ShopEasy', style: titleStyle),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to ShopEasy',
                textAlign: TextAlign.center,
                style: titleStyle?.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 16),
              Text(
                'Your everyday shopping companion.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                          color: Color(0x1A000000),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/images/local_sample.png',
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => const Center(
                        child: Text('Add\nlocal image', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                          color: Color(0x1A000000),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      'https://picsum.photos/300',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      Navigator.of(context).push(_fadeRoute(const SignUpPage()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Text('Sign-up', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).push(_fadeRoute(const SignInPage()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Text('Sign-in', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Full name required';
    final t = v.trim();
    final first = t[0];
    if (first != first.toUpperCase()) return 'First letter must be uppercase';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email required';
    if (!v.contains('@')) return 'Email must include @';
    return null;
  }

  String? _validatePwd(String? v) {
    if (v == null || v.length < 6) return 'At least 6 characters';
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v != _pwdCtrl.text) return 'Passwords do not match';
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Account created successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  _fadeRoute(const HomePage()),
                      (route) => false,
                );
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(' تسجيل الحساب')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TField(
                  controller: _nameCtrl,
                  label: 'الأسم',
                  hint: 'e.g., Ahmed Ali',
                  validator: _validateName,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),
                _TField(
                  controller: _emailCtrl,
                  label: 'الأيميل',
                  hint: 'e.g., name@email.com',
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                _TField(
                  controller: _pwdCtrl,
                  label: 'كلمة المرور',
                  hint: 'على الأقل 6 عناصر',
                  validator: _validatePwd,
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                _TField(
                  controller: _confirmCtrl,
                  label: 'تأكيد كلمة المرور',
                  hint: 'اعد ادخال كلمة المرور',
                  validator: _validateConfirm,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _submit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('التسجيل'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email required';
    if (!v.contains('@')) return 'Email must include @';
    return null;
  }

  String? _validatePwd(String? v) {
    if (v == null || v.length < 6) return 'At least 6 characters';
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Account sign-in successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  _fadeRoute(const HomePage()),
                      (route) => false,
                );
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TField(
                  controller: _emailCtrl,
                  label: 'Email',
                  hint: 'e.g., name@email.com',
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                _TField(
                  controller: _pwdCtrl,
                  label: 'Password',
                  hint: 'Min 6 characters',
                  validator: _validatePwd,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _submit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('Sign in'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Local assets instead of URLs
    final featured = List<String>.generate(
      5,

          (i) => 'assets/images/featured${i + 1}.jpg',
    );

    final products = List.generate(8, (i) => {
      'title': 'Product ${i + 1}',
      'image': 'assets/images/product${i + 1}.jpg',
    });

    final offers = List.generate(5, (i) => {
      'title': 'Hot Offer ${i + 1}',
      'image': 'assets/images/offer${i + 1}.jpg',
      'desc': 'Limited-time deal on item ${i + 1}.',
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Products / منتجاتنا'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const CartPage(),
                  ));
                },
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Consumer<CartManager>(
                  builder: (_, cart, __) => cart.totalItems > 0
                      ? CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cart.totalItems.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.88),
                itemCount: featured.length,
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(featured[i], fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Products grid
            Text('Browse',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.78,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                for (final p in products)
                  _ProductCard(
                    title: p['title']!,
                    imageUrl: p['image']!,
                    onAdd: () {
                      context.read<CartManager>().addItem(p['title']!, p['image']!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item added to the cart')),
                      );
                    },
                  ),
              ],
            ),

            // Offers
            const SizedBox(height: 24),
            Text('Hot Offers',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Column(
              children: [
                for (final o in offers)
                  ListTile(
                    leading: Image.asset(o['image']!, width: 60, height: 60, fit: BoxFit.cover),
                    title: Text(o['title']!),
                    subtitle: Text(o['desc']!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onAdd;

  const _ProductCard({
    required this.title,
    required this.imageUrl,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const Center(
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}




class _TField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  const _TField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}