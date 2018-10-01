# RxLocalizer

RxLocalizer is a framework written in swift which allows you to localize your apps, using RxSwift.

## Requirements

- Xcode 10
- Swift 4.2
- iOS 10+

## Installation

### CocoaPods

```ruby
pod 'RxLocalizer'
```

## Usage

### Before all:

```swift
import RxLocalizer
```

### Reactive localized strings

```swift
Localizer.shared.localized("Start")
  .drive(startLabel.rx.text)
  .disposed(by: disposeBag)
```

### Change language

You are able to set language by language code. 
A full list of the codes you can check [here](https://www.ibabbleon.com/iOS-Language-Codes-ISO-639.html).
```swift
Localizer.shared.changeLanguage.accept("en")
```

### Change RxLocalizer configuration

You are able to change default configuration, using `changeConfiguration` property.

```swift
let localizerConfig = LocalizerConfig(defaults: .standard, bundle: .main, tableName: "Localizable")
Localizer.shared.changeConfiguration.accept(localizerConfig)
```

