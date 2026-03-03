import 'package:flutter/material.dart';
import 'package:inspecao_veicular_petroeng/components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final alturaSafe =
        mq.size.height - mq.viewPadding.top - mq.viewPadding.bottom;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: alturaSafe * 0.1,
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
            SizedBox(
              height: alturaSafe * 0.25,
              width: .infinity,
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                spacing: 12,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Icon(Icons.shield, color: Colors.white),
                  ),
                  Text(
                    "Bem-vindo de volta",
                    style: TextStyle(fontWeight: .bold, fontSize: 25),
                  ),
                  Text("Entre em sua conta para continuar"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              padding: EdgeInsets.fromLTRB(20, 30, 10, 20),
              height: alturaSafe * 0.55,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  style: .solid,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
