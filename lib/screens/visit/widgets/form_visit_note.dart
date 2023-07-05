import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/bloc/visitnote/visitnote_bloc.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';

class FormVisitNoteNew extends StatelessWidget {
  String? noteId;
  String visitId;
  FormVisitNoteNew({super.key, this.noteId, required this.visitId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleC = TextEditingController();
    final TextEditingController noteC = TextEditingController();
    List tags = [];
    VisitnoteBloc bloc = BlocProvider.of<VisitnoteBloc>(context);
    VisitnoteBloc vBloc = VisitnoteBloc();

    return WillPopScope(
      onWillPop: () async {
        if (noteId != null) {
          bloc.add(
            GetVisitNote(
              visitId: visitId,
            ),
          );
        }

        return true;
      },
      child: BlocBuilder<VisitnoteBloc, VisitnoteState>(
        bloc: vBloc,
        builder: (context, state) {
          if (state is VisitNoteIsFailure) {}

          if (noteId != null && visitId != null && state is VisitnoteInitial) {
            vBloc.add(
              ShowVisitNote(id: "$noteId"),
            );
          }

          if (state is VisitNoteIsLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is VisitNoteShow) {
            tags = state.data['tags'];
            noteId ??= state.data['_id'];
            titleC.text = state.data['title'];
            noteC.text = state.data['notes'];
          }

          return BlocBuilder(
              bloc: BlocProvider.of<VisitBloc>(context),
              builder: (context, stateVisit) {
                String status = "1";
                if (stateVisit is IsShowLoaded) {
                  status = stateVisit.data.status!;
                }
                return Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: const Color(0xFFE6212A),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButtonCustom(onBack: () {
                          if (visitId != null) {
                            bloc.add(
                              GetVisitNote(
                                visitId: visitId,
                              ),
                            );
                          }
                        }),
                        const Row(
                          children: [
                            Icon(Icons.note, size: 17),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text(
                                "Notes",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                          // IconSearch(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file_rounded,
                              color: Color.fromARGB(255, 121, 8, 14),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          enabled: status == "0",
                          controller: titleC,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'Title',
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, //
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            enabled: status == "0",
                            controller: noteC,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Notes Content',
                            ),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 23, 22, 22)),
                          ),
                        ),
                        const Text(
                          "Tags :",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Wrap(
                            children: tags.map((e) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  print(e['_id']);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green[
                                      800], // Warna latar belakang tombol
                                ),
                                icon: const Icon(
                                  Icons.clear,
                                  size: 16,
                                ),
                                label: Text(e['name']),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: Visibility(
                      visible: status == "0",
                      child: SizedBox(
                        height: 250.0,
                        width: 60.0,
                        child: FloatingActionButton(
                          onPressed: () {
                            if (noteId != null) {
                              vBloc.add(UpdateVisitNote(
                                id: "$noteId",
                                data: {
                                  "title": titleC.text,
                                  "notes": noteC.text
                                },
                              ));
                            } else {
                              vBloc.add(InsertVisitNote(
                                data: {
                                  "title": titleC.text,
                                  "notes": noteC.text,
                                  "visitId": visitId,
                                  "tags": ["648035669c2e5446ae9218f3"],
                                },
                              ));
                            }
                          },
                          backgroundColor: Colors.grey[850],
                          child: const Icon(Icons.save),
                        ),
                      )),
                );
              });
        },
      ),
    );
  }
}
