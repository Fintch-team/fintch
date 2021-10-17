import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  void initState() {
    priceController = TextEditingController();
    dateController = TextEditingController();
    super.initState();

    context.read<WalletBloc>().add(GetWallet());
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Implement Get Barrier Cash, kalau misal Barrier Cash null, Add Barrier cash, kalau ada, Update barrier cash dan datanya jadi default
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletResponseSuccess) {
          if (state.entity.barrierExpired != null) {
            priceController.text = state.entity.barrierAmount.toString();
            dateController.text =
                state.entity.barrierExpired!.parseYearMonthDay();
            datePicked = state.entity.barrierExpired!;
          }
          return Material(
            child: GestureDetector(
              onTap: () => Helper.unfocus(),
              child: Container(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: AppTheme.white,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
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
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                Validator.notEmpty(value);
                                Validator.number(value);
                                final n = num.tryParse(value!);
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
                              return GestureDetector(
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
                                    enabledBorder: AppTheme.enabledBlackBorder,
                                    hintStyle: AppTheme.text3.blackOpacity,
                                    disabledBorder: AppTheme.enabledBlackBorder,
                                  ),
                                ),
                              );
                            }),
                            SizedBox(height: Helper.bigPadding),
                            SizedBox(height: Helper.bigPadding),
                            //TODO: Add Validator
                            //TODO: Implement Add Barrier Cash and Update F-Goals using logic if data was null for get Barrier Cash, Add F-Goals, otherwise, Update F-Goals
                            state.entity.barrierExpired != null
                                ? Row(
                                    children: [
                                      Flexible(
                                        child: CustomButton(
                                          onTap: () {
                                            context
                                                .read<WalletBloc>()
                                                .add(DeleteBarrierCash());

                                            Navigator.pop(context);
                                          },
                                          text: 'Hapus',
                                          isOutline: true,
                                          isUpper: false,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      //TODO: Implement Delete F-Goal
                                      Flexible(
                                        flex: 2,
                                        child: CustomButton(
                                          onTap: () {
                                            context
                                                .read<WalletBloc>()
                                                .add(ExtendBarrierCash());

                                            Navigator.pop(context, true);
                                          },
                                          text: 'Perbarui seminggu',
                                          isUpper: false,
                                        ),
                                      ),
                                    ],
                                  )
                                : CustomButton(
                                    onTap: () {
                                      context
                                          .read<WalletBloc>()
                                          .add(AddBarrierCash(
                                              entity: BarrierCashPostEntity(
                                            barrierAmount: priceController.text,
                                            barrierExpired: dateController.text,
                                          )));

                                      Navigator.pop(context, true);
                                    },
                                    text: 'Simpan',
                                    isUpper: false,
                                  ),
                            SizedBox(
                                height: MediaQuery.of(context).padding.bottom),
                          ],
                        ),
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

        // TODO: implementasi state yg lain
        return Container();
      },
    );
  }
}
