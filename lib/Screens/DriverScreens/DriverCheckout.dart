import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/const.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
        backgroundColor: background_color,
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize
                .min, // Ensures the column doesn't expand to fill the entire scroll view
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Secound_background_color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Invoice',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Number:',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'Date:',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ID: 5595615165',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          '25 April 2024',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildAddressSection(),
              const SizedBox(height: 20),
              _buildProductList(),
              const Divider(color: Colors.grey),
              _buildTotalPriceSection(),
              const SizedBox(height: 250),
              CustomButton(title: 'OK', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Billing Address:',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(width: 10),
        Text(
          'Asyut, Train Railways',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(width: 100),
        Text(
          'Shipping Address:',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(width: 10),
        Text(
          'Assiut, Dairout, 16 Othman ibn Affan St.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildProductList() {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ListTile(
            title: Text('Order Fee',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            trailing: Text('\$1300',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          ListTile(
            title: Text('App fee',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            trailing: Text('\$5',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceSection() {
    return const ListTile(
      title: Text(
        'Total price',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        '\$1415',
        style: TextStyle(
            color: green_color, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
