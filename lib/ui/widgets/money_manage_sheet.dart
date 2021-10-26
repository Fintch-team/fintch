import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class MoneyManageSheet extends StatefulWidget {
  final MoneyManageData? data;

  const MoneyManageSheet({Key? key, this.data}) : super(key: key);

  @override
  State<MoneyManageSheet> createState() => _MoneyManageSheetState();
}

class _MoneyManageSheetState extends State<MoneyManageSheet> {
  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController dateController;
  final _formKey = GlobalKey<FormState>();
  bool isIncome = true;
  DateTime datePicked = DateTime.now();
  DateTime now = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    titleController = TextEditingController();
    amountController = TextEditingController();
    dateController = TextEditingController();
    dateController.text = datePicked.parseYearMonthDay();

    context.read<MoneyManageItemBloc>().add(GetMoneyManageItem());

    if (widget.data != null) {
      titleController.text = widget.data!.name;
      amountController.text = widget.data!.amount.intToThousand();
      setState(() {
        isIncome = false;
      });
    }
    super.initState();
  }

  void inComeCallback() {
    setState(() {
      isIncome = true;
    });
  }

  void outComeCallback() {
    setState(() {
      isIncome = false;
    });
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
                          widget.data != null
                              ? 'Update Activities'
                              : 'Add Activities',
                          style: AppTheme.headline3,
                        ),
                        SizedBox(height: Helper.bigPadding),
                        if (widget.data == null)
                          MoneyManageTab(
                            isIncome: isIncome,
                            payCallback: inComeCallback,
                            receiveCallback: outComeCallback,
                          ),
                        SizedBox(height: Helper.bigPadding),
                        Text('Judul', style: AppTheme.text3.bold),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: titleController,
                          style: AppTheme.text3,
                          decoration: InputDecoration(
                            hintText: 'Masukan judul Activities',
                            enabledBorder: AppTheme.enabledBlackBorder,
                            hintStyle: AppTheme.text3.blackOpacity,
                          ),
                          validator: Validator.notEmpty,
                        ),
                        SizedBox(height: 16),
                        Text('Nilai activities', style: AppTheme.text3.bold),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: amountController,
                          style: AppTheme.text3,
                          decoration: InputDecoration(
                            hintText: 'Masukan Nilai',
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
                            if (n == 0) {
                              return "Harga tidak boleh nol";
                            }
                            if (n == null) {
                              return '"$value" bukan bilangan!';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 16),
                        Text('Tanggal Waktu', style: AppTheme.text3.bold),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final picked = await Helper.showDeadlineDatePicker(
                              context,
                              datePicked,
                            );
                            if (picked != null &&
                                picked != datePicked &&
                                picked.isAfter(now)) {
                              setState(() {
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
                              hintText: 'Masukan tanggal waktu',
                              enabledBorder: AppTheme.enabledBlackBorder,
                              hintStyle: AppTheme.text3.blackOpacity,
                              disabledBorder: AppTheme.enabledBlackBorder,
                            ),
                          ),
                        ),

                        if (!isIncome) ...[
                          SizedBox(height: 16),
                          Text('Pilih Card', style: AppTheme.text3.bold),
                          SizedBox(height: 8),
                          buildCard(),
                        ],
                        SizedBox(height: Helper.bigPadding),
                        SizedBox(height: Helper.bigPadding),
                        //TODO: Add Validator
                        StatefulBuilder(builder: (context, buttonSetState) {
                          return BlocConsumer<MoneyManageSheetBloc,
                              MoneyManageState>(
                            listener: (context, state) {
                              if (!(state is MoneyManageLoading)) {
                                buttonSetState(() => isLoading = false);
                              }
                              if (state is MoneyManageLoading) {
                                buttonSetState(() => isLoading = true);
                              } else if (state is MoneyManageResponseSuccess) {
                                Helper.snackBar(context,
                                    message: 'Berhasil Simpan Activity');
                                context
                                    .read<MoneyManageBloc>()
                                    .add(GetMoneyManage());
                                Navigator.pop(context);
                              } else if (state is MoneyManageFailure) {
                                Helper.snackBar(context,
                                    message: state.message, isFailure: true);
                              }
                            },
                            builder: (context, state) {
                              return Row(
                                children: [
                                  if (widget.data != null) ...[
                                    Flexible(
                                      child: CustomButton(
                                        isLoading: isLoading,
                                        onTap: () {
                                          context
                                              .read<MoneyManageSheetBloc>()
                                              .add(
                                                DeleteMoneyManage(
                                                  id: widget.data!.id,
                                                ),
                                              );
                                        },
                                        text: 'Hapus',
                                        isOutline: true,
                                        isUpper: false,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                  Flexible(
                                    child: CustomButton(
                                      isLoading: isLoading,
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (widget.data != null) {
                                            if (_selectedCardId != null) {
                                              context
                                                  .read<MoneyManageSheetBloc>()
                                                  .add(
                                                    EditMoneyManage(
                                                      entity:
                                                          MoneyManagePutEntity(
                                                        idMoneyManage: widget
                                                            .data!.id
                                                            .toString(),
                                                        amount: amountController
                                                            .text
                                                            .thousandToDouble()
                                                            .toString(),
                                                        name: titleController
                                                            .text,
                                                        idMoneyManageItem:
                                                            _selectedCardId!,
                                                        date:
                                                            dateController.text,
                                                      ),
                                                    ),
                                                  );
                                            }
                                          } else {
                                            if (isIncome) {
                                              context
                                                  .read<MoneyManageSheetBloc>()
                                                  .add(
                                                    PostIncomeMoneyManage(
                                                      entity:
                                                          MoneyManageInPostEntity(
                                                        amount: amountController
                                                            .text
                                                            .thousandToDouble()
                                                            .toString(),
                                                        name: titleController
                                                            .text,
                                                        date:
                                                            dateController.text,
                                                      ),
                                                    ),
                                                  );
                                            } else {
                                              if (_selectedCardId != null) {
                                                context
                                                    .read<
                                                        MoneyManageSheetBloc>()
                                                    .add(
                                                      PostOutcomeMoneyManage(
                                                        entity:
                                                            MoneyManageOutPostEntity(
                                                          amount: amountController
                                                              .text
                                                              .thousandToDouble()
                                                              .toString(),
                                                          name: titleController
                                                              .text,
                                                          idMoneyManageItem:
                                                              _selectedCardId!,
                                                          date: dateController
                                                              .text,
                                                        ),
                                                      ),
                                                    );
                                              }
                                            }
                                          }
                                        }
                                      },
                                      text: widget.data != null
                                          ? 'Edit'
                                          : 'Simpan',
                                      isUpper: false,
                                    ),
                                  ),
                                ],
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

  MoneyManageItemData? _selectedCard;
  String? _selectedCardId;

  Widget buildCard() {
    return BlocBuilder<MoneyManageItemBloc, MoneyManageItemState>(
      builder: (context, state) {
        if (state is MoneyManageItemResponseSuccess) {
          if (widget.data != null) {
            List<MoneyManageItemData> list = state.entity.data
                .where((element) => widget.data!.id == element.id)
                .toList();

            _selectedCard = list.isNotEmpty ? list.first : null;
            _selectedCardId = list.isNotEmpty ? list.first.id.toString() : null;
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.black),
              color: AppTheme.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<MoneyManageItemData>(
                hint: Text("Pilih Card", style: AppTheme.text3.blackOpacity),
                style: AppTheme.text3,
                borderRadius: BorderRadius.circular(12),
                isExpanded: true,
                itemHeight: 50.0,
                value: _selectedCard,
                onChanged: (MoneyManageItemData? value) {
                  setState(() {
                    _selectedCard = value;
                    _selectedCardId = value!.id.toString();
                  });
                },
                items: state.entity.data.map((MoneyManageItemData category) {
                  return DropdownMenuItem<MoneyManageItemData>(
                    value: category,
                    child: Row(
                      children: <Widget>[
                        Text(
                          category.name,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else if (state is MoneyManageItemLoading) {
          return Center(
            child: CircularLoading(),
          );
        } else if (state is MoneyManageItemFailure) {
          return Center(
            child: Text(
              'Data gagal di load',
              style: AppTheme.headline3.white,
              textAlign: TextAlign.center,
            ),
          );
        }
        return Container();
      },
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?>? onChanged;
  final T value;
  final bool isEnabled;
  CustomDropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    this.isEnabled = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            color: isEnabled ? Colors.white : Colors.grey.withAlpha(100)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            itemHeight: 50.0,
            style: TextStyle(
                fontSize: 15.0,
                color: isEnabled ? Colors.black : Colors.grey[700]),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            value: value,
          ),
        ),
      ),
    );
  }
}
