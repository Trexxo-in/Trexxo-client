import 'package:flutter/material.dart';
import 'package:trexxo_mobility/screens/home/widgets/location_selection_card.dart';
import 'package:trexxo_mobility/widgets/custom_text_fields.dart';

class InitCard extends StatelessWidget {
  const InitCard({super.key});

  @override
  Widget build(BuildContext context) {
    final pickupController = TextEditingController();
    final dropoffController = TextEditingController();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Set your destination',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder:
                      (_) => LocationSelectionBottomSheet(
                        pickupController: pickupController,
                        dropoffController: dropoffController,
                      ),
                );
              },
              child: AbsorbPointer(
                child: LocationInputField(
                  controller: dropoffController,
                  label: 'Where to?',
                  icon: Icons.location_on,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
