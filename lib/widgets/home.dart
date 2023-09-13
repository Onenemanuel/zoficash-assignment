import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zoficash/blocs/blocs.dart';
import 'package:zoficash/router.dart';

import 'package:zoficash/styles/styles.dart';
import 'package:zoficash/widgets/widgets.dart';

class MoneytoryData {
  MoneytoryData({
    required this.color,
    required this.label,
    required this.percentage,
  });

  final Color color;
  final String label;
  final int percentage;
}

enum InOutStatus { incoming, outgoing }

extension InOutStatusX on InOutStatus {
  bool get incoming => this == InOutStatus.incoming;
  bool get outgoing => this == InOutStatus.outgoing;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String route = "/home";

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    final theme = Theme.of(context);

    List<MoneytoryData> chatData = [
      MoneytoryData(
        color: AppColors.blue,
        label: "Entertainment",
        percentage: 78,
      ),
      MoneytoryData(
        color: AppColors.orange.shade800,
        label: "Top Up",
        percentage: 16,
      ),
      MoneytoryData(
        color: AppColors.yellow,
        label: "Food",
        percentage: 6,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.darken(percent: 5, color: AppColors.white),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.blue,
        title: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "IDR 24,420,000",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Text(
              "Active Balance",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.lighten(
                  color: AppColors.blue,
                  percent: 50,
                ),
              ),
            ),
          ),
        ),
        actions: const [
          Center(
            child: Badge(
              backgroundColor: AppColors.orange,
              child: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(width: 20),
          CircleAvatar(
            backgroundColor: AppColors.white,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=400&q=60",
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            color: AppColors.blue,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: AppColors.lighten(
                              color: AppColors.blue,
                              percent: 10,
                            ),
                            padding: const EdgeInsets.all(20),
                            child:
                                const Icon(Icons.send, color: AppColors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Send",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: AppColors.lighten(
                              color: AppColors.blue,
                              percent: 10,
                            ),
                            padding: const EdgeInsets.all(20),
                            child: const Icon(
                              color: AppColors.white,
                              Icons.input_rounded,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Request",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: AppColors.lighten(
                              color: AppColors.blue,
                              percent: 10,
                            ),
                            padding: const EdgeInsets.all(20),
                            child: const Icon(
                              Icons.compare_arrows_rounded,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "In & Out",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: AppColors.lighten(
                              color: AppColors.blue,
                              percent: 10,
                            ),
                            padding: const EdgeInsets.all(20),
                            child: const Icon(
                              color: AppColors.white,
                              Icons.qr_code,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "QR Code",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const ListTile(
                      title: Text("Card Center"),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardCenterWidget(
                              name: "Virtual Card",
                              amount: "20,400,000",
                              number: "5678",
                            ),
                            Divider(),
                            CardCenterWidget(
                              name: "Basic Card",
                              amount: "4,020,000",
                              number: "4556",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const ListTile(
                      title: Text("Moneytory"),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Expenses",
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "01 Mar 2021 - 16 Mar 2021",
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "IDR 540,000",
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: SfCircularChart(
                                    margin: EdgeInsets.zero,
                                    palette: chatData
                                        .map((data) => data.color)
                                        .toList(),
                                    series: <CircularSeries>[
                                      DoughnutSeries<MoneytoryData, String>(
                                        radius: "50",
                                        innerRadius: "30",
                                        dataSource: chatData,
                                        xValueMapper: (MoneytoryData data, _) =>
                                            data.label,
                                        yValueMapper: (MoneytoryData data, _) =>
                                            data.percentage,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: chatData.map((data) {
                                  return Row(
                                    children: [
                                      Chip(
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 3,
                                        ),
                                        backgroundColor: data.color,
                                        label: Text(
                                          "${data.percentage}% ${data.label}",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    const ListTile(
                      title: Text("In & Out"),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InOutWidget(
                              name: "Setlement",
                              date: "12 Mar 2021",
                              amount: "32,123",
                              status: InOutStatus.incoming,
                            ),
                            Divider(),
                            InOutWidget(
                              name: "Google Play",
                              date: "10 Mar 2021",
                              amount: "80,000",
                              status: InOutStatus.outgoing,
                            ),
                            Divider(),
                            InOutWidget(
                              name: "Nohan Putra",
                              date: "09 Mar 2021",
                              amount: "150,000",
                              status: InOutStatus.incoming,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Center(
                        child: Text("Logout"),
                      ),
                      onPressed: () {
                        _onLogoutPressed(context, router);
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GNav(
            color: AppColors.grey,
            activeColor: AppColors.white,
            padding: const EdgeInsets.all(10),
            backgroundColor: AppColors.white,
            tabBackgroundColor: AppColors.blue,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
            onTabChange: (index) {},
            gap: 8,
            tabs: const [
              GButton(
                text: "Home",
                icon: Icons.home_outlined,
              ),
              GButton(
                text: "Wallet",
                icon: Icons.account_balance_wallet_outlined,
              ),
              GButton(
                text: "Map",
                icon: Icons.map_outlined,
              ),
              GButton(
                text: "User",
                icon: Icons.person_outline_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogoutPressed(BuildContext context, GoRouter router) {
    context.read<AuthBloc>().add(const Unauthenticate());
    router.go(LoginScreen.route);
  }
}

class CardCenterWidget extends StatelessWidget {
  const CardCenterWidget({
    super.key,
    required this.name,
    required this.number,
    required this.amount,
  });

  final String name;
  final String number;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.blue.withOpacity(0.2),
        ),
        child: IconButton(
          color: AppColors.blue,
          onPressed: () {},
          icon: const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.credit_card_rounded),
          ),
        ),
      ),
      title: Text(name),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            _buildCardNumberDots(),
            const SizedBox(width: 5),
            Text(number),
          ],
        ),
      ),
      trailing: Text(amount),
    );
  }

  Widget _buildCardNumberDots() {
    List<Widget> widgets = [];

    for (int i = 0; i < 4; i++) {
      var middleDot = const Text(
        "\u00B7",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 25,
        ),
      );
      widgets.add(middleDot);
    }

    return Row(children: widgets);
  }
}

class InOutWidget extends StatelessWidget {
  const InOutWidget({
    super.key,
    required this.name,
    required this.date,
    required this.amount,
    required this.status,
  });

  final String name;
  final String date;
  final String amount;
  final InOutStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.blue.withOpacity(0.2),
        ),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Text(
              name.characters.first,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
      ),
      title: Text(name),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(date),
      ),
      trailing: Text(
        status.incoming ? "+ $amount" : amount,
        style: status.incoming ? const TextStyle(color: AppColors.green) : null,
      ),
    );
  }
}
