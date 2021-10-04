import 'package:bytebank_app/blocs/container/container.dart';
import 'package:bytebank_app/blocs/cubits/name_cubit.dart';
import 'package:bytebank_app/ui/pages/change_name_page.dart';
import 'package:bytebank_app/ui/pages/transactions_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_list_page.dart';
import '../widgets/feature_button_widget.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameCubit('Thigas'),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = context.watch<NameCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/bytebank_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Bem-vindo, $name',
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700),
            ),
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
                  onTap: () => push(context, ContactListContainer()),
                ),
                FeatureButtonWidget(
                  icon: Icons.description,
                  label: 'Histórico de transações',
                  color: Theme.of(context).colorScheme.primaryVariant,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TransactionsList(),
                      ),
                    );
                  },
                ),
                FeatureButtonWidget(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (newContext) => BlocProvider.value(
                            value: BlocProvider.of<NameCubit>(context),
                            child: const NameContainer()),
                      ),
                    );
                  },
                  icon: Icons.change_circle_outlined,
                  label: 'Mudar nome',
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
