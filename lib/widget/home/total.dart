import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/trade/trade_bloc.dart';

class Total extends StatelessWidget {
  const Total({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeBloc, TradeState>(
      buildWhen: (prev, current) => current.status.isSuccess,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Investing',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Text(
                '\$ ${state.totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text('${state.totalCount} stocks'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      shape: const CircleBorder(),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    child: const Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
