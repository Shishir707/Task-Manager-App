import 'package:flutter/material.dart';
import 'package:task_manager/UI/controller/auth_controller.dart';

class TMappbar extends StatelessWidget implements PreferredSizeWidget {
  const TMappbar({super.key, this.fromUpdateProfile = false});

  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromUpdateProfile) {
            return;
          }
          Navigator.pushNamed(context, '/update-profile');
        },
        child: Row(
          spacing: 6,
          children: [
            CircleAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mir M Shishir',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                Text(
                  'shishir@gmail.com',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () async {
                await AuthController.logOutUser();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/sign-in',
                  (predicate) => false,
                );
              },
              icon: Icon(Icons.logout),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
