import 'package:flutter/material.dart';
import 'package:flutter_base/common/presentation/widgets/scaffold/base_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routePath = "/";

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      backButton: false,
      title: "Home",
      body: Center(child: Text('Welcome to Home Page')),
    );
  }
}
