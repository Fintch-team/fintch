import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class BarrierCashSheet extends StatefulWidget {
  const BarrierCashSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<BarrierCashSheet> createState() => _BarrierCashSheetState();
}

class _BarrierCashSheetState extends State<BarrierCashSheet> {
  late TextEditingController priceController;
  late TextEditingController dateController;
  final _formKey = GlobalKey<FormState>();
  DateTime datePicked = DateTime.now();
  DateTime now = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    priceController = TextEditingController();
    dateController = TextEditingController();
    super.initState();

    context.read<WalletBloc>().add(GetWallet());
  }

  @override
  void dispose() {
    print('dispose');
    priceController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Implement Get Barrier Cash, kalau misal Barrier Cash null, Add Barrier cash, kalau ada, Update barrier cash dan datanya jadi default
    return Material(
      child: GestureDetector(
        onTap: () => Helper.unfocus(),
        child: Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: AppTheme.white,
            ),
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                BlocConsumer<WalletBloc, WalletState>(
                  listener: (context, state) {
                    if (state is WalletFailure) {
                      Helper.snackBar(context,
                          message: state.message, isFailure: true, isUp: true);
                    } else if (state is WalletResponseSuccess) {
                      if (state.entity.barrierExpired != null) {
                        priceController.text =
                            state.entity.barrierAmount.intToThousand();
                        dateController.text =
                            state.entity.barrierExpired!.parseYearMonthDay();
                        datePicked = state.entity.barrierExpired!;
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is WalletResponseSuccess) {
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                state.entity.barrierExpired != null
                                    ? 'Update Barrier Cash'
                                    : 'Add Barrier Cash',
                                style: AppTheme.headline3,
                              ),
                              SizedBox(height: Helper.bigPadding),
                              Text('Harga', style: AppTheme.text3.bold),
                              SizedBox(height: 8),
                              TextFormField(
                                controller: priceController,
                                style: AppTheme.text3,
                                decoration: InputDecoration(
                                  hintText: 'Masukan target harga',
                                  enabledBorder: AppTheme.enabledBlackBorder,
                                  hintStyle: AppTheme.text3.blackOpacity,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ThousandsFormatter(),
                                ],
                                validator: (value) {
                                  Validator.notEmpty(value);
                                  Validator.number(value);
                                  final n = value!.thousandToDouble();
                                  if (n == null) {
                                    return '"" bukan bilangan!';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 16),
                              Text('Tenggat Waktu', style: AppTheme.text3.bold),
                              SizedBox(height: 8),
                              StatefulBuilder(builder: (context, dateSetState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final picked =
                                            await Helper.showDeadlineDatePicker(
                                          context,
                                          datePicked,
                                        );
                                        print(picked.toString());
                                        if (picked != null &&
                                            picked != datePicked &&
                                            picked.isAfter(now)) {
                                          dateSetState(() {
                                            datePicked = picked;
                                            dateController.text =
                                                datePicked.parseYearMonthDay();
                                          });
                                        }
                                      },
                                      child: TextFormField(
                                        controller: dateController,
                                        style: AppTheme.text3,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: 'Masukan tenggat waktu',
                                          enabledBorder:
                                              AppTheme.enabledBlackBorder,
                                          hintStyle:
                                              AppTheme.text3.blackOpacity,
                                          disabledBorder:
                                              AppTheme.enabledBlackBorder,
                                        ),
                                        validator: (value) {
                                          Validator.notEmpty(value);
                                        },
                                      ),
                                    ),
                                    state.entity.barrierExpired != null
                                        ? SizedBox(height: Helper.smallPadding)
                                        : Container(),
                                    state.entity.barrierExpired != null
                                        ? Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                dateSetState(() {
                                                  datePicked = datePicked
                                                      .add(Duration(days: 7));
                                                  dateController.text =
                                                      datePicked
                                                          .parseYearMonthDay();
                                                });
                                              },
                                              child: Text('Perbarui Seminggu',
                                                  style: AppTheme.text3.purple),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                );
                              }),
                              SizedBox(height: Helper.bigPadding),
                              SizedBox(height: Helper.bigPadding),
                              //TODO: Add Validator
                              StatefulBuilder(
                                  builder: (context, barrierCashSetState) {
                                return BlocConsumer<BarrierCashBloc,
                                    WalletState>(
                                  listener: (context, state) {
                                    if (!(state is WalletLoading)) {
                                      barrierCashSetState(
                                          () => isLoading = false);
                                    }
                                    if (state is WalletLoading) {
                                      barrierCashSetState(
                                          () => isLoading = true);
                                    } else if (state is WalletResponseSuccess) {
                                      Helper.snackBar(context,
                                          message:
                                              'Berhasil Simpan Barrier Cash');
                                      Navigator.of(context).pop();
                                    } else if (state
                                        is DeleteBarrierCashSuccess) {
                                      priceController.clear();
                                      dateController.clear();
                                      Helper.snackBar(context,
                                          message:
                                              'Berhasil Hapus Barrier Cash');
                                      Navigator.of(context).pop();
                                    } else if (state is WalletFailure) {
                                      Helper.snackBar(context,
                                          message: state.message,
                                          isFailure: true,
                                          isUp: true);
                                    }
                                  },
                                  builder: (context, barrierCashState) {
                                    return state.entity.barrierExpired != null
                                        ? Row(
                                            children: [
                                              Flexible(
                                                child: CustomButton(
                                                  onTap: () {
                                                    context
                                                        .read<BarrierCashBloc>()
                                                        .add(
                                                            DeleteBarrierCash());
                                                  },
                                                  text: 'Hapus',
                                                  isOutline: true,
                                                  isUpper: false,
                                                  isLoading: isLoading,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              //TODO: Implement Delete F-Goal
                                              Flexible(
                                                child: CustomButton(
                                                  onTap: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      context
                                                          .read<
                                                              BarrierCashBloc>()
                                                          .add(
                                                            AddBarrierCash(
                                                                entity:
                                                                    BarrierCashPostEntity(
                                                              barrierAmount:
                                                                  priceController
                                                                      .text
                                                                      .thousandToDouble()
                                                                      .toString(),
                                                              barrierExpired:
                                                                  dateController
                                                                      .text,
                                                            )),
                                                          );
                                                    }
                                                  },
                                                  text: 'Simpan',
                                                  isUpper: false,
                                                  isLoading: isLoading,
                                                ),
                                              ),
                                            ],
                                          )
                                        : CustomButton(
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<BarrierCashBloc>()
                                                    .add(AddBarrierCash(
                                                        entity:
                                                            BarrierCashPostEntity(
                                                      barrierAmount:
                                                          priceController.text
                                                              .thousandToDouble()
                                                              .toString(),
                                                      barrierExpired:
                                                          dateController.text,
                                                    )));
                                              }
                                            },
                                            text: 'Simpan',
                                            isUpper: false,
                                            isLoading: isLoading,
                                          );
                                  },
                                );
                              }),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).padding.bottom),
                            ],
                          ),
                        ),
                      );
                    } else if (state is WalletLoading) {
                      return BarrierCashShimmer();
                    } else if (state is WalletFailure) {
                      return FailureStateWidget(
                          message: 'Barrier Cash di Load!');
                    }
                    return Container();
                  },
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(Resources.icClose),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
