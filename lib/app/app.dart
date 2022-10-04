import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blue[300],
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.blue[300],
        useMaterial3: true,
      ),
      home: const CircleAnimated(),
    );
  }
}

class CircleAnimated extends StatefulWidget {
  const CircleAnimated({
    Key? key,
  }) : super(key: key);

  @override
  State<CircleAnimated> createState() => _CircleAnimatedState();
}

class _CircleAnimatedState extends State<CircleAnimated>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationControllerTwo;
  late AnimationController _animationControllerThree;

  late Animation _sizeAnimated;
  late Animation _sizeAnimatedTwo;
  late Animation _sizeAnimatedThree;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..forward()
      ..repeat();

    _animationControllerTwo = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..forward()
      ..repeat();

    _animationControllerThree = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..forward()
      ..repeat();

    _sizeAnimated = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: Tween(begin: 100, end: 140), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 140, end: 180), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 180, end: 140), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 140, end: 100), weight: 1),
      ],
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.6),
      ),
    );

    _sizeAnimatedTwo = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: Tween(begin: 100, end: 140), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 140, end: 180), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 180, end: 220), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 220, end: 180), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 180, end: 140), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 140, end: 100), weight: 1),
      ],
    ).animate(
      CurvedAnimation(
        parent: _animationControllerTwo,
        curve: const Interval(0.2, 0.8),
      ),
    );
    _sizeAnimatedThree = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: Tween(begin: 100, end: 140), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 140, end: 180), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 180, end: 220), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 220, end: 260), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 260, end: 220), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 220, end: 180), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 180, end: 140), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 140, end: 100), weight: 1),
      ],
    ).animate(
      CurvedAnimation(
        parent: _animationControllerThree,
        curve: const Interval(0.1, 1),
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });
    _animationControllerTwo.addListener(() {
      setState(() {});
    });
    _animationControllerThree.addListener(() {
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationControllerTwo.forward();
        _animationControllerThree.forward();
      }
    });

    _animationControllerTwo.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward();
        _animationControllerThree.forward();
      }
    });
    _animationControllerThree.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward();
        _animationControllerTwo.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllerTwo.dispose();
    _animationControllerThree.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('R E L O J'),
        titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, fontSize: 26),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.blue[300],
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, animated) {
                return Container(
                  height: _sizeAnimated.value,
                  width: _sizeAnimated.value,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: animated,
                );
              },
            ),
            AnimatedBuilder(
              animation: _animationControllerTwo,
              builder: (context, animatedTwo) {
                return Container(
                  height: _sizeAnimatedTwo.value,
                  width: _sizeAnimatedTwo.value,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: animatedTwo,
                );
              },
            ),
            AnimatedBuilder(
              animation: _animationControllerThree,
              builder: (context, animatedThree) {
                return Container(
                  height: _sizeAnimatedThree.value,
                  width: _sizeAnimatedThree.value,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: animatedThree,
                );
              },
            ),
            DecoratedBox(
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.white,
              ),
              child: TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.alarm_add_rounded,
                  size: 100,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
