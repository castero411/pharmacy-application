// notifications_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:medicine_manager/UI/Pages/common/widgets/switch_tile.dart';
import '../../Provider/provider.dart';
import '../../Theme/colors.dart';

class NotificationsPage extends ConsumerWidget {
  // Change to ConsumerWidget
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider state to get the current switch value
    final isSwitched = ref.watch(switchProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SwitchTile(
              icon: Ionicons.notifications_outline,
              title: "Allow Notifications",
              isSwitched: isSwitched,
              onChanged: (bool value) {
                // Update the provider's state
                ref.read(switchProvider.notifier).state = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
