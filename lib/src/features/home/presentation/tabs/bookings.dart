import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/features/home/presentation/widgets/booking_details.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<String> categories = ['Active(3)', 'Delivered(4)', 'New Request(3)'];
  int selectedIndex = 1;
  PageController controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.topCenter,
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => Container(
                    height: 29,
                    margin: EdgeInsets.only(left: index == 0 ? 20 : 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedIndex == index
                              ? color.primary
                              : color.onSecondary,
                          width: selectedIndex == index ? 3 : 1,
                        )),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: selectedIndex == index
                              ? color.primary
                              : color.onSecondary,
                        ),
                      ),
                    ),
                  ).onTap(() {
                    setState(() {
                      selectedIndex = index;
                    });
                  })),
        ),
        Expanded(
          child: PageView(
            controller: controller,
            onPageChanged: (val) {
              setState(() {
                selectedIndex = val;
              });
            },
            children: const [
              SingleChildScrollView(
                child: Column(
                  children: [
                    BookingInformation(),
                    BookingInformation(),
                    BookingInformation(),
                    BookingInformation(),
                    BookingInformation(),
                    BookingInformation(),
                    BookingInformation(),
                    BookingInformation(),
                    BookingInformation(),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    NewRequests(),
                    NewRequests(),
                    NewRequests(),
                    NewRequests(),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class BookingInformation extends StatelessWidget {
  const BookingInformation({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: color.secondary,
          border: Border(top: BorderSide(color: color.onSurface))),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("ID:1234"),
              RichText(
                  text: TextSpan(
                      text: "View Details",
                      style: const TextStyle().copyWith(color: color.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(BookingDetails.routePath);
                        }))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Studio Service",
                      style: const TextStyle().copyWith(color: color.onSurface),
                      children: [
                    TextSpan(
                        text: "(19/30)",
                        style:
                            const TextStyle().copyWith(color: color.primary)),
                  ])),
              RichText(
                  text: TextSpan(
                      text: "New\n",
                      style: const TextStyle()
                          .copyWith(color: color.onSurface, fontSize: 10),
                      children: [
                    TextSpan(
                        text: "Lunch 04/11/2023",
                        style:
                            const TextStyle().copyWith(color: color.primary)),
                  ])),
            ],
          ),
          Divider(
            color: color.surface,
            thickness: 1,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Next Customer Details"),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("No. of People"), Text("100")],
          ),
          Divider(
            color: color.surface,
            thickness: 3,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text("Address"),
              ),
              Expanded(child: Text("123, XYZ Apt. New Delhi,Delhi, 123456"))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomTextButton(
              text: "Chat with Customer",
              ontap: () {},
              borderRadius: 10,
            ),
          )
        ],
      ).addSpacingBetweenElements(10),
    );
  }
}

class NewRequests extends StatelessWidget {
  const NewRequests({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: color.secondary,
          border: Border(top: BorderSide(color: color.onSurface))),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("ID:1234"),
              RichText(
                  text: TextSpan(
                      text: "13:01",
                      style: const TextStyle().copyWith(color: color.primary),
                      recognizer: TapGestureRecognizer()..onTap = () {}))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                text: "Booking Type",
                style: const TextStyle().copyWith(
                    color: color.onSurface, fontWeight: FontWeight.w400),
              )),
              RichText(
                  text: TextSpan(
                text: "Studio Service",
                style: const TextStyle()
                    .copyWith(color: color.onSurface, fontSize: 16),
              )),
            ],
          ),
          Divider(
            color: color.surface,
            thickness: 1,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Studio Details"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Store Details"),
              Text(
                "View",
                style: const TextStyle().copyWith(color: color.primary),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("No. of People"), Text("3")],
          ),
          Divider(
            color: color.surface,
            thickness: 3,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text("Address"),
              ),
              Expanded(child: Text("123, XYZ Apt. New Delhi,Delhi, 123456"))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: color.error)),
                  child: Text(
                    "Reject",
                    style: TextStyle(color: color.error),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomTextButton(
                    bgColor: const Color.fromARGB(255, 83, 216, 88),
                    text: "Accept",
                    ontap: () {},
                    borderRadius: 10,
                  ),
                ),
              ],
            ),
          )
        ],
      ).addSpacingBetweenElements(10),
    );
  }
}
