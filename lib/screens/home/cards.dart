import 'package:flutter/material.dart';
import 'package:trexxo_mobility/screens/home/widgets/location_selection_bottom_sheet.dart';
import 'package:trexxo_mobility/widgets/custom_text_fields.dart';

class RideRequestCard extends StatefulWidget {
  const RideRequestCard({super.key});

  @override
  State<RideRequestCard> createState() => _RideRequestCardState();
}

class _RideRequestCardState extends State<RideRequestCard> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  void _showExpandedModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => LocationSelectionBottomSheet(
            pickupController: _pickupController,
            dropoffController: _dropoffController,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 5),
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
              onTap: () => _showExpandedModal(context),
              child: AbsorbPointer(
                child: LocationInputField(
                  controller: _dropoffController,
                  label: 'Where to?',
                  icon: Icons.location_on,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _showExpandedModal(context),
              icon: const Icon(Icons.check),
              label: const Text('Confirm Destination'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
