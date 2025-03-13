# CarouselText

CarouselText is a customizable animated text widget for Flutter applications. It allows you to rotate words dynamically using different animations like typing, fading, and sliding effects.

## 📌 Features
- 🎨 **Multiple animation types**: Typing, Fade, Slide
- ⏳ **Customizable animation speeds**
- 🔄 **Looping support**
- 🛠️ **Easy to integrate**
- ✅ **Configurable spacing, styles, and durations**

## 🚀 Installation
Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  carousel_word: ^1.0.0
```

Then, run:
```sh
flutter pub get
```

## 🔥 Usage
Import the package and use `CarouselText`:

```dart
CarouselText(
    fixedText: "Flutter is",
    rotatingWords: ["Awesome!", "Fast!", "Powerful!"],
    animationType: AnimationType.typing, // Choose: typing, fade, slide
    fixedTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    rotatingTextStyle: TextStyle(fontSize: 24, color: Colors.blueAccent),
);
```

## 🎭 Animation Types
You can choose between different animation styles:
- `AnimationType.typing` - Letter-by-letter typing effect
- `AnimationType.fade` - Fade in and out effect
- `AnimationType.slide` - Slide up transition effect

## ⚙️ Customization Options
| Parameter           | Type                  | Default Value | Description |
|--------------------|----------------------|--------------|-------------|
| `fixedText`       | `String`              | Required     | The static text before the rotating words. |
| `rotatingWords`   | `List<String>`        | Required     | Words to rotate with animation. |
| `animationType`   | `AnimationType`       | `typing`     | Animation style: `typing`, `fade`, `slide`. |
| `typingSpeed`     | `Duration`            | 100ms        | Speed for typing effect. |
| `eraseSpeed`      | `Duration`            | 50ms         | Speed for erasing effect. |
| `stayDuration`    | `Duration`            | 2s           | Duration each word stays before transition. |
| `transitionDuration` | `Duration`         | 500ms        | Duration of fade/slide transitions. |
| `loop`            | `bool`                | `true`       | Whether the animation loops infinitely. |
| `autoStart`       | `bool`                | `true`       | Whether animation starts automatically. |



## Bugs
If you encounter any problems, feel free to open an issue.


## Credits  
CarouselText is developed and maintained by [Muneef Nk](https://github.com/Muneef-Nk/).
