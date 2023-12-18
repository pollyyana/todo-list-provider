//componente de cabeçalho

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/auth_provider.dart';
import 'package:todo_list/app/core/ui/theme_extension.dart';
// import 'package:todo_list/app/core/auth/auth_provider.dart';
// import 'package:todo_list/app/core/ui/theme_extension.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //extrair do provider com selector
        Padding(
          padding:EdgeInsets.symmetric(horizontal: 20),
          child: Selector<AuthProvider, String>(
            selector: (context, authProvider) =>
                authProvider.user?.displayName ?? ' NAO INFORMADO',
            builder: (_, value, __) {
              return Text(
                'E aí, $value!',
                style: context.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              );
            },
          ),
        )
      ],
    );
  }
}
