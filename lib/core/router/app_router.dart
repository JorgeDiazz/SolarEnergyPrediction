import 'package:go_router/go_router.dart';
import 'package:solar_energy_prediction/features/map/presentation/screens/map_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
