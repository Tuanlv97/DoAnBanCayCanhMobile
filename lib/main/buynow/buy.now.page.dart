// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:app_mobile/main/cart/cart.page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:service_bill/service_bill.dart';
import 'package:service_plant/service_plant.dart';

import 'package:app_mobile/confing.dart';
import 'package:app_mobile/constants/button.not.click.multi.dart';
import 'package:app_mobile/constants/format.dart';
import 'package:app_mobile/main.router.constant.dart';
import 'package:app_mobile/repository/authentication.repository.dart';

import 'buy.now.cubit.dart';
import 'buy.now.cubit.state.dart';

class BuyNowPage extends StatefulWidget {
  const BuyNowPage({super.key});

  @override
  State<BuyNowPage> createState() => _BuyNowPageState();
}

class _BuyNowPageState extends State<BuyNowPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyNowCubit, BuyNowCubitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(color: const Color(0xFFEFEAEA), borderRadius: BorderRadius.circular(20)),
                  child: ButtonNotClickMulti(
                    onTap: () {
                      context.pop();
                    },
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: const Text(
              "Đặt hàng",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF325A3E)),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  for (int i = 0; i < state.listCart.length; i++)
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 32,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: (state.listCart[i].plant?.listImage().first != null && state.listCart[i].plant?.listImage().first != "")
                                  ? CachedNetworkImage(
                                      imageUrl: "$baseUrlImage${state.listCart[i].plant?.listImage().first}",
                                      imageBuilder: (context, imageProvider) => Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                          image: DecorationImage(image: AssetImage("assets/plant.png"), fit: BoxFit.cover),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                          image: DecorationImage(image: AssetImage("assets/plant.png"), fit: BoxFit.cover),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                        image: DecorationImage(image: AssetImage("assets/plant.png"), fit: BoxFit.cover),
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        state.listCart[i].plant?.name ?? "",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "${formatNumber(int.tryParse(state.listCart[i].plant!.price.toString()) ?? 0)} VNĐ",
                                        style: const TextStyle(fontSize: 14, color: Color(0xFFDF0000)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5), border: Border.all(color: const Color(0xFF3A7F0D))),
                                          child: InkWell(
                                              onTap: () {
                                                context.read<BuyNowCubit>().removeNumberCart(i);
                                              },
                                              child: const Center(
                                                child: Text("-"),
                                              )),
                                        ),
                                        const SizedBox(width: 12),
                                        Text("${state.listCart[i].number}"),
                                        const SizedBox(width: 12),
                                        Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5), border: Border.all(color: const Color(0xFF3A7F0D))),
                                          child: InkWell(
                                              onTap: () {
                                                context.read<BuyNowCubit>().addNumberCart(i);
                                              },
                                              child: const Center(
                                                child: Text("+"),
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 223,
            padding: const EdgeInsets.only(left: 37, right: 37, top: 16, bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thành tiền:",
                      style: TextStyle(color: Color(0xFF3B7254), fontSize: 16),
                    ),
                    Text(
                      "${formatNumber(state.total)} đ",
                      style: TextStyle(color: Color(0xFF3B7254), fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phí vận chuyển:",
                      style: TextStyle(color: Color(0xFF3B7254), fontSize: 16),
                    ),
                    Text(
                      "30.000 đ",
                      style: TextStyle(color: Color(0xFF3B7254), fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(height: 2, color: Color(0xFF9D9D9D)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thành tiền:",
                      style: TextStyle(color: Color.fromARGB(255, 4, 4, 4), fontSize: 16),
                    ),
                    Text(
                      "${formatNumber(state.total + 30000)} VNĐ",
                      style: const TextStyle(fontSize: 16, color: Color(0xFFDF0000)),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 50,
                  decoration: BoxDecoration(color: const Color(0xFF3B7254), borderRadius: BorderRadius.circular(25), boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ]),
                  child: ButtonNotClickMulti(
                      onTap: () async {
                        DataSendBill dataSendBill = DataSendBill(listCart: [], billModel: BillModel(listDetail: []));
                        List<BillDetailModel> listDetail = [];
                        for (int i = 0; i < state.listCart.length; i++) {
                          listDetail.add(BillDetailModel(
                              idPlant: state.listCart[i].plant?.id ?? 0, plant: state.listCart[i].plant, number: state.listCart[i].number));
                        }
                        dataSendBill.billModel = BillModel(
                          idUser: context.read<AuthenticationRepository>().currentUser?.id ?? 0,
                          listDetail: listDetail,
                          total: state.total + 30000,
                          status: 0,
                          methodPayment: 0,
                        );
                        context.push(MainRouterPath.routerPayment, extra: dataSendBill);
                      },
                      child: const Center(
                        child: Text(
                          "Đặt hàng",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
