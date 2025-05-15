import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'location_screen.dart';

class ShippingAddressSelectionScreen extends StatefulWidget {
  const ShippingAddressSelectionScreen({super.key});

  @override
  State<ShippingAddressSelectionScreen> createState() =>
      _ShippingAddressSelectionScreenState();
}

class _ShippingAddressSelectionScreenState
    extends State<ShippingAddressSelectionScreen> {
  int _selectedAddress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Choose Shipping',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AddressOption(
                title: 'Economy',
                address: 'Estimated Arrival 25 August 2023',
                icon: Icons.local_shipping_outlined,
                isSelected: _selectedAddress == 0,
                onTap: () => setState(() => _selectedAddress = 0),
              ),
              const SizedBox(height: 16),
              AddressOption(
                title: 'Regular',
                address: 'Estimated Arrival 24 August 2023',
                icon: Icons.fire_truck_outlined,
                isSelected: _selectedAddress == 1,
                onTap: () => setState(() => _selectedAddress = 1),
              ),
              const SizedBox(height: 16),
              AddressOption(
                title: 'Cargo',
                address: 'Estimated Arrival 22 August 2023',
                icon: Icons.local_shipping_outlined,
                isSelected: _selectedAddress == 2,
                onTap: () => setState(() => _selectedAddress = 2),
              ),
              const SizedBox(height: 16),
              AddressOption(
                title: 'Friend\'s House',
                address: '2464 Royal Ln. Mesa, New Jersey 45463',
                icon: Icons.home_work_outlined,
                isSelected: _selectedAddress == 3,
                onTap: () => setState(() => _selectedAddress = 3),
              ),
              const SizedBox(height: 24),

              /// Add new address (DOTTED)
              DottedBorder(
                color: Colors.brown,
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 4],
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationAccessScreen(),
                      ),
                    );
                  },

                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Add New Shipping Address',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              /// Apply button with rounded corners
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color(0xFF7D5A50),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressOption extends StatelessWidget {
  final String title;
  final String address;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressOption({
    Key? key,
    required this.title,
    required this.address,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
            Radio(
              value: true,
              groupValue: isSelected,
              activeColor: const Color(0xFF7D5A50),
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}
