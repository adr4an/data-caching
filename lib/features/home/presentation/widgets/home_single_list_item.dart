import 'package:data_caching/core/utils/custom_image_viewer.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSingeListItem extends StatelessWidget {
  const HomeSingeListItem({
    super.key,
    required this.current,
  });

  final Product current;

  @override
  Widget build(BuildContext context) {

    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * .004,
        horizontal: height * .01,
      ),
      height: height * .2,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(height * .02),
      ),
      child: Material(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(height * .02),
        elevation: 1,
        child: Row(
          children: [
            Container(
              width: width * 0.35,
              color: theme.cardColor,
              child: CustomImageViewer.show(
                context: context,
                url: current.image, 
              ),
            ),
            SizedBox(
              width: width * .02,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        current.id.toString(),
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        current.description,
                        style: GoogleFonts.poppins(
                          // limit description to 2 lines
                          
                          fontSize: 12,
                          textStyle: theme.textTheme.labelLarge
                              ?.copyWith(color: theme.unselectedWidgetColor),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
             
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width * .03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Text(
                              current.category.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                textStyle: theme.textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "\$${current.price}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            textStyle: theme.textTheme.labelLarge
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

