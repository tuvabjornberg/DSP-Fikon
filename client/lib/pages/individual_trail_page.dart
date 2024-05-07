import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trailquest/widgets/trail_cards.dart';
import '../widgets/back_button.dart'; 

class IndividualTrailPage extends StatefulWidget{

  TrailCard trail; // Trail card that contains all info about the trail
  bool saved;
  final ValueChanged<bool> onSaveChanged; // Callback function to the trail card that changes the isSaved value of the trail card 

  IndividualTrailPage({
    Key? key,
    required this.trail,
    required this.saved,
    required this.onSaveChanged,
  }) : super(key: key);

  @override
  State<IndividualTrailPage> createState() => _IndividualTrailPageState(trail: trail, saved: saved);
}

class _IndividualTrailPageState extends State<IndividualTrailPage> {

  bool saved = false; 
  TrailCard trail; 

  _IndividualTrailPageState({Key? key, required this.trail, required this.saved}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: Column( 
          children: [
            Row(
              children: [
                GoBackButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('${trail.name}', 
                    style: TextStyle(fontSize: 20)),
                ),
              ],
            ), 
            ///
            /// The map showing the trail
            /// 
            Expanded(
              child: Center(
                child: GoogleMap(
                  //TODO: fix map settings
                  //onMapCreated: (GoogleMapController controller) {
                  //  _controller.complete(controller);
                  //},
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(59.83972677529924, 17.6465716818546),
                      zoom: 15
                  ),
                ),
              ),
            ),
            ///
            /// Display the information about the trail 
            /// 
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/img_walking.svg', 
                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            height: 35,
                            width: 50,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text('${trail.lengthDistance/1000} km', style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/img_clock.svg', 
                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            height: 35,
                            width: 50,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text('${trail.lengthTime} min', style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/img_trees.svg', 
                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            height: 35,
                            width: 50,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text('${trail.natureStatus}', style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/img_stairs.svg', 
                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            height: 35,
                            width: 50,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(trail.stairs ? 'This route could contain stairs' : 'This route does not contain any stairs',
                          style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/img_arrow_up.svg', 
                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            height: 35,
                            width: 50,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text('${trail.heightDifference}', style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ],
              ), 
            ),
            /// 
            /// Displays the 'Save' or 'Remove' button depending on whether the trail is saved 
            ///  
            if (saved) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RemoveTrail(
                  onRemove: (value) {
                    setState(() {
                      saved = value;
                      widget.onSaveChanged(false);
                    });
                  },
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SaveTrail(
                  onSave: (value) {
                    setState(() {
                      saved = value;
                      widget.onSaveChanged(true);
                    });
                  },
                ),
              ),
            ]
          ]
        )  
      ),
    );
  }
}

  /// 
  /// 'Save Trail' button 
  /// 

class SaveTrail extends StatefulWidget {
  final Function(bool) onSave;

  const SaveTrail({Key? key, required this.onSave}) : super(key: key);
  @override
  State<SaveTrail> createState() => _SaveTrailState();
}

class _SaveTrailState extends State<SaveTrail> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      onPressed: () {
        widget.onSave(true);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: const Text('Save Trail +', style: TextStyle(color: Colors.white, fontSize: 30)),
    );
  }
}

  /// 
  /// 'Remove Trail' button 
  /// 

class RemoveTrail extends StatefulWidget {
  final Function(bool) onRemove;

  const RemoveTrail({Key? key, required this.onRemove}) : super(key: key);

  @override
  State<RemoveTrail> createState() => _RemoveTrailState();
}

class _RemoveTrailState extends State<RemoveTrail> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      onPressed: () {
        widget.onRemove(false);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: const Text('Remove Trail', style: TextStyle(color: Colors.white, fontSize: 30)),
    );
  }
}