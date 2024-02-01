import 'package:flutter/material.dart';
import 'package:repositories/core/helper/media_query_helper.dart';
import 'package:repositories/core/theming/spacing.dart';
import 'package:repositories/features/home_screen/data/model/repositories_model.dart';
import 'package:intl/intl.dart'; // Import the intl package

import '../../../../core/theming/colors.dart';

class RepositoryItem extends StatelessWidget {
  const RepositoryItem({Key? key, required this.repository}) : super(key: key);

  final Items repository;

  @override
  Widget build(BuildContext context) {
    // Parse the API date string to a DateTime object
    DateTime createdAt = DateTime.parse(repository.createdAt!);

    // Format the DateTime object using the desired pattern
    String formattedDate = DateFormat('yyyy-MM-dd').format(createdAt);

    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: ColorsManager.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {},
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding:  EdgeInsets.symmetric(vertical: context.screenHeight*0.01, horizontal: context.screenWidth*0.01),
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            child: Column(children: [
              Text(
                repository.name!, // Use the formatted date string
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpacing(2),
              Text(
                formattedDate, // Use the formatted date string
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],)
          ),
          child: Container(
            child: repository.owner!.avatarUrl!.isNotEmpty
                ? FadeInImage.assetNetwork(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: 'assets/images/Animation - 1703426463975.gif',
              image: repository.owner!.avatarUrl!,
            )
                : Image.asset('assets/images/No-image-available.jpg'),
          ),
        ),
      ),
    );
  }
}
