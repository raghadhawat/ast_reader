import 'package:ast_reader/constants.dart';
import 'package:ast_reader/features/home/presentation/views/all_result_view.dart';
import 'package:ast_reader/features/home/presentation/views/confussing_view.dart';
import 'package:ast_reader/features/home/presentation/views/search_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _index = 0;

  final _pages = const [
    AllResultView(),
    SearchView(),
    ConfussingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true, // lets the FAB float nicely
        body: _pages[_index],

        // ---------- Floating Action Button ----------
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: kPrimaryColor,
          elevation: 3,
          onPressed: () {
            // TODO: your action
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        // ---------- Custom Bottom Bar ----------
        bottomNavigationBar: _BottomBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0x26000000), width: 0.6), // thin divider
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, -1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavItem(
            icon: Icons.list_alt_outlined, // “list” style
            selected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            icon: Icons.search,
            selected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          // circle-arrows with a small question mark overlay (to mimic your icon)
          _NavItem.custom(
            selected: currentIndex == 2,
            onTap: () => onTap(2),
            builder: (color) => Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.autorenew_outlined, size: 28, color: color),
                Text('?',
                    style: TextStyle(fontSize: 14, color: color, height: 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selected,
    required this.onTap,
  }) : builder = null;

  const _NavItem.custom({
    required this.builder,
    required this.selected,
    required this.onTap,
  }) : icon = null;

  final IconData? icon;
  final Widget Function(Color color)? builder;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color =
        selected ? kPrimaryColor : kPrimaryColor.withOpacity(0.65);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            builder != null
                ? builder!(color)
                : Icon(icon, size: 28, color: color),

            // active dot (only visible when selected)
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: selected ? kPrimaryColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
