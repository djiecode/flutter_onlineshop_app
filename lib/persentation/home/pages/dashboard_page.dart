// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_onlineshop_app/persentation/account/pages/account_page.dart';
import 'package:flutter_onlineshop_app/persentation/home/pages/home_page.dart';
import 'package:flutter_onlineshop_app/persentation/home/pages/search_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../../orders/pages/cart_page.dart';

class DashboardPage extends StatefulWidget {
  final int currentTab;
  const DashboardPage({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _selectedIndex;
  final List<Widget> _pages = [
    const HomePage(),
    // const SearchPage(),
    const CartPage(),
    // const Center(
    //   child: Text('This Page 1'),
    // ),
    // const Center(
    //   child: Text('This Page 2'),
    // ),
    // const Center(
    //   child: Text('This Page 3'),
    // ),
      
    const SearchPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    _selectedIndex = widget.currentTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(37, 150, 190, 1),
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.home.svg(),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.order.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.order.svg(),
            label: 'ORDER',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.search.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.search.svg(),
            label: 'EXPLORE',
          ),
          
          BottomNavigationBarItem(
            icon: Assets.icons.person.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.person.svg(),
            label: 'ACCOUNT',
          ),
        ],
      ),
    );
  }
}