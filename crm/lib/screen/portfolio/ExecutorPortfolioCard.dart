import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/PortfolioModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/repository/PortfolioRepository.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/portfolio/PortfolioViewHolder.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/screen/profile/my/MyProfileViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';

class ExecutorPortfolioCard extends StatelessWidget {
  final ExecutorModel executor;
  final UserProfileViewModel viewModel;

  final _portfolioRepositor = PortfolioRepository();

  ExecutorPortfolioCard({required this.executor, required this.viewModel});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Портфолио",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            list(),
            Divider(
              height: 15,
              color: Colors.transparent,
            ),
            UserRepository.instance()
                .myUserLiveData
                .value!
                .id ==
                executor.id
                ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => {
                //ZakazioNavigator.push(context, "portfolio/add")
                viewModel.onAddPortfolio()
              },
            )
                : Container()
          ],
        ))
  );

  list() => FutureBuilder<List<PortfolioModel>>(
      future: _portfolioRepositor.list(executor.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Wrap(
            spacing: 5,
            runSpacing: 5,
            //runSpacing: 15,
            //alignment: WrapAlignment.spaceBetween,
            children: List.generate(snapshot.requireData.length,
                (index) => GestureDetector(
                  child: PortfolioViewHolder(snapshot.requireData[index]),
                  onTap: () {
                    if (viewModel is MyProfileViewModel) {
                      viewModel.onEditPortfolio(snapshot.requireData[index]);
                    } else {
                      viewModel.viewPortfolio(snapshot.requireData[index]);
                    }
                  }
                )
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      });
}
