import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/models/database.dart';
import 'package:easy_stepper/easy_stepper.dart';

class AddNewProperty extends StatelessWidget {
  String id;
  AddNewProperty({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> addPropertyForm = GlobalKey<FormState>();
    var dbclass = context.read<DataBase>();

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController cityController =
        TextEditingController(text: dbclass.initial_city);

    String id = dbclass.id;

    List<Step> steps = [
      Step(
        title: const Text('Title'),
        content: TextFormField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Property Title'),
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Price'),
        content: TextFormField(
          controller: priceController,
          decoration: const InputDecoration(labelText: 'Enter Price'),
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Description'),
        content: TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        isActive: true,
      ),
    ];

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
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border:
                    //           Border.all(color: Colors.transparent, width: 5),
                    //       color: Colors.transparent),
                    //   child: Icon(
                    //     Icons.check_circle_sharp,
                    //     color: Theme.of(context).primaryColor,
                    //   ),
                    // ),

                    Consumer<DataBase>(
                      builder: (context, val, child) {
                        print(val.previousStep);
                        return Stepper(
                          currentStep: val.activeIndex,
                          onStepContinue: val.nextStep,
                          onStepCancel: val.previousStep,
                          steps: [
                            Step(
                              isActive: true,
                              title: const Text('Property Details'),
                              content: Form(
                                key: addPropertyForm,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Property Type',
                                        style: GoogleFonts.ubuntu(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 19.0),
                                      ),
                                    ),
                                    CustomRadioButton(
                                      padding: 10.0,
                                      autoWidth: true,
                                      enableButtonWrap: false,
                                      defaultSelected: 'Residential',
                                      elevation: 0,
                                      absoluteZeroSpacing: true,
                                      unSelectedColor:
                                          Theme.of(context).canvasColor,
                                      buttonLables: const [
                                        'Residential',
                                        'Commercial',
                                      ],
                                      buttonValues: const [
                                        "Residential",
                                        "Commercial",
                                      ],
                                      buttonTextStyle: ButtonTextStyle(
                                        selectedColor: Colors.white,
                                        unSelectedColor: Colors.black,
                                        textStyle:
                                            GoogleFonts.ubuntu(fontSize: 16),
                                      ),
                                      radioButtonValue: (value) {
                                        print(value);
                                      },
                                      enableShape: true,
                                      margin: const EdgeInsets.all(2.0),
                                      selectedColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Title'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a title';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        // title = value;
                                      },
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Description'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a description';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        // _propertyDescription = value;
                                      },
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Price'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a price';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        // _propertyPrice = value;
                                      },
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Address'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter an address';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        // _propertyAddress = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Step(
                              title: const Text('Add Images'),
                              content: Column(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0,
                                      ),
                                      itemCount: val.propertyImages.length + 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index == 0) {
                                          return IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              val.pickImage;
                                            },
                                          );
                                        } else {
                                          return Image.file(
                                              val.propertyImages[index - 1]);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // Consumer<DataBase>(builder: (context, value, child) {
                    //   return Stepper(
                    //     currentStep: value.activeIndex,
                    //     steps: [
                    //       Step(
                    //         title: const Text('Basic Details'),
                    //         content: Form(
                    //           key: addPropertyForm,
                    //           child: Column(
                    //             // padding: const EdgeInsets.all(
                    //             //   12.0,
                    //             // ),
                    //             children: [
                    //               Center(
                    //                 child: DotStepper(
                    //                   activeStep: dbclass.activeIndex,
                    //                   dotRadius: 20.0,
                    //                   shape: Shape.pipe,
                    //                   spacing: 10.0,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 "Step ${dbclass.activeIndex + 1} of $dbclass.totalIndex",
                    //                 style: const TextStyle(
                    //                   fontSize: 20.0,
                    //                 ),
                    //                 textAlign: TextAlign.center,
                    //               ),
                    //               TextFormField(
                    //                 decoration: const InputDecoration(
                    //                   labelText: "Title",
                    //                 ),
                    //               ),
                    //               TextFormField(
                    //                 decoration: const InputDecoration(
                    //                   labelText: "Price",
                    //                 ),
                    //               ),
                    //               TextFormField(
                    //                 decoration: const InputDecoration(
                    //                   labelText: "Location",
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 height: 12.0,
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       const Step(
                    //         title: Text('Size & Area'),
                    //         content: Text('Area, size, commercial,residential'),
                    //       ),
                    //       const Step(
                    //         title: Text('Select Images'),
                    //         content: Text('Primary image and gallery images.'),
                    //       ),
                    //     ],
                    //   );
                    // }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
