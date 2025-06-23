import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:clean_architecture_assignment/features/users/presentation/screen/user_details.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListTileWidget extends StatelessWidget {
  final UserEntity user;

  const UserListTileWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsScreen(user: user),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 56.r,
              width: 56.r,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: CachedNetworkImage(
                  imageUrl: user.avatar,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
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
