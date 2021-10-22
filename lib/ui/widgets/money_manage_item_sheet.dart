import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoneyManageItemSheet extends StatefulWidget {
  final MoneyManageItemData? data;

  const MoneyManageItemSheet({Key? key, this.data}) : super(key: key);

  @override
  State<MoneyManageItemSheet> createState() => _MoneyManageItemSheetState();
}

class _MoneyManageItemSheetState extends State<MoneyManageItemSheet> {
  late TextEditingController titleController;
  late TextEditingController percentController;
  final _formKey = GlobalKey<FormState>();
  DateTime datePicked = DateTime.now();
  DateTime now = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    titleController = TextEditingController();
    percentController = TextEditingController();
    if (widget.data != null) {
      titleController.text = widget.data!.name;
      percentController.text = widget.data!.percent.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.data != null ? 'Update Card' : 'Add Card',
                          style: AppTheme.headline3,
                        ),
                        SizedBox(height: Helper.bigPadding),
                        Text('Judul', style: AppTheme.text3.bold),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: titleController,
                          style: AppTheme.text3,
                          decoration: InputDecoration(
                            hintText: 'Masukan judul Card',
                            enabledBorder: AppTheme.enabledBlackBorder,
                            hintStyle: AppTheme.text3.blackOpacity,
                          ),
                          validator: Validator.notEmpty,
                        ),
                        SizedBox(height: 16),
                        Text('Persen card', style: AppTheme.text3.bold),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: percentController,
                          style: AppTheme.text3,
                          decoration: InputDecoration(
                            hintText: 'Masukan persen',
                            enabledBorder: AppTheme.enabledBlackBorder,
                            hintStyle: AppTheme.text3.blackOpacity,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            Validator.notEmpty(value);
                            Validator.number(value);
                            final n = num.tryParse(value!);
                            if (n == 0) {
                              return "Persen tidak boleh nol";
                            }
                            if (n == null) {
                              return '"$value" bukan bilangan!';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: Helper.bigPadding),
                        SizedBox(height: Helper.bigPadding),
                        //TODO: Add Validator
                        StatefulBuilder(builder: (context, buttonSetState) {
                          return BlocConsumer<MoneyManageItemSheetBloc,
                              MoneyManageItemState>(
                            listener: (context, state) {
                              if (!(state is MoneyManageItemLoading)) {
                                buttonSetState(() => isLoading = false);
                              }
                              if (state is MoneyManageItemLoading) {
                                buttonSetState(() => isLoading = true);
                              } else if (state
                                  is MoneyManageItemResponseSuccess) {
                                Helper.snackBar(context,
                                    message: 'Berhasil Simpan Card');
                                context
                                    .read<MoneyManageItemBloc>()
                                    .add(GetMoneyManageItem());
                                Navigator.pop(context);
                              } else if (state is MoneyManageItemFailure) {
                                Helper.snackBar(context,
                                    message: state.message, isFailure: true);
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.data != null) {
                                      context
                                          .read<MoneyManageItemSheetBloc>()
                                          .add(
                                            EditMoneyManageItem(
                                              entity: MoneyManageItemPutEntity(
                                                idMoneyManageItem:
                                                    widget.data!.id.toString(),
                                                amount: 0,
                                                percent: percentController.text,
                                                name: titleController.text,
                                              ),
                                            ),
                                          );
                                    } else {
                                      context
                                          .read<MoneyManageItemSheetBloc>()
                                          .add(
                                            PostMoneyManageItem(
                                              entity: MoneyManageItemPostEntity(
                                                amount: 0,
                                                percent: percentController.text,
                                                name: titleController.text,
                                              ),
                                            ),
                                          );
                                    }
                                  }
                                },
                                text: 'Simpan',
                                isUpper: false,
                              );
                            },
                          );
                        }),
                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    ),
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
}
