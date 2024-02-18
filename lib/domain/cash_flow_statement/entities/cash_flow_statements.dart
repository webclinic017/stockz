import 'package:flutter/foundation.dart';
import 'package:stockz/domain/core/value_objects/currency_value_object.dart';
import 'package:stockz/domain/core/value_objects/date_value_object.dart';
import 'package:stockz/domain/core/value_objects/int_value_object.dart';
import 'package:stockz/domain/core/value_objects/number_value_object.dart';
import 'package:stockz/domain/core/value_objects/statement_period_value_object.dart';
import 'package:stockz/domain/core/value_objects/string_id_value_objec.dart';
import 'package:stockz/domain/core/value_objects/url_value_object.dart';

@immutable
class CashFlowStatements {
  final List<CashFlowStatement> statements;

  const CashFlowStatements({required this.statements});
}

@immutable
class CashFlowStatement {
  final DateValueObject date;
  final StringIdValueObject symbol;
  final CurrencyValueObject reportedCurrency;
  final StringIdValueObject cik;
  final DateValueObject fillingDate;
  final DateValueObject acceptedDate;
  final IntValueObject calendarYear;
  final StatementPeriodValueObject period;
  final NumberValueObject netIncome;
  final NumberValueObject depreciationAndAmortization;
  final NumberValueObject deferredIncomeTax;
  final NumberValueObject stockBasedCompensation;
  final NumberValueObject changeInWorkingCapital;
  final NumberValueObject accountsReceivables;
  final NumberValueObject inventory;
  final NumberValueObject accountsPayables;
  final NumberValueObject otherWorkingCapital;
  final NumberValueObject otherNonCashItems;
  final NumberValueObject netCashProvidedByOperatingActivities;
  final NumberValueObject investmentsInPropertyPlantAndEquipment;
  final NumberValueObject acquisitionsNet;
  final NumberValueObject purchasesOfInvestments;
  final NumberValueObject salesMaturitiesOfInvestments;
  final NumberValueObject otherInvestingActivites;
  final NumberValueObject netCashUsedForInvestingActivites;
  final NumberValueObject debtRepayment;
  final NumberValueObject commonStockIssued;
  final NumberValueObject commonStockRepurchased;
  final NumberValueObject dividendsPaid;
  final NumberValueObject otherFinancingActivites;
  final NumberValueObject netCashUsedProvidedByFinancingActivities;
  final NumberValueObject effectOfForexChangesOnCash;
  final NumberValueObject netChangeInCash;
  final NumberValueObject cashAtEndOfPeriod;
  final NumberValueObject cashAtBeginningOfPeriod;
  final NumberValueObject operatingCashFlow;
  final NumberValueObject capitalExpenditure;
  final NumberValueObject freeCashFlow;
  final UrlValueObject link;
  final UrlValueObject finalLink;

  const CashFlowStatement({
    required this.date,
    required this.symbol,
    required this.reportedCurrency,
    required this.cik,
    required this.fillingDate,
    required this.acceptedDate,
    required this.calendarYear,
    required this.period,
    required this.netIncome,
    required this.depreciationAndAmortization,
    required this.deferredIncomeTax,
    required this.stockBasedCompensation,
    required this.changeInWorkingCapital,
    required this.accountsReceivables,
    required this.inventory,
    required this.accountsPayables,
    required this.otherWorkingCapital,
    required this.otherNonCashItems,
    required this.netCashProvidedByOperatingActivities,
    required this.investmentsInPropertyPlantAndEquipment,
    required this.acquisitionsNet,
    required this.purchasesOfInvestments,
    required this.salesMaturitiesOfInvestments,
    required this.otherInvestingActivites,
    required this.netCashUsedForInvestingActivites,
    required this.debtRepayment,
    required this.commonStockIssued,
    required this.commonStockRepurchased,
    required this.dividendsPaid,
    required this.otherFinancingActivites,
    required this.netCashUsedProvidedByFinancingActivities,
    required this.effectOfForexChangesOnCash,
    required this.netChangeInCash,
    required this.cashAtEndOfPeriod,
    required this.cashAtBeginningOfPeriod,
    required this.operatingCashFlow,
    required this.capitalExpenditure,
    required this.freeCashFlow,
    required this.link,
    required this.finalLink,
  });
}