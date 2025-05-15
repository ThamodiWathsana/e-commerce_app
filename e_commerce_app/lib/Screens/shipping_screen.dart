import 'package:flutter/material.dart';

class ChooseShippingScreen extends StatefulWidget {
  const ChooseShippingScreen({super.key});

  @override
  State<ChooseShippingScreen> createState() => _ChooseShippingScreenState();
}

class _ChooseShippingScreenState extends State<ChooseShippingScreen> {
  int _selectedShipping = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        title: const Text(
          'Choose Shipping',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Economy shipping option
              ShippingOption(
                title: 'Economy',
                deliveryDate: '25 August 2023',
                icon: Icons.local_shipping_outlined,
                isSelected: _selectedShipping == 0,
                onTap: () => setState(() => _selectedShipping = 0),
              ),
              const SizedBox(height: 16),

              // Regular shipping option
              ShippingOption(
                title: 'Regular',
                deliveryDate: '24 August 2023',
                icon: Icons.local_shipping_outlined,
                isSelected: _selectedShipping == 1,
                onTap: () => setState(() => _selectedShipping = 1),
              ),
              const SizedBox(height: 16),

              // Cargo shipping option
              ShippingOption(
                title: 'Cargo',
                deliveryDate: '22 August 2023',
                icon: Icons.local_shipping_outlined,
                isSelected: _selectedShipping == 2,
                onTap: () => setState(() => _selectedShipping = 2),
              ),
              const SizedBox(height: 16),

              // Friend's House shipping option
              ShippingOption(
                title: 'Friend\'s House',
                deliveryDate: 'Royal Ln. Mesa, New Jersey 45463',
                icon: Icons.local_shipping_outlined,
                isSelected: _selectedShipping == 3,
                onTap: () => setState(() => _selectedShipping = 3),
              ),

              const Spacer(),

              // Apply button with rounded corners
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

class ShippingOption extends StatelessWidget {
  final String title;
  final String deliveryDate;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ShippingOption({
    Key? key,
    required this.title,
    required this.deliveryDate,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.black),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    title == 'Friend\'s House'
                        ? deliveryDate
                        : 'Estimated Arrival: $deliveryDate',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
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
