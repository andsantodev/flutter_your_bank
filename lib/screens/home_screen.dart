import 'package:app_your_banking/constants/color_constant.dart';
import 'package:app_your_banking/models/card_model.dart';
import 'package:app_your_banking/models/operation_model.dart';
import 'package:app_your_banking/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Current select
  int current = 0;

  // Handle Indicator
  List<T> map<T>(List list, Function handler){
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Container(
          // margin: EdgeInsets.only(top: 8),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[

              // Custom AppBar
              Container(
                margin: EdgeInsets.only(left:16, right:16, top:16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        print('Clicado!');
                      },
                      child: SvgPicture.asset('assets/svg/drawer_icon.svg'),
                    ),
                    
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/images/user_image.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Card Section
              SizedBox(
                height: 25,
              ),

              // Nome do usuario
              Padding(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Bom dia!', style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: kBlackColor,
                    )),
                    Text('Amanda Alex', style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: kBlackColor,
                    )),
                  ],
                ),
              ),

              // Cartões 
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  itemCount: cards.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 200,
                      width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Color(cards[index].cardBackground),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: SvgPicture.asset(cards[index].cardElementTop),
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(cards[index].cardElementBottom),
                          ),

                          Positioned(
                            left: 30,
                            top: 38,
                            child: Text('CARD NUMBER', style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kWhiteColor,
                            ),),
                          ),

                          Positioned(
                            left: 30,
                            top: 58,
                            child: Text(cards[index].cardNumber, style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: kWhiteColor,
                            ),),
                          ),

                          Positioned(
                            right: 20,
                            top: 30,
                            child: Image.asset(cards[index].cardType, width: 40, height: 40),
                          ),

                          Positioned(
                            left: 30,
                            bottom: 45,
                            child: Text('CARD HOLDERNAME', style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kWhiteColor,
                            ),),
                          ),

                          Positioned(
                            left: 30,
                            bottom: 20,
                            child: Text(cards[index].user, style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: kWhiteColor,
                            ),),
                          ),

                          Positioned(
                            left: 202,
                            bottom: 45,
                            child: Text('EXPIRY DATE', style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kWhiteColor,
                            ),),
                          ),

                          Positioned(
                            left: 202,
                            bottom: 20,
                            child: Text(cards[index].cardExpired, style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: kWhiteColor,
                            ),),
                          ),

                        ]
                      ),
                    );
                  }
                ),
              ),

              // Operações
              Padding(padding: EdgeInsets.only(left: 16, bottom: 12, top: 30, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                    Text('Operações', style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kBlackColor
                    ),),
                    Row(
                      children:map<Widget>(
                        datas,
                        (index, selected){
                          return Container(
                            alignment: Alignment.centerLeft,
                            height: 9,
                            width: 9,
                            margin: EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: current == index ? kBlueColor : kTwentyBlueColor
                            ),
                          );
                        }
                      )
                    )
                  ]
                ),
              ),

              // Cards das Operações
              Container(
                height: 180,
                child: ListView.builder(
                  itemCount: datas.length,
                  padding: EdgeInsets.only(left: 16, bottom: 20),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        current = index;
                      });
                    },
                    child: OperationCard(
                      operation: datas[index].name,
                      selectedIcon: datas[index].selectedIcon,
                      unselectedIcon: datas[index].unselectedIcon,
                      isSelected: current == index,
                      context: this
                    ),
                  );
                })
              ),

              // Transações
              Padding(padding: EdgeInsets.only(left: 16, bottom: 13, top: 30, right: 10),
                child: Text('Histórico de Transações', style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor
                  ),
                ),
              ),
              
              // Lista de transações
              ListView.builder(
                itemCount: transactions.length,
                padding: EdgeInsets.only(left: 16, right: 16),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return Container(
                    height: 100,
                    margin: EdgeInsets.only(bottom:14),  
                    padding: EdgeInsets.only(left:24, top:12, bottom:12, right:22),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: kTenBlackColor,
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(8.0, 8.0),
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children:<Widget>[
                            Container(
                              height: 57,
                              width: 57,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: AssetImage(transactions[index].photo),)
                              ),
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(transactions[index].name, style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: kBlackColor
                                ),),
                                Text(transactions[index].date, style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: kGreyColor
                                ),),
                              ]
                            )
                          ]
                        ),
                        Row(
                          children: <Widget>[
                            Text(transactions[index].amount, style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: kBlueColor 
                            ),)
                          ]
                        )
                      ]
                    ),
                  );
                }
              )
            
            ],
          ),
        ),
      ),
    );
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;
  _HomeScreenState context;

  OperationCard({
    this.operation,
    this.selectedIcon,
    this.unselectedIcon,
    this.isSelected,
    this.context 
  });

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 123,
      height: 123,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kTenBlackColor,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(8.0, 8.0)
        )
        ],
        borderRadius: BorderRadius.circular(15),
        color: widget.isSelected ? kBlueColor : kWhiteColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center, 
        children: <Widget>[
          SvgPicture.asset(widget.isSelected ? widget.selectedIcon : widget.unselectedIcon),
          SizedBox(height: 9),
          Text(widget.operation,
          textAlign: TextAlign.center, style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: widget.isSelected ? kWhiteColor : kBlueColor
          ),)
        ]
      )
    );
  }
}