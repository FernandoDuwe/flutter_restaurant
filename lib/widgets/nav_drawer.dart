import "package:flutter/material.dart";

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            color: Colors.purple,
            child: Text(
              "Teste de navegação",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
