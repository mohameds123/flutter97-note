import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/features/home/logic/cubit.dart';
import 'package:note_flutteronline_97/features/home/presentation/widget/header_widget.dart';

import '../widget/note_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetHomeDataCubit()..getHomeData(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
                spacing: 24, children: [HeaderWidget(), NoteWidget()]),
          ),
        ),
      ),
    );
  }
}
