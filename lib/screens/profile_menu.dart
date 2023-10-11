import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      required this.endIcon,
      required this.textColor});

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.red.withOpacity(0.2),
        ),
        child: Icon(
          icon,
          color: Colors.red,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: textColor,
        ),
      ),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.red.withOpacity(0.2),
              ),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 19,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
