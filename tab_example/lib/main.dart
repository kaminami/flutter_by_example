import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(
  onUnknownRoute: (_) => const Redirect('/tab'),
  routes: {
    // tab root
    '/tab': (_) => const TabPage(
          child: MyHomePage(
            title: 'home',
          ),
          paths: ['feed', 'settings'],
        ),

    // tab page
    '/tab/feed': (_) => const MaterialPage(child: FeedPage()),
    '/tab/settings': (_) => const MaterialPage(child: SettingsPage()),

    // not tab page
    '/profile/:id': (info) => MaterialPage(child: ProfilePage(id: info.pathParameters['id'] ?? 'no id')),
  },
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (_) => routes,
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);

    final tabBarView = TabBarView(
      controller: tabPage.controller,
      children: [
        for (final stack in tabPage.stacks) PageStackNavigator(stack: stack),
      ],
    );

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: const Icon(Icons.tab),
              floating: true,
              pinned: true,
              snap: true,
              title: const Text('Tab Example'),
              centerTitle: false,
              bottom: TabBar(
                controller: tabPage.controller,
                tabs: const <Widget>[
                  Tab(child: Text('Feed')),
                  Tab(child: Text('Settings')),
                ],
              ),
            )
          ];
        },
        body: tabBarView,
      ),
    );
  }
}

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('FeedPage'),
        ElevatedButton(
          onPressed: () {
            const String id = '111223';
            Routemaster.of(context).push('/profile/$id');
          },
          child: const Text('goto Profile'),
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('SettingsPage');
  }
}

class ProfilePage extends StatelessWidget {
  final String id;

  const ProfilePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final listView = ListView(
      children: [
        Text('ProfilePage $id'),
      ],
    );

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (ctx, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Routemaster.of(ctx).replace('/tab/feed');
                },
              ),
              floating: true,
              snap: true,
              title: const Text('Profile'),
              centerTitle: false,
            ),
          ];
        },
        body: listView,
      ),
    );
  }
}
