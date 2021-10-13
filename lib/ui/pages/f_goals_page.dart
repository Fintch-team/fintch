import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FGoalsPage extends StatefulWidget {
  const FGoalsPage({Key? key}) : super(key: key);

  @override
  State<FGoalsPage> createState() => _FGoalsPageState();
}

class _FGoalsPageState extends State<FGoalsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MoneyPlanBloc>().add(GetMoneyPlan());
  }

  @override
  Widget build(BuildContext context) {
    Helper.setDarkAppBar();
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: Helper.normalPadding),
        child: FloatingActionButton(
          backgroundColor: AppTheme.purple,
          onPressed: () {
            showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              enableDrag: true,
              isDismissible: true,
              topRadius: Radius.circular(20),
              backgroundColor: AppTheme.white,
              barrierColor: AppTheme.black.withOpacity(0.2),
              builder: (context) => FGoalSheet(),
            );
          },
          child: Icon(
            Icons.add_rounded,
            size: MediaQuery.of(context).size.width * 0.1,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Background(
        isWhite: true,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(Helper.normalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: '',
                    isBlack: true,
                  ),
                  SizedBox(height: Helper.bigPadding),
                  Text('F-Goals', style: AppTheme.headline1),
                  SizedBox(height: Helper.bigPadding),
                  Text(
                    'Di F-Goals ini kamu bisa merencanakan barang atau sesuatu apa yang kamu mau beli dan inginkan atau capai, jika waktu tenggat sudah dekat, sistem pasti memberitahu kamu kok!',
                    style: AppTheme.text1,
                  ),
                  SizedBox(height: Helper.bigPadding),
                  BlocConsumer<MoneyPlanBloc, MoneyPlanState>(
                    listener: (context, state) {
                      if (state is MoneyPlanFailure) {
                        Helper.snackBar(context,
                            message: state.message, isFailure: true);
                      }
                    },
                    builder: (context, state) {
                      if (state is MoneyPlanResponseSuccess) {
                        if (state.entity.data.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: 0),
                            itemBuilder: (context, index) {
                              return _fGoalItem(
                                  context, index, state.entity.data[0]);
                            },
                          );
                        }
                        return Center(
                          child: Text(
                            'F-Goals Kosong!',
                            style: AppTheme.text1.bold,
                          ),
                        );
                      } else if (state is MoneyPlanLoading) {
                        return Center(
                          child: CircularLoading(),
                        );
                      } else if (state is MoneyPlanFailure) {
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fGoalItem(BuildContext context, int index, MoneyPlanData data) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
          expand: false,
          context: context,
          enableDrag: true,
          isDismissible: true,
          topRadius: Radius.circular(20),
          backgroundColor: AppTheme.white,
          barrierColor: AppTheme.black.withOpacity(0.2),
          builder: (context) => FGoalSheet(data: data),
        );
      },
      child: Dismissible(
        key: Key(data.id.toString()),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) => _confirmDeleteFGoals(context, data),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: Helper.getShadow(),
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width,
          child: AspectRatio(
            aspectRatio: 17 / 6,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AutoSizeText(
                            data.name,
                            style: AppTheme.headline2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 16,
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(Resources.icTime, height: 12),
                              SizedBox(width: 4),
                              AutoSizeText(
                                data.deadline!.parseHourDateAndMonth(),
                                style: AppTheme.subText1,
                                maxLines: 1,
                                maxFontSize: 10,
                                minFontSize: 8,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                      AutoSizeText(
                        'Rp. ${data.totalAmount.toString().parseCurrency()}',
                        style: AppTheme.text1.bold,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Helper.smallPadding),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: MediaQuery.of(context).size.width * 0.2,
                      lineWidth: 16.0,
                      animation: true,
                      percent: data.percent / 100,
                      center: Text("${data.percent}%",
                          style: AppTheme.text2.darkPurple.bold),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: AppTheme.purple,
                      backgroundColor: AppTheme.purpleOpacity,
                    ),
                    SizedBox(height: Helper.smallPadding),
                    AutoSizeText(
                      'Rp. ${data.amount.toString().parseCurrency()}',
                      style: AppTheme.text3.green,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmDeleteFGoals(BuildContext context, MoneyPlanData data) {
    return CustomDialog(
      title: 'Yakin nih ingin hapus F-Goal?',
      content:
          Text('Kamu yakin mau hapus ${data.name} nih?', style: AppTheme.text3),
      buttons: Row(
        children: [
          Flexible(
            child: CustomButton(
              onTap: () => Navigator.pop(context, false),
              text: 'Tidak',
              isUpper: false,
            ),
          ),
          SizedBox(width: Helper.normalPadding),
          //TODO: Implement Delete F-Goal
          Flexible(
            child: CustomButton(
              onTap: () => Navigator.pop(context, true),
              text: 'Iya',
              isOutline: true,
              isUpper: false,
            ),
          ),
        ],
      ),
    );
  }
}

class FGoalSheet extends StatefulWidget {
  final MoneyPlanData? data;

  const FGoalSheet({Key? key, this.data}) : super(key: key);

  @override
  State<FGoalSheet> createState() => _FGoalSheetState();
}

class _FGoalSheetState extends State<FGoalSheet> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController dateController;
  final _formKey = GlobalKey<FormState>();
  DateTime datePicked = DateTime.now();
  DateTime now = DateTime.now();

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    dateController = TextEditingController();
    if (widget.data != null) {
      titleController.text = widget.data!.name;
      priceController.text = widget.data!.amount.toString();
      dateController.text = widget.data!.deadline!.parseYearMonthDay();
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.data != null ? 'Update F-Goal' : 'Add F-Goal',
                        style: AppTheme.headline3,
                      ),
                      SizedBox(height: Helper.bigPadding),
                      Text('Judul', style: AppTheme.text3.bold),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: titleController,
                        style: AppTheme.text3,
                        decoration: InputDecoration(
                          hintText: 'Masukan judul F-Goal',
                          enabledBorder: AppTheme.enabledBlackBorder,
                          hintStyle: AppTheme.text3.blackOpacity,
                        ),
                        validator: Validator.notEmpty,
                      ),
                      SizedBox(height: 16),
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
                            return '"$value" bukan bilangan!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      Text('Tenggat Waktu', style: AppTheme.text3.bold),
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
                            hintText: 'Masukan tenggat waktu',
                            enabledBorder: AppTheme.enabledBlackBorder,
                            hintStyle: AppTheme.text3.blackOpacity,
                            disabledBorder: AppTheme.enabledBlackBorder,
                          ),
                        ),
                      ),
                      SizedBox(height: Helper.bigPadding),
                      SizedBox(height: Helper.bigPadding),
                      //TODO: Add Validator
                      //TODO: Implement Add F Goals and Update F-Goals using logic 'widget.data != null', if data null, Add F-Goals, otherwise, Update F-Goals
                      CustomButton(
                        onTap: () {},
                        text: 'Simpan',
                        isUpper: false,
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
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
}
