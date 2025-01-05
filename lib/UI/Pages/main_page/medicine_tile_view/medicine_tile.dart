import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

class MedicineTile extends StatelessWidget {
  const MedicineTile({
    super.key,
    this.time = '10:40',
    this.name = 'placeholder',
    this.taken = false,
    required this.onTapBody,
    required this.onTapIcon,
  });
  final String time;
  final String name;
  final bool taken;
  final Function() onTapBody;
  final Function() onTapIcon;

  //TODO : add the onHold function to display all medicine details

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTapBody,
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: Material(
            color: taken ? xTakenColor : xContainerColor,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        color: taken
                            ? xTakenSecondaryColor
                            : Theme.of(context).primaryColor,
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              time,
                              style: whiteTextStyle.copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name,
                            style: mediumTextStyle.copyWith(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: onTapIcon,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Icon(
                            taken ? Icons.check : Icons.close_rounded,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
