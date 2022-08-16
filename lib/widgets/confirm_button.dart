import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget confirmButton() => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          )
                        ),
                        onPressed: () {
                          Get.back();
                        } ,
                      child: const Text("Ok"),
                                      );