import 'package:flutter/material.dart';
import 'package:trexxo_mobility/widgets/custom_text_fields.dart';

class PositionedRideRequestCard extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onGetLocationPressed;

  const PositionedRideRequestCard({
    super.key,
    required this.isLoading,
    required this.onGetLocationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LocationButton(
              isLoading: isLoading,
              onPressed: onGetLocationPressed,
            ),
            const SizedBox(height: 8),
            _RideRequestCardContent(),
          ],
        ),
      ),
    );
  }
}

class _LocationButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _LocationButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: isLoading ? null : onPressed,
          icon:
              isLoading
                  ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Icon(Icons.my_location_rounded, size: 28),
          tooltip: 'Get Current Location',
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}

class _RideRequestCardContent extends StatelessWidget {
  const _RideRequestCardContent();

  @override
  Widget build(BuildContext context) {
    final cardColor = Colors.white.withOpacity(0.95);
    const borderRadius = 12.0;
    const padding = 16.0;
    final boxShadow = BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 10,
      offset: const Offset(0, 5),
    );

    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [boxShadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Get a Ride Now',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          LocationInputField(label: 'Pickup Location', icon: Icons.my_location),
          const SizedBox(height: 12),
          LocationInputField(
            label: 'Drop-off Location',
            icon: Icons.location_on,
          ),
        ],
      ),
    );
  }
}
