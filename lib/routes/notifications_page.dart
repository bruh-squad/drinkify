import 'package:drinkify/utils/theming.dart';
import 'package:drinkify/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Theming.primaryColor,
            ),
          ),
        ),
        title: const Text(
          "12 powiadomień",
          style: TextStyle(
            color: Theming.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        backgroundColor: Theming.primaryColor,
        onTap: () {},
        child: const Text(
          "Oznacz jako przeczytane",
          style: TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      // Notification list
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 12; i++) _notificationItem(context),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem(BuildContext ctx) {
    return InkWell(
      onTap: () {
        //TODO on click show more information about the notification
        showModalBottomSheet(
          context: ctx,
          builder: (_) {
            return const SizedBox();
          },
        );
      },
      splashColor: Theming.whiteTone.withOpacity(0.05),
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Theming.bgColorLight,
                backgroundImage: NetworkImage(
                    "https://imgs.search.brave.com/lek-f6DrXwq-rOwULco3qjCi9C7IH6nhTo_pySkwVdM/rs:fit:1067:1200:1/g:ce/aHR0cDovLzQuYnAu/YmxvZ3Nwb3QuY29t/Ly1LUjJrSGY2Mjhm/MC9VeERaYlR4UkJC/SS9BQUFBQUFBQUF3/OC8wd0xJbFpLWFow/US9zMTYwMC8oMStv/ZisyKSthLmpwZw"),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Zaproszenie od ",
                          style: TextStyle(
                            color: Theming.whiteTone,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: "@Ziemniak",
                          style: TextStyle(
                            color: Color(0xFFAEFF00),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "12 minut temu",
                    style: TextStyle(
                      color: Theming.whiteTone.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.circle,
                size: 8,
                color: Theming.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
