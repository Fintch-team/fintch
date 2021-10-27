import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  bool isLoading = false;
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _onRefresh() async {
    _init();
  }

  void _init() {
    context.read<BarcodeBloc>().add(GetBarcode());
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
              builder: (context) => BarcodeSheet(),
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
          child: LiquidPullToRefresh(
            color: AppTheme.scaffold,
            backgroundColor: AppTheme.purple,
            showChildOpacityTransition: false,
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                    Text('F-Barcode', style: AppTheme.headline1),
                    SizedBox(height: Helper.bigPadding),
                    Text(
                      'Di F-Barcode untuk kamu yang ingin bertransaksi dengan cepat dan aman dengan F-Barcode!',
                      style: AppTheme.text1,
                    ),
                    SizedBox(height: Helper.bigPadding),
                    BlocConsumer<BarcodeBloc, BarcodeState>(
                      listener: (context, state) {
                        if (state is BarcodeFailure) {
                          Helper.snackBar(context,
                              message: state.message, isFailure: true);
                        }
                      },
                      builder: (context, state) {
                        if (state is BarcodeResponseSuccess) {
                          if (state.entity.data.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.entity.data.length,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 0),
                              itemBuilder: (context, index) {
                                return _fBarcode(
                                    context, index, state.entity.data[index]);
                              },
                            );
                          }
                          return EmptyStateWidget(
                              message: 'F-Barcodes Kosong!');
                        } else if (state is BarcodeLoading) {
                          return FGoalPageItemShimmer();
                        } else if (state is BarcodeFailure) {
                          return FailureStateWidget(
                              message: 'F-Barcodes Gagal di Load!');
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
      ),
    );
  }

  Widget _fBarcode(BuildContext context, int index, BarcodeData data) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PagePath.barcodeReceive,
            arguments: ArgumentBundle(extras: {
              'barcode': data,
            }));
      },
      child: Dismissible(
        background: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8),
            child: Text(
              "Hapus",
              style: AppTheme.headline2.copyWith(color: AppTheme.white),
            ),
            color: AppTheme.red),
        secondaryBackground: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Text(
              "Edit",
              style: AppTheme.headline2.copyWith(color: AppTheme.white),
            ),
            color: AppTheme.yellow),
        key: Key(data.id.toString()),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            return await showDialog(
              context: context,
              builder: (context) => _confirmDeleteFGoals(context, data),
            );
          } else if (direction == DismissDirection.endToStart) {
            showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              enableDrag: true,
              isDismissible: true,
              topRadius: Radius.circular(20),
              backgroundColor: AppTheme.white,
              barrierColor: AppTheme.black.withOpacity(0.2),
              builder: (context) => BarcodeSheet(data: data),
            );

            return false;
          }
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
            aspectRatio: 16 / 4,
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
                                data.createdAt.parseHourDateAndMonth(),
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
                        'Rp${data.amount.toString().parseCurrency()}',
                        style: AppTheme.text1.bold,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmDeleteFGoals(BuildContext context, BarcodeData data) {
    return CustomDialog(
      title: 'Yakin nih ingin hapus Barcode?',
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
          Flexible(
            child: StatefulBuilder(builder: (context, buttonSetState) {
              return BlocConsumer<BarcodeSheetBloc, BarcodeState>(
                listener: (context, state) {
                  if (!(state is BarcodeLoading)) {
                    buttonSetState(() => isLoading = false);
                  }
                  if (state is BarcodeLoading) {
                    buttonSetState(() => isLoading = true);
                  } else if (state is DeleteBarcodeRequestSuccess) {
                    Helper.snackBar(context, message: 'Berhasil Hapus Barcode');
                    context.read<BarcodeBloc>().add(GetBarcode());
                    Navigator.of(context).pop(true);
                  } else if (state is BarcodeFailure) {
                    Helper.snackBar(context,
                        message: state.message, isFailure: true);
                    Navigator.pop(context, false);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    onTap: () {
                      context.read<BarcodeSheetBloc>().add(
                            DeleteBarcode(
                              id: data.id,
                            ),
                          );
                    },
                    isLoading: isLoading,
                    text: 'Iya',
                    isOutline: true,
                    isUpper: false,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class BarcodeSheet extends StatefulWidget {
  final BarcodeData? data;

  const BarcodeSheet({Key? key, this.data}) : super(key: key);

  @override
  State<BarcodeSheet> createState() => _FGoalSheetState();
}

class _FGoalSheetState extends State<BarcodeSheet> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  final _formKey = GlobalKey<FormState>();
  DateTime datePicked = DateTime.now();
  DateTime now = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    if (widget.data != null) {
      titleController.text = widget.data!.name;
      priceController.text = widget.data!.amount.toString();
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
                          widget.data != null
                              ? 'Update F-Barcode'
                              : 'Add F-Barcode',
                          style: AppTheme.headline3,
                        ),
                        SizedBox(height: Helper.bigPadding),
                        Text('Judul', style: AppTheme.text3.bold),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: titleController,
                          style: AppTheme.text3,
                          decoration: InputDecoration(
                            hintText: 'Masukan judul F-Barcode',
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
                        SizedBox(height: Helper.bigPadding),
                        SizedBox(height: Helper.bigPadding),
                        //TODO: Add Validator
                        StatefulBuilder(builder: (context, buttonSetState) {
                          return BlocConsumer<BarcodeSheetBloc, BarcodeState>(
                            listener: (context, state) {
                              if (!(state is BarcodeLoading)) {
                                buttonSetState(() => isLoading = false);
                              }
                              if (state is BarcodeLoading) {
                                buttonSetState(() => isLoading = true);
                              } else if (state is BarcodeRequestSuccess) {
                                Helper.snackBar(context,
                                    message: 'Berhasil Simpan Barcode');
                                context.read<BarcodeBloc>().add(GetBarcode());
                                Navigator.pop(context);
                              } else if (state is BarcodeFailure) {
                                Helper.snackBar(context,
                                    message: state.message,
                                    isFailure: true,
                                    isUp: true);
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                isLoading: isLoading,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.data != null) {
                                      context.read<BarcodeSheetBloc>().add(
                                            EditBarcode(
                                              entity: BarcodePutEntity(
                                                  idBarcode: widget.data!.id
                                                      .toString(),
                                                  amount: priceController.text
                                                      .thousandToDouble()
                                                      .toString(),
                                                  name: titleController.text,
                                                  confirm: '123456'),
                                            ),
                                          );
                                    } else {
                                      context.read<BarcodeSheetBloc>().add(
                                            PostBarcode(
                                              entity: BarcodePostEntity(
                                                confirm: '123456',
                                                amount: priceController.text
                                                    .thousandToDouble()
                                                    .toString(),
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
