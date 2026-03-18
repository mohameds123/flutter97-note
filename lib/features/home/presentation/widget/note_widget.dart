import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/core/utils/colors_manager.dart';
import 'package:note_flutteronline_97/features/home/logic/cubit.dart';
import 'package:note_flutteronline_97/features/home/logic/state.dart';
import 'package:note_flutteronline_97/features/update_note/presentation/update_note_screen.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataCubit, GetHomeDataStates>(
      builder: (context, state) {
        if (state is GetHomeDataLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetHomeDataSuccessState ) {
          return (state.noteModel.isEmpty) ? Center(child: Text("Note is Empty",style: TextStyle(color: Colors.white),)) : SizedBox(
            height: 700,
            child: ListView.builder(
              itemCount: state.noteModel.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateNoteScreen(noteDate: state.noteModel[index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.marron,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.noteModel[index].noteName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<GetHomeDataCubit>().deleteNote(state.noteModel[index].noteId!);
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.noteModel[index].noteHeadline,
                                  style: TextStyle(
                                    color: ColorsManager.txtGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${state.noteModel[index].time.hour.toString()} : ${state.noteModel[index].time.minute.toString()} ${state.noteModel[index].time.hour > 12 ? "PM" : "AM"}".toString(),
                                  style: TextStyle(
                                    color: ColorsManager.txtGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is GetHomeDataErrorState) {
          return Text(state.errorMessage,style: TextStyle(
            color: Colors.white
          ),);
        }
        return SizedBox();
      },
    );
  }
}
