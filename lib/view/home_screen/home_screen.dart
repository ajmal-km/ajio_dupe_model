import 'package:ajio_dupe_model/controller/home_screen_controller.dart';
import 'package:ajio_dupe_model/utils/color_constants.dart';
import 'package:ajio_dupe_model/view/home_screen/widgets/shopping_card.dart';
import 'package:ajio_dupe_model/view/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().getCategory();
        await context.read<HomeScreenController>().getAllProducts();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeScreenController>();
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: _buildAppBarSection(),
      body: homeProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.blue,
              ),
            )
          : Column(
              children: <Widget>[
                buildTopSection(),
                SizedBox(height: 14),
                _buildCategorySection(homeProvider),
                SizedBox(height: 20),
                _buildProductsGridSection(homeProvider),
              ],
            ),
    );
  }

  AppBar _buildAppBarSection() {
    return AppBar(
      backgroundColor: ColorConstants.blue,
      title: Text(
        "SHOPKART",
        style: TextStyle(
          color: ColorConstants.white,
          letterSpacing: -1,
          fontSize: 29,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        Stack(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.bell,
              color: ColorConstants.white,
              size: 30,
            ),
            Positioned(
              top: 1,
              right: -0,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: ColorConstants.white,
                child: Center(
                  child: Text(
                    "1",
                    style: TextStyle(color: ColorConstants.blue, fontSize: 8),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 15)
      ],
    );
  }

  Widget buildTopSection() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  cursorWidth: 3,
                  cursorColor: ColorConstants.blue,
                  cursorHeight: 22,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: ColorConstants.blue,
                      size: 30,
                    ),
                    hintText: "Search anything",
                    hintStyle: TextStyle(
                      color: ColorConstants.blue,
                      fontSize: 19,
                    ),
                    fillColor: Colors.grey[300],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(
                        width: 2.5,
                        color: ColorConstants.blue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 13),
              Container(
                height: 62,
                width: 62,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorConstants.blue,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: FaIcon(
                  FontAwesomeIcons.filter,
                  color: ColorConstants.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(HomeScreenController homeProvider) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 14),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 15),
        itemCount: homeProvider.categories.length,
        itemBuilder: (context, index) => InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            context.read<HomeScreenController>().setSelectedCategory(index);
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: homeProvider.selectedCategoryIndex == index
                  ? ColorConstants.blue
                  : null,
              border: homeProvider.selectedCategoryIndex == index
                  ? null
                  : Border.all(width: 2, color: ColorConstants.blue),
            ),
            child: Text(
              homeProvider.categories[index].toString().toUpperCase(),
              style: TextStyle(
                color: homeProvider.selectedCategoryIndex == index
                    ? ColorConstants.white
                    : ColorConstants.blue,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGridSection(HomeScreenController homeProvider) {
    return Expanded(
      child: homeProvider.isGridLoading
          ? Center(
              child: CircularProgressIndicator(color: ColorConstants.blue),
            )
          : GridView.builder(
              padding: EdgeInsets.all(14),
              itemCount: homeProvider.productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                mainAxisExtent: 330,
              ),
              itemBuilder: (context, index) => ShoppingCard(
                image: homeProvider.productList[index].image.toString(),
                title: homeProvider.productList[index].title.toString(),
                price: homeProvider.productList[index].price.toString(),
                onCardTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(
                        id: homeProvider.productList[index].id!,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
