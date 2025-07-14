import 'package:flutter/material.dart';

class RideConfirmationBottomSheet extends StatefulWidget {
  const RideConfirmationBottomSheet({super.key});

  @override
  State<RideConfirmationBottomSheet> createState() =>
      _RideConfirmationBottomSheetState();
}

class _RideConfirmationBottomSheetState
    extends State<RideConfirmationBottomSheet> {
  String _selectedVehicle = 'Standard Taxi';
  String _selectedPayment = 'Wallet';

  void _changePaymentMethod() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Wrap(
              children: [
                const Text(
                  "Choose Payment Method",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                _buildPaymentOption(Icons.account_balance_wallet, "Wallet"),
                _buildPaymentOption(Icons.credit_card, "Credit/Debit Card"),
                _buildPaymentOption(Icons.money, "Cash"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        setState(() => _selectedPayment = title);
        Navigator.of(context).pop();
      },
    );
  }

  void _confirmTrip() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Trip Confirmed!')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    "Select Your Ride",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildVehicleOption(Icons.local_taxi, "Standard Taxi"),
                  _buildVehicleOption(Icons.car_rental, "Luxury Car"),
                  const Divider(),
                  Text(
                    "Selected Payment Method: $_selectedPayment",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: _changePaymentMethod,
                    icon: const Icon(Icons.payment),
                    label: const Text("Change Payment"),
                  ),
                  ElevatedButton(
                    onPressed: _confirmTrip,
                    child: const Text("Confirm Trip"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleOption(IconData icon, String title) {
    final isSelected = _selectedVehicle == title;
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing:
          isSelected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () => setState(() => _selectedVehicle = title),
    );
  }
}
