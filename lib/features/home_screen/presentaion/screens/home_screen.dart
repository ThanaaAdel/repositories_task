import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/core/helper/media_query_helper.dart';
import 'package:repositories/core/networking/api_error_handler.dart';
import 'package:repositories/core/theming/colors.dart';
import 'package:repositories/features/home_screen/presentaion/cubit/repository_cubit.dart';
import 'package:repositories/features/home_screen/presentaion/widgets/repository_item.dart';

import '../../data/model/repositories_model.dart';
import '../cubit/repository_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Repositories repositories;
  List<Items> items = [];
  List<Items> searchResults = [];
  int currentPage = 1;
  int totalItemsToShow = 10;
  final ScrollController _scrollController = ScrollController();
  int incrementalValueInButton50Items = 40;
  int incrementalValueInButton100Items = 90;
  int incrementalValueInButton10Items = 20;
  bool _isSearching = false;
  final _searchController = TextEditingController();
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    BlocProvider.of<CubitRepository>(context)
        .emitGetAllRepository(page: currentPage);
  }
  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent ||
        totalItemsToShow >= items.length) {
      ++currentPage;
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  void _updateSearchResults(String searchTerm) {
    searchResults = items
        .where((repository) =>
            repository.language
                ?.toLowerCase()
                .startsWith(searchTerm.toLowerCase()) ??
            false)
        .toList();
    setState(() {});
  }
  Widget _buildSearchField() {
    return TextField(
      style: const TextStyle(color: ColorsManager.grey, fontSize: 18),
      controller: _searchController,
      maxLines: 2,
      cursorColor: ColorsManager.grey,
      decoration: const InputDecoration(
        hintText: 'Write your Language To Search ... ',
        border: InputBorder.none,
        hintStyle: TextStyle(color: ColorsManager.grey, fontSize: 18),
      ),
      onChanged: _updateSearchResults,
    );
  }

  List<Widget> _buildAppBarActions() {
    return _isSearching
        ? [
            IconButton(
              onPressed: () {
                _clearSearch();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.clear,
                color: ColorsManager.grey,
              ),
            )
          ]
        : [
            IconButton(
              onPressed: _startSearching,
              icon: const Icon(
                Icons.search,
                color: ColorsManager.grey,
              ),
            )
          ];
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      searchResults.clear();
    });
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print("The selected date is: $selectedDate");
        // Trigger a rebuild of the home page when the date is selected
        BlocProvider.of<CubitRepository>(context)
            .emitGetAllRepository(page: currentPage);
      });
    }
  }

  List<Items> filterRepositoriesByDate(
      List<Items> repositories, DateTime selectedDate) {
    return repositories.where((repository) {
      DateTime? createdAt = repository.createdAt != null
          ? DateTime.tryParse(repository.createdAt!)
          : null;

      if (createdAt != null) {
        // Compare only the date part (without time) of createdAt and selectedDate
        createdAt = DateTime(createdAt.year, createdAt.month, createdAt.day);
        selectedDate =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

        return createdAt.isAtSameMomentAs(selectedDate);
      }

      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButtonWidgetToCheckTheDate(),
      appBar: appbarWidgetContainSearchFromLanguage(),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo is ScrollEndNotification) {
              _scrollListener();
            }
            return true;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                blocBuilderBlocFromRepositiries(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<CubitRepository, RepositoriesState<dynamic>> blocBuilderBlocFromRepositiries() {
    return BlocBuilder<CubitRepository, RepositoriesState>(
                buildWhen: (previous, current) =>
                    current is Loading ||
                    current is Success ||
                    current is Error,
                builder: (context, state) {
                  return state.when(
                    idle: () =>
                        const Center(child: CircularProgressIndicator()),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    success: (repoData) {
                      repositories = repoData;
                      items = [...items, ...repositories.items!];
                      return buildLoadedWidget();
                    },
                    error: (error) => Center(
                      child: Text('${ErrorHandler.handle(error)}'),
                    ),
                  );
                },
              );
  }

  AppBar appbarWidgetContainSearchFromLanguage() {
    return AppBar(
      leading: _isSearching
          ? const BackButton(color: ColorsManager.grey)
          : Container(),
      actions: _buildAppBarActions(),
      automaticallyImplyLeading: false,
      title: _buildSearchField(),
    );
  }

  FloatingActionButton floatingActionButtonWidgetToCheckTheDate() {
    return FloatingActionButton(
        backgroundColor: ColorsManager.blackColor,
        onPressed: () {
          _selectDate();
        },
        child: const Icon(
          Icons.date_range,
          size: 30,
        ));
  }

  Widget buildCharacterList(List<Items> repositoriesToShow) {
    return GridView.builder(
      itemCount: repositoriesToShow.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return RepositoryItem(
          repository: repositoriesToShow[index],
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
    );
  }

  Widget buildLoadedWidget() {
    List<Items> repositoriesToShow = selectedDate != null
        ? filterRepositoriesByDate(items, selectedDate!)
        : items;
    //  show the first 10 items
    repositoriesToShow =
        repositoriesToShow.take(totalItemsToShow).toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          buildCharacterList(repositoriesToShow),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildCustomTextButton(
                  onPressed: () {
                    totalItemsToShow += incrementalValueInButton10Items;
                    if (incrementalValueInButton10Items == 20) {
                      incrementalValueInButton10Items = 10;
                    }
                    BlocProvider.of<CubitRepository>(context)
                        .emitGetAllRepository(page: currentPage);
                  },
                  label: '+10 ',
                ),
                buildCustomTextButton(
                  onPressed: () {
                    totalItemsToShow += incrementalValueInButton50Items;
                    if (incrementalValueInButton50Items == 40) {
                      incrementalValueInButton50Items = 50;
                    }
                    BlocProvider.of<CubitRepository>(context)
                        .emitGetAllRepository(page: currentPage);
                  },
                  label: ' +50 ',
                ),
                buildCustomTextButton(
                  onPressed: () {
                    totalItemsToShow += incrementalValueInButton100Items;
                    if (incrementalValueInButton100Items == 90) {
                      incrementalValueInButton100Items = 100;
                    }
                    BlocProvider.of<CubitRepository>(context)
                        .emitGetAllRepository(page: currentPage);
                  },
                  label: '+100 ',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget buildCustomTextButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:context.screenHeight * 0.02),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return ColorsManager.whiteColor;
            },
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(10),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(color: ColorsManager.blackColor, fontSize: 18),
        ),
      ),
    );
  }
}
