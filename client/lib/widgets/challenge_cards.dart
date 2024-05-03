import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trailquest/pages/individual_challenge_page.dart';
import 'package:trailquest/widgets/challenge.dart';

final List<String> challengeTypes = <String>['Checkpoints', 'Quiz', 'Orienteering'];

/**
 * Creates the cards that will be visible on the challenge page and start page.
 * As of now, the accepted types are 'Checkpoints', 'Orienteering' and 'Quiz' but it's likely that Quiz will be substituted for 'Straight line'
 */

class ChallengeCard extends StatefulWidget{
  Challenge challenge;

  ChallengeCard(Challenge current, {
    super.key,
    required this.challenge
  });

  @override
  State<ChallengeCard> createState() => _CardState();
}

class _CardState extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {
    int complete = widget.challenge.complete;
    int progress = widget.challenge.progress;
    if(widget.challenge.type == 'Checkpoints') {
      return GestureDetector(
        onTap:() {
          Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              pageBuilder: (context, x, xx) => IndividualChallengePage(challenge: widget.challenge,),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ));
        },
        child: Container(
          height: 150,
          width: 380,
          color: const Color.fromARGB(255, 89, 164, 224),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '${widget.challenge.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(35)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '$progress/$complete checkpoints',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          'assets/icons/img_arrow_right.svg',
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      )
                    ),
                  ],
                )
              ],
            )
          )
        ),
      );
    }
    else if(widget.challenge.type == 'Treasure hunt') {
      return GestureDetector(
        onTap:() {
          Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              pageBuilder: (context, x, xx) => IndividualChallengePage(challenge: widget.challenge),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ));
        },
        child: Container(
          height: 150,
          width: 380,
          color: Color.fromARGB(255, 250, 159, 74),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '${widget.challenge.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(35)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '$progress/$complete locations visited',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          'assets/icons/img_arrow_right.svg',
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      )
                    ),
                  ],
                )
              ],
            )
          )
        ),
      );
    }
    else if(widget.challenge.type == 'Orienteering') {
      return GestureDetector(
        onTap:() {
          Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              pageBuilder: (context, x, xx) => IndividualChallengePage(challenge:widget.challenge),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ));
        },
        child: Container(
          height: 150,
          width: 380,
          color: Color.fromARGB(255, 137, 70, 196),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.challenge.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(35)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '$progress/$complete control points',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          'assets/icons/img_arrow_right.svg',
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      )
                    ),
                  ],
                )
              ],
            )
          )
        ),
      );
    }
    else {
      // A default challenge that does not belong to any of the given types, not meant to actually be used
      return GestureDetector(
        onTap:() {},
        child: Container(
          height: 150,
          width: 380,
          color: Color.fromARGB(255, 134, 139, 143),
        
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'No ongoing challenges',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(35)),
              ],
            )
          )
        ),
      );
    }
  }
}