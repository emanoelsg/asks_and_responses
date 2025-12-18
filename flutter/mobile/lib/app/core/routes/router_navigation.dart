import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../view/pages/home_page.dart';
import '../../view/pages/perguntas_details_page.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const PerguntasScreen(),
  ),
  GoRoute(
    path: '/details/:id',
    builder: (BuildContext context, GoRouterState state) {
      final int? itemId = int.tryParse(state.pathParameters['id']??'1');
      return AskDetails(itemId: itemId!);
    },
  ),
]);
