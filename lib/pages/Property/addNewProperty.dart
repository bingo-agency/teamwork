import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/database.dart';
import 'package:im_stepper/stepper.dart';

class AddNewProperty extends StatelessWidget {
  String id;
  AddNewProperty({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> addPropertyForm = GlobalKey<FormState>();
    var dbclass = context.read<DataBase>();

    // Widget formWizard() {
    //   switch (dbclass.activeIndex) {
    //     case 0:
    //       return basicDetails();
    //     case 1:
    //       return basicDetails();
    //     default:
    //       return basicDetails();
    //   }
    // }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Property",
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700, color: Colors.white),
          ),
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "https://teamworkpk.com/img/adPrpty.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.transparent, width: 5),
                          color: Colors.transparent),
                      child: Icon(
                        Icons.check_circle_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Consumer<DataBase>(
                      builder: (context, value, child) {
                        switch (value.activeIndex) {
                          case 0:
                            return basicDetails(
                                addPropertyForm: addPropertyForm,
                                dbclass: dbclass);
                          case 1:
                            return basicDetails(
                                addPropertyForm: addPropertyForm,
                                dbclass: dbclass);
                          default:
                            return basicDetails(
                                addPropertyForm: addPropertyForm,
                                dbclass: dbclass);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class basicDetails extends StatelessWidget {
  var addPropertyForm;
  var dbclass;
  basicDetails(
      {Key? key, required this.addPropertyForm, required DataBase dbclass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addPropertyForm,
      child: ListView(
        padding: const EdgeInsets.all(
          12.0,
        ),
        children: [
          Center(
            child: DotStepper(
              activeStep: dbclass.activeIndex,
              dotRadius: 20.0,
              shape: Shape.pipe,
              spacing: 10.0,
            ),
          ),
          Text(
            "Step ${dbclass.activeIndex + 1} of $dbclass.totalIndex",
            style: const TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Name",
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Passoword",
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
              onPressed: () {
                if (addPropertyForm.currentState?.validate() ?? false) {
                  // next
                  // setState(() {
                  //   activeIndex++;
                  // });
                }
              },
              child: const Text(
                "Next",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
