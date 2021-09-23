import 'package:flutter/material.dart';
import 'contact_list_page.dart';
import '../widgets/feature_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/bytebank_logo.png'),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  FeatureButtonWidget(
                    icon: Icons.monetization_on,
                    label: 'Transferir',
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ContactList(),
                        ),
                      );
                    },
                  ),
                  FeatureButtonWidget(
                    icon: Icons.description,
                    label: 'Histórico de transações',
                    color: Theme.of(context).colorScheme.primaryVariant,
                    onTap: () {},
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
