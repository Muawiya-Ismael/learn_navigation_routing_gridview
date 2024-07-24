
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: HomeScreen(),
      routes:{
        "/movies": (context)=>  const MoviePage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Todo> todos =  List.generate(
      5,
          (i) => Todo(
        'Todo $i',
        'A description of what needs to be done for Todo $i',
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen."),
      ),
      drawer: Drawer(
        child:ListView(
          children: [
            DrawerHeader(
              decoration:const BoxDecoration(
                color: Color(0xFFD0BCFE),
              ),
              child: Text('ToDo', style: TextStyle(color:Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 28),textAlign:TextAlign.left,),
            ),

            SizedBox(
              height: double.maxFinite,
              child: ListView.builder(
                itemCount:todos.length ,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(todos[index].title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailScreen(),
                          settings: RouteSettings(
                            arguments: todos[index],
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            )

          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectionButton(),
            MoviesButton(),
          ],
        ),
      ),

    );
  }
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({super.key});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Pick an option, any option!'),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    if (!context.mounted) return;


    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('${result?? "Back Arrow"}',style: TextStyle(color:Theme.of(context).dialogBackgroundColor,fontSize: 30,fontWeight: FontWeight.bold),),backgroundColor: const Color(0xFFD0BCFE),));

  }
}


class MoviesButton extends StatefulWidget {
  const MoviesButton({super.key});

  @override
  State<MoviesButton> createState() => _MoviesButton();
}

class _MoviesButton extends State<MoviesButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        _navigateAndDisplayMovies(context);
      },
      child: const Text('Movies'),
    );
  }

  Future<void> _navigateAndDisplayMovies(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
     await Navigator.pushNamed(context, "/movies");

  }
}



class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const  BackButton(
          color:  Color(0xFFD0BCFE),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () => {Navigator.pop(context, 'Yep!')},
              child: const Text("Yep!"),
            ),

            FilledButton(
              onPressed: () => {Navigator.pop(context, 'Nope.')},
              child: const Text("Nope."),
            ),
          ],
        ),
      ),
    );
  }
}



class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}


class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}



class Movie{
  final String name;
  final double rating;
  final String description;
  const Movie(this.name, this.rating,this.description);
}

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  final List<Movie> movies = const [
    Movie('The Shawshank Redemption', 9.3, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.'),
    Movie('The Godfather', 9.2, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.'),
    Movie('The Dark Knight', 9.0, 'When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.'),
    Movie('12 Angry Men', 9.0, 'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.'),
    Movie('Schindler\'s List', 8.9, 'In German-occupied Poland during World War II, Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.'),
    Movie('The Lord of the Rings: The Return of the King', 8.9, 'Gandalf and Aragorn lead the World of Men against Sauron\'s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.'),
    Movie('Pulp Fiction', 8.9, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.'),
    Movie('The Good, the Bad and the Ugly', 8.8, 'A bounty hunting scam joins two men in an uneasy alliance against a third in a race to find a fortune in gold buried in a remote cemetery.'),
    Movie('Fight Club', 8.8, 'An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into much more.'),
    Movie('Forrest Gump', 8.8, 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12,25,12,8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: movies.length,
          itemBuilder: (context,index){
            return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MovieDetailScreen(),
                      settings: RouteSettings(
                        arguments: movies[index],
                      ),
                    ),
                  );
                },
              child: GridTile(
                header: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(movies[index].name, style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                footer: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("${movies[index].rating}", style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD0BCFE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
            );
          },

        ),
      ),
    );
  }
}

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    // Use the Movie to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                movie.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFFD0BCFE),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "${movie.rating}",
              style: const TextStyle(
                color: Color(0xFFD0BCFE),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          movie.description,
          style: const TextStyle(
            color: Color(0xFFD0BCFE),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}




