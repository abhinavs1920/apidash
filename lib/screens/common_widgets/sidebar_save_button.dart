import 'package:apidash_design_system/apidash_design_system.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:apidash/consts.dart';
import 'package:apidash/providers/providers.dart';
import 'package:apidash/utils/utils.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return TextButton.icon(
      onPressed: () {saveData(context, ref);} ,
      icon: const Icon(
        Icons.save,
        size: 20,
      ),
      label: const Text(
        kLabelSave,
        style: kTextStyleButton,
      ),
    );
  }

  static void saveData(BuildContext context, WidgetRef ref) async {
    final savingData = ref.watch(saveDataStateProvider);
    final hasUnsavedChanges = ref.watch(hasUnsavedChangesProvider);
    final overlayWidget = OverlayWidgetTemplate(context: context);
    (savingData || !hasUnsavedChanges)
        ? null
        :{
      overlayWidget.show(
          widget: const SavingOverlay(saveCompleted: false)),

      await ref
          .read(collectionStateNotifierProvider.notifier)
          .saveData(),
      await ref
          .read(environmentsStateNotifierProvider.notifier)
          .saveEnvironments(),
      overlayWidget.hide(),
      overlayWidget.show(
          widget: const SavingOverlay(saveCompleted: true)),
      await Future.delayed(const Duration(seconds: 1)),
      overlayWidget.hide(),
    };
  }
}


