import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  double value = 10000;
  double sliderValue = 10000;
  final _formKey = GlobalKey<FormState>();
  final textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textFieldController.text = value.doubleToThousand();
  }

  @override
  Widget build(BuildContext context) {
    Helper.setDarkAppBar();
    return Scaffold(
      body: Background(
        isWhite: true,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar(
                      title: 'Top Up',
                      isBlack: true,
                    ),
                    SizedBox(height: Helper.smallPadding),
                    _headerTopUp(context),
                  ],
                ),
              ),
              Expanded(child: _bodyTopUp(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerTopUp(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Disini kamu bisa langsung pilih berapa nominal yang kalian butuhkan untuk Top Up Fintch Point',
            style: AppTheme.text1,
          ),
        ),
        SizedBox(width: Helper.normalPadding),
        SvgPicture.asset(
          Resources.topUpIllustration,
          width: MediaQuery.of(context).size.width * 0.3,
        ),
      ],
    );
  }

  Widget _bodyTopUp(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppTheme.white,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Helper.normalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _bottomSheetLine(context),
                SizedBox(height: Helper.bigPadding),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Mau Top Up Berapa?', style: AppTheme.headline3),
                      SizedBox(height: 8),
                      Text('Rp1 = 1 Fintch Point', style: AppTheme.text3),
                    ],
                  ),
                ),
                SizedBox(height: Helper.normalPadding),
                _slider(),
                SizedBox(height: Helper.normalPadding),
                SizedBox(height: Helper.normalPadding),
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text('Jumlah Lainnya', style: AppTheme.text3.purple.bold),
                ),
                SizedBox(height: 8),
                _otherAmount(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _totalAmount(),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheetLine(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppTheme.purpleOpacity,
      ),
      margin: EdgeInsets.only(top: Helper.smallPadding),
      width: MediaQuery.of(context).size.width * 0.15,
      height: 4,
    );
  }

  Widget _slider() {
    return FlutterSlider(
      values: [sliderValue],
      max: 99000,
      min: 10000,
      maximumDistance: 99000,
      minimumDistance: 10000,
      handlerAnimation: FlutterSliderHandlerAnimation(
          curve: Curves.elasticOut,
          reverseCurve: null,
          duration: Duration(milliseconds: 700),
          scale: 1.2),
      step: FlutterSliderStep(step: 10000),
      decoration: BoxDecoration(
        color: AppTheme.purple,
        borderRadius: BorderRadius.circular(64),
        boxShadow: Helper.getShadow(),
      ),
      selectByTap: false,
      handler: FlutterSliderHandler(
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Resources.icFintchPoint, height: 24),
              SizedBox(width: Helper.smallPadding),
              Text(
                (sliderValue / 1000).toStringAsFixed(1) + 'K',
                style: AppTheme.text1,
              ),
            ],
          ),
        ),
      ),
      handlerWidth: 100,
      handlerHeight: 40,
      trackBar: FlutterSliderTrackBar(
        activeDisabledTrackBarColor: AppTheme.white,
        inactiveDisabledTrackBarColor: AppTheme.white,
        activeTrackBar: BoxDecoration(
          color: AppTheme.yellow,
          borderRadius: BorderRadius.circular(4),
        ),
        inactiveTrackBar: BoxDecoration(
          color: AppTheme.darkYellow,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      tooltip: FlutterSliderTooltip(
        textStyle: AppTheme.headline3,
        boxStyle: FlutterSliderTooltipBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: Helper.getShadow(),
            color: AppTheme.white,
          ),
        ),
        positionOffset: FlutterSliderTooltipPositionOffset(top: -8),
        direction: FlutterSliderTooltipDirection.top,
      ),
      onDragging: (handlerIndex, lowerValue, upperValue) {
        setState(() {
          sliderValue = lowerValue;
          value = sliderValue;
          textFieldController.text = value.doubleToThousand();
        });
      },
    );
  }

  Widget _otherAmount() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: textFieldController,
        style: AppTheme.text3.purple,
        validator: (value) {
          Validator.number(value);
          final n = value!.thousandToDouble();
          if (n == null) {
            return '"$value" bukan bilangan!';
          } else if (n < 500) {
            return 'Input harus lebih dari 500';
          }
          return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          ThousandsFormatter(),
        ],
        decoration: InputDecoration(
          hintStyle: AppTheme.text3.purpleOpacity,
          hintText: 'Masukin jumlah Top Up lainnya',
          focusedBorder: AppTheme.focusedBorder.copyWith(
            borderSide: BorderSide(color: AppTheme.purple),
          ),
          enabledBorder: AppTheme.enabledBorder.copyWith(
            borderSide: BorderSide(color: AppTheme.purpleOpacity),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (String text) {
          if (_formKey.currentState!.validate()) {
            setState(() {
              value = text.thousandToDouble() ?? 0;
            });
          }
        },
      ),
    );
  }

  Widget _totalAmount() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppTheme.black,
              width: 2,
            ),
          ),
          color: AppTheme.white,
        ),
        padding: EdgeInsets.all(Helper.normalPadding),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Total Pembayaran', style: AppTheme.text2),
                  SizedBox(height: 8),
                  Text('Rp${value.toString().parseCurrency()}',
                      style: AppTheme.headline3),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<PayBloc>().add(PostTopUpPay(
                              entity: TransactionTopUpPostEntity(
                            amount: value.toString(),
                            name: "test",
                          )));

                      Navigator.pushNamed(context, PagePath.payment);
                    }
                  },
                  text: 'Bayar',
                  isUpper: false),
            ),
          ],
        ),
      ),
    );
  }
}
