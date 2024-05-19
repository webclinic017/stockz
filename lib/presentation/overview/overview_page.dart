import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:stockz/application/overview/overview_cubit.dart';
import 'package:stockz/domain/analysis_rules/f_score.dart';
import 'package:stockz/domain/analysis_rules/magic_formula.dart';
import 'package:stockz/domain/chart/entities/chart.dart';
import 'package:stockz/domain/chart/entities/impulse_macd.dart';
import 'package:stockz/domain/company/entities/company.dart';
import 'package:stockz/domain/core/value_objects/failures/failure.dart';
import 'package:stockz/domain/core/value_objects/payload.dart';
import 'package:stockz/domain/stock_listing/entities/stock_listings.dart';
import 'package:stockz/infrastructure/company/repository/i_company_repository.dart';
import 'package:stockz/infrastructure/stock_listings/repository/i_stock_listings_repository.dart';
import 'package:stockz/presentation/core/widgets/imports.dart';
import 'package:stockz/setup.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverviewPage extends StatefulWidget {
  static Widget creator(_) => const OverviewPage();

  const OverviewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OverviewPageState();
  }
}

class _OverviewPageState extends State<OverviewPage> {
  Company? company;

  @override
  void initState() {
    super.initState();
    final List<String> tickers = [
      'MO',
      'AMCX',
      'ARCT',
      'ASRT',
      'BTMD',
      'BKE',
      'BBW',
      'CARG',
      'CPRX',
      'LNG',
      'COLL',
      'CCSI',
      'CROX',
      'CVS',
      'EVRI',
      'GTX',
      'GPOR',
      'HRB',
      'HRMY',
      'HSII',
      'HPQ',
      'IMMR',
      'IDCC',
      'JILL',
      'JAKK',
      'MAN',
      'MCFT',
      'MED',
      /*'MLI',
      'NATH',
      'OCUP',
      'OMC',
      'MD',
      'PRDO',
      'PLTK',
      'PINC',
      'RCMT',
      'RMNI',
      'SCYX',
      'SMLR',
      'SPRO',
      'STGW',
      'SURG',
      'TPR',
      'TH',
      'TZOO',
      'UIS',
      'UNTC',
      'VYGR',
      'ZYME',*/
    ];

    /*getIt<IStockListingsRepository>().getStockListings().then(
      (Payload<StockListings> value) {
        print(value);
      },
    );*/

    //for (final String ticker in tickers) {
    getIt<ICompanyRepository>().getCompany(symbol: "AMCX").then(
      (Payload<Company> payload) {
        payload.fold(
          (Failure failure) {
            Logger().e(failure);
          },
          (Company value) {
            setState(() {
              company = value;
            });
            final double fScore = FScore(company: value).getFScore();
            final double magicFormula = MagicFormula(company: value).getMagicFormulaScore();
            print("${value.profile.companyName.get} (${value.profile.symbol.get}): F score: $fScore, Magic formula score: $magicFormula");
          },
        );
      },
    );
    //}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OverviewCubit>(
      create: (BuildContext context) => getIt<OverviewCubit>()..getData(forceGet: false),
      child: BlocBuilder<OverviewCubit, OverviewState>(
        builder: (BuildContext context, OverviewState state) {
          return StScaffold(
            child: company == null ? const SizedBox.shrink() : MacdChart(company: company!),
          );
        },
      ),
    );
  }
}

class MacdChart extends StatelessWidget {
  final Company company;

  const MacdChart({required this.company});

  @override
  Widget build(BuildContext context) {
    final List<double> sma = company.chart.calculateSma(12);
    final List<double> ema = company.chart.calculateEma(12);
    final List<double> prices = company.chart.getPrices();

    return Scaffold(
      appBar: AppBar(
        title: const Text("MACD Chart"),
      ),
      body: SfCartesianChart(
        title: const ChartTitle(text: "MACD Chart"),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        //primaryXAxis: const DateTimeAxis(),
        series: [
          LineSeries<double, int>(
            name: "SMA 12 Line",
            dataSource: sma,
            xValueMapper: (double data, int index) => index,
            yValueMapper: (double data, _) => data,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          LineSeries<double, int>(
            name: "EMA 12 Line",
            dataSource: ema,
            xValueMapper: (double data, int index) => index,
            yValueMapper: (double data, _) => data,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          LineSeries<double, int>(
            name: "Price line",
            dataSource: prices,
            xValueMapper: (double data, int index) => index,
            yValueMapper: (double data, int index) => data,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
