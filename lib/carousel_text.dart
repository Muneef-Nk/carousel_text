import 'dart:async';
import 'package:flutter/material.dart';

/// Different animation types
enum AnimationType { typing, fade, slide }

/// A widget that rotates words with different animation styles
class CarouselText extends StatefulWidget {
  final String fixedText; // Fixed part of the text that does not change
  final List<String> rotatingWords; // Words that will rotate
  final Duration typingSpeed; // Speed of typing animation (per character)
  final Duration eraseSpeed; // Speed of erasing animation (per character)
  final Duration stayDuration; // Time duration before switching words
  final Duration transitionDuration; // Duration for fade/slide transition
  final AnimationType animationType; // Selected animation type
  final TextStyle? fixedTextStyle; // Style for fixed text
  final TextStyle? rotatingTextStyle; // Style for rotating text
  final double spacing; // Space between fixed and rotating text
  final bool loop; // Whether to loop through words continuously
  final bool autoStart; // Whether animation should start automatically

  const CarouselText({
    required this.fixedText,
    required this.rotatingWords,
    this.typingSpeed = const Duration(milliseconds: 100),
    this.eraseSpeed = const Duration(milliseconds: 50),
    this.stayDuration = const Duration(seconds: 2),
    this.transitionDuration = const Duration(milliseconds: 500),
    this.animationType = AnimationType.typing,
    this.fixedTextStyle,
    this.rotatingTextStyle,
    this.spacing = 8.0,
    this.loop = true,
    this.autoStart = true,
  });

  @override
  State<CarouselText> createState() => _CarouselTextState();
}

class _CarouselTextState extends State<CarouselText>
    with SingleTickerProviderStateMixin {
  late int _currentWordIndex; // Index of the currently displayed word
  String _displayedText = ""; // Text displayed in typing animation
  bool _isTyping = true; // Whether typing animation is ongoing
  Timer? _timer; // Timer for managing animation timing
  late AnimationController
  _animationController; // Controls fade and slide animations
  late Animation<double> _fadeAnimation; // Fade transition animation
  late Animation<Offset> _slideAnimation; // Slide transition animation

  @override
  void initState() {
    super.initState();
    _currentWordIndex = 0;

    // Initialize animation controller
    _animationController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );

    // Define fade animation (opacity transition)
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Define slide animation (word moves from bottom to top)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start animation automatically if enabled
    if (widget.autoStart) {
      _startAnimation();
    }
  }

  /// Starts the selected animation type
  void _startAnimation() {
    switch (widget.animationType) {
      case AnimationType.typing:
        _startTyping();
        break;
      case AnimationType.fade:
        _fadeInFadeOut();
        break;
      case AnimationType.slide:
        _slideTransition();
        break;
    }
  }

  /// **Typing Effect: Letter-by-letter reveal**
  void _startTyping() {
    _displayedText = "";
    _isTyping = true;
    _typeNextLetter();
  }

  /// Types each letter one by one
  void _typeNextLetter() {
    final word = widget.rotatingWords[_currentWordIndex];
    _timer = Timer.periodic(widget.typingSpeed, (timer) {
      if (_displayedText.length < word.length) {
        setState(() {
          _displayedText = word.substring(0, _displayedText.length + 1);
        });
      } else {
        timer.cancel();
        _startErasing();
      }
    });
  }

  /// Erases letters one by one before switching to next word
  void _startErasing() {
    _isTyping = false;
    _timer = Timer(widget.stayDuration, () {
      _timer = Timer.periodic(widget.eraseSpeed, (timer) {
        if (_displayedText.isNotEmpty) {
          setState(() {
            _displayedText = _displayedText.substring(
              0,
              _displayedText.length - 1,
            );
          });
        } else {
          timer.cancel();
          _nextWord();
        }
      });
    });
  }

  /// **Fade Animation: Fade in & out before switching words**
  void _fadeInFadeOut() {
    _animationController.forward(); // Fade in
    _timer = Timer(widget.stayDuration, () {
      _animationController.reverse().then((_) {
        _nextWord(); // Fade out then switch word
      });
    });
  }

  /// **Slide Animation: Moves words from bottom to top**
  void _slideTransition() {
    _animationController.forward(from: 0.0);
    _timer = Timer(widget.stayDuration, _nextWord);
  }

  /// **Moves to the next word in the list**
  void _nextWord() {
    setState(() {
      _currentWordIndex = (_currentWordIndex + 1) % widget.rotatingWords.length;
    });

    // Restart animation if looping is enabled
    if (widget.loop || _currentWordIndex < widget.rotatingWords.length) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Fixed text
        Text(widget.fixedText, style: widget.fixedTextStyle),
        SizedBox(width: widget.spacing),
        _buildAnimatedText(),
      ],
    );
  }

  /// **Builds the animated text widget based on selected animation type**
  Widget _buildAnimatedText() {
    switch (widget.animationType) {
      case AnimationType.typing:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_displayedText, style: widget.rotatingTextStyle),
            if (_isTyping)
              Text(
                "|",
                style: widget.rotatingTextStyle,
              ), // Blinking cursor effect
          ],
        );

      case AnimationType.fade:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            widget.rotatingWords[_currentWordIndex],
            style: widget.rotatingTextStyle,
          ),
        );

      case AnimationType.slide:
        return SlideTransition(
          position: _slideAnimation,
          child: Text(
            widget.rotatingWords[_currentWordIndex],
            style: widget.rotatingTextStyle,
          ),
        );
    }
  }
}
