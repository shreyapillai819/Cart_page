import 'package:cart_page/controllers/cart_controller.dart';
import 'package:cart_page/eventpage/GlassMorphicContainer.dart';
import 'package:cart_page/eventpage/specific_event%20(1).dart';
import 'package:cart_page/landing_page/home.dart';
import 'package:cart_page/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NonTechEventsPage extends StatefulWidget {
  @override
  _NonTechEventsPageState createState() => _NonTechEventsPageState();
}

class _NonTechEventsPageState extends State<NonTechEventsPage> {
  final PageController _pageController = PageController();
  Color _containerColor = Color(0xff040829);
  List<Widget> eventPages = [];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
    _buildEventPages();
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      int currentPage = _pageController.page?.round() ?? 0;
      _containerColor = currentPage % 2 == 0
          ? Color.fromRGBO(7, 14, 71, 1)
          : Color.fromRGBO(5, 10, 52, 1);
    });
  }

  void _buildEventPages() {
    eventPages.clear();
    List<Event> displayedEvents = []; // Keep track of displayed events
    for (int i = 0; i < Event.events.length; i++) {
      Event currentEvent = Event.events[i];
      // if ((i) == 2) {
      //     eventPages.add(SizedBox(height: 1000));
      //   }
      if (!currentEvent.isTechnical &&
          !displayedEvents.contains(currentEvent)) {
        print(i);
        displayedEvents.add(currentEvent);
        if (eventPages.length % 2 == 0) {
          eventPages.add(
            CombinedEventCard(event: currentEvent),
          );
          if ((i) == 8) {
            eventPages.add(SizedBox(height: 250));
          }
        } else {
          print(i);
          eventPages.add(
            revCombinedEventCard(event: currentEvent),
          );
        }

        // Check if i is a multiple of 3 and add SizedBox
        // if ( (i)!=0 && (i) % 3 == 0) {
        //   eventPages.add(SizedBox(height: 20)); // Adjust height as needed
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _containerColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => HomePage());
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/7.gif",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03,
                  ),
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.height * 1,
                  color: _containerColor,
                  child: Center(
                    child: Text(
                      'Credenz\'24 ',
                      style: GoogleFonts.berkshireSwash(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: _containerColor,
                  width: MediaQuery.of(context).size.height * 1,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Center(
                    child: Text(
                      "Non Tech Events",
                      style: TextStyle(
                        fontFamily: "berky",
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: eventPages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return eventPages[index];
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CombinedEventCard extends StatelessWidget {
  final Event event;
  const CombinedEventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a new page or display a modal/dialog with swipeable content
        // Example:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificPage(event: event),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/new.gif"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          // Adjust as needed
          horizontal: 10.0, // Adjust as needed
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                  ),
                  height: 120,
                  width: 120,
                  child: Center(
                    child: Hero(
                      tag: 'event-name-${event.name}',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          event.name, // Access event name from Event object
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Hero(
                    tag: event.imageUrl, // Unique tag for the hero animation
                    child: EventCard(
                      color1: Color.fromRGBO(4, 90, 171, 0.7),
                      color2: Color.fromRGBO(1, 37, 84, 0.7),
                      width: MediaQuery.of(context).size.width * 0.4,
                      eventimgsrc: event
                          .imageUrl, // Access image source from Event object
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final double width;
  final Color color1;
  final Color color2;
  final String eventimgsrc;

  const EventCard({
    required this.width,
    required this.color1,
    required this.color2,
    required this.eventimgsrc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              eventimgsrc,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}

class revCombinedEventCard extends StatelessWidget {
  final Event event;

  const revCombinedEventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a new page or display a modal/dialog with swipeable content
        // Example:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificPage(event: event),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/6.gif"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          // Adjust as needed
          horizontal: 10.0, // Adjust as needed
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Hero(
                    tag: event.imageUrl, // Unique tag for the hero animation
                    child: EventCard(
                      color1: Color.fromRGBO(4, 90, 171, 0.7),
                      color2: Color.fromRGBO(1, 37, 84, 0.7),
                      width: MediaQuery.of(context).size.width * 0.4,
                      eventimgsrc: event
                          .imageUrl, // Access image source from Event object
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                  ),
                  height: 120,
                  width: 120,
                  child: Center(
                    child: Hero(
                      tag: 'event-name-${event.name}',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          event.name, // Access event name from Event object
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeableContent extends StatefulWidget {
  final Event event;

  const SwipeableContent({Key? key, required this.event}) : super(key: key);

  @override
  State<SwipeableContent> createState() {
    return _SwipeableContentState();
  }
}

class _SwipeableContentState extends State<SwipeableContent> {
  late final CartController controller;
  int currentIndex = 0;
  void initState() {
    super.initState();
    controller = Get.put(CartController());
  }

  List<IconData> desIcon = [
    Icons.description_outlined,
    Icons.rule_sharp,
    Icons.schedule,
    Icons.call,
  ];

  @override
  Widget build(BuildContext context) {
    Event event = widget.event;
    List<String> content = [
      event.description,
      event.rules,
      event.schedule,
      event.contact,
    ];

    return Center(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              // Swiped left
              if (details.velocity.pixelsPerSecond.dx < 0) {
                setState(() {
                  currentIndex =
                      (currentIndex + 1) % 4; // Assuming there are 4 sections
                });
              }
              // Swiped right
              else if (details.velocity.pixelsPerSecond.dx > 0) {
                setState(() {
                  currentIndex = (currentIndex - 1) % 4;
                  if (currentIndex < 0) currentIndex = 3;
                });
              }
            },
            child: Center(
              child: GlassmorphicContainer1(
                borderRadius: MediaQuery.of(context).size.height *
                    0.02, // 2% of screen height
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height *
                              0.01), // 1% of screen height
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          desIcon.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            child: Text(
                              String.fromCharCode(desIcon[index].codePoint),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'MaterialIcons',
                                fontSize: MediaQuery.of(context).size.height *
                                    0.03, // 3% of screen height
                                decoration: currentIndex == index
                                    ? TextDecoration.underline
                                    : null,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      endIndent: 0,
                      indent: 0,
                      color: Colors.white,
                      thickness: 1,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.005,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          // 0.5% of screen height and 5% of screen width
                          child: Text(
                            content[currentIndex],
                            style: const TextStyle(
                              fontFamily: "Bunaken",
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Price\tRs.50/-",
                            style: TextStyle(
                              fontFamily: 'Bunaken',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.height *
                                0.1, // 10% of screen height
                            height: MediaQuery.of(context).size.height *
                                0.06, // 10% of screen height
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.8),
                            ),
                            child: IconButton(
                              onPressed: () {
                                controller.addProduct(context, event);
                              },
                              icon: const Icon(
                                Icons.add_shopping_cart_rounded,
                                color: Colors.black,
                                size: 19,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
