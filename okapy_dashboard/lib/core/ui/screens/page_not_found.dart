import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:okapy_dashboard/core/ui/component/heading_text.dart';
import 'package:okapy_dashboard/core/ui/utils/utils.dart';

class PageNotFound extends StatelessWidget {
  final GoRouterState state;
  const PageNotFound({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HeadingText(text: "Page Not Found"),
            SizedBox(
              height: AppUtils.getAppHeight(context) / 8,
            ),
            Text('The page "${state.location}" does not exist'),
          ],
        ),
      ),
    );
  }
}
