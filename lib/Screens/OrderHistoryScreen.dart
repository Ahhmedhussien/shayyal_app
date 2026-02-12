import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shyal/Component/CustomElevatedButton.dart';
import 'package:shyal/Models/Orders.dart';
import 'package:shyal/Services/OrderService.dart';
import 'package:shyal/const.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timelines/timelines.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
          title: const Text('Order History'),
          backgroundColor: background_color,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: const OrderHistoryCard(),
    );
  }
}

class OrderHistoryCard extends StatefulWidget {
  const OrderHistoryCard({super.key});

  @override
  State<OrderHistoryCard> createState() => _OrderHistoryCardState();
}

class _OrderHistoryCardState extends State<OrderHistoryCard> {
  bool isPendingSelected = true;

  void _toggleButton(bool isPending) {
    setState(() {
      isPendingSelected = isPending;
    });
  }

  late Future<List<Orders>> futureOrders;
  final OrdersService _ordersService = OrdersService();

  void _fetchPendingOrders() {
    setState(() {
      _toggleButton(true);
      futureOrders = _ordersService.fetchPendingOrders();
    });
  }

  void _fetchComplatedOrders() {
    setState(() {
      _toggleButton(false);
      futureOrders = _ordersService.fetchCompletedOrders();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPendingOrders();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final paddingSize = screenWidth * 0.04;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  title: 'Pending',
                  backgroundColor:
                      isPendingSelected ? green_color : Colors.grey,
                  onPressed: _fetchPendingOrders,
                ),
                const SizedBox(width: 8.0),
                CustomElevatedButton(
                  title: 'Completed',
                  backgroundColor:
                      isPendingSelected ? Colors.grey : green_color,
                  onPressed: _fetchComplatedOrders,
                ),
              ],
            ),
            SizedBox(height: paddingSize * 2),
            Expanded(
              child: FutureBuilder<List<Orders>>(
                future: futureOrders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No pending orders found'));
                  } else {
                    List<Orders> orders = snapshot.data!;
                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        Orders order = orders[index];
                        return OrderCard(order: order);
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Orders order;

  const OrderCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Secound_background_color,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.description,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            HorizontalTimeline(
              items: [
                TimelineItem(
                  indicator: DotIndicator(
                    color: order.orderStatus >= 0 ? Colors.green : Colors.grey,
                  ),
                  isCompleted: order.orderStatus >= 0,
                ),
                TimelineItem(
                  indicator: DotIndicator(
                    color: order.orderStatus >= 1 ? Colors.green : Colors.grey,
                  ),
                  isCompleted: order.orderStatus >= 1,
                ),
                TimelineItem(
                  indicator: DotIndicator(
                    color: order.orderStatus >= 2 ? Colors.green : Colors.grey,
                  ),
                  isCompleted: order.orderStatus > 2,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy').format(order.orderDate),
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        order.senderName,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        order.senderPhone,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        order.originAddress,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        softWrap: true,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white70,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy').format(order.orderDate.add(
                            const Duration(
                                days: 1))), // Assuming 1 day shipping
                        style: const TextStyle(color: Colors.white70),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        order.receiverName,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        order.receiverPhone,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        order.destinationAddress,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        softWrap: true,
                        maxLines: null,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: green_color,
                  ),
                  child: Center(
                      child: Text(order.orderStatus == 0
                          ? ' Pinding Now '
                          : " Complated ")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalTimeline extends StatelessWidget {
  final List<TimelineItem> items;

  const HorizontalTimeline({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length * 2 - 1, (index) {
          if (index % 2 == 0) {
            int itemIndex = index ~/ 2;
            return items[itemIndex].indicator;
          } else {
            return Flexible(
              child: Container(
                height: 2.5,
                color: items[(index - 1) ~/ 2].isCompleted
                    ? Colors.green
                    : Colors.grey,
              ),
            );
          }
        }),
      ),
    );
  }
}

class TimelineItem {
  final Widget indicator;
  final bool isCompleted;

  TimelineItem({required this.indicator, required this.isCompleted});
}

class DotIndicator extends StatelessWidget {
  final Color color;

  const DotIndicator({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
