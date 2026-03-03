import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              child: Row(
                spacing: 10,
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(.circular(5)),
                    ),
                    child: Icon(Icons.car_crash, color: Colors.white),
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "VehicleCheck",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: .bold,
                        ),
                      ),
                      Text(
                        "Inspeção Veicular",
                        style: TextStyle(fontWeight: .w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
