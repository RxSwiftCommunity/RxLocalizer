//
//  Localizer.swift
//  Localizer
//
//  Created by Vladislav Khambir on 9/8/18.
//  Copyright (c) RxSwiftCommunity
//

import RxSwift
import RxCocoa  

public protocol LocalizerType {
    /// The code of the current language (e.g. en, fr, es)
    var currentLanguageCode: Driver<String?> { get }
    
    /// The code of the current language (e.g. en, fr, es). Use this value for getting the language in a synchronous code.
    var currentLanguageCodeValue: String? { get }
    
    /// Trigger which is used for changing current language. Element is a language code (e.g. en, fr, es).
    var changeLanguage: PublishRelay<String?> { get }
    
    /// Trigger which is used for changing localizer configuration.
    var changeConfiguration: PublishRelay<LocalizerConfig> { get }
    
    /// Localizes the string, using Rx
    ///
    /// - Parameter string: String which will be localized
    /// - Returns: Localized string
    func localized(_ string: String) -> Driver<String>
    
    /// Localizes the string synchronously
    ///
    /// - Parameter string: String which will be localized
    /// - Returns: Localized string
    func localized(_ string: String) -> String
}

public class Localizer: LocalizerType {
    public static let shared: LocalizerType = Localizer()
    
    public let changeLanguage = PublishRelay<String?>()
    public let changeConfiguration = PublishRelay<LocalizerConfig>()
    public let currentLanguageCode: Driver<String?>
    public private(set) var currentLanguageCodeValue: String?
    
    private let localizationBundle = BehaviorRelay<Bundle>(value: .main)
    private let configuration = BehaviorRelay<LocalizerConfig>(value: LocalizerConfig())
    private let disposeBag = DisposeBag()
    
    public func localized(_ string: String) -> Driver<String> {
        return localizationBundle.asDriver().withLatestFrom(configuration.asDriver()) {
            $0.localizedString(forKey: string, value: "Unlocalized String", table: $1.tableName)
        }
    }
    
    public func localized(_ string: String) -> String {
        return localizationBundle.value.localizedString(forKey: string, value: "Unlocalized String", table: configuration.value.tableName)
    }
    
    private init() {
        currentLanguageCode = .combineLatest(changeLanguage.distinctUntilChanged().asDriver(onErrorJustReturn: nil),
                                             configuration.asDriver()) { [localizationBundle] languageCode, configuration in
            configuration.defaults.currentLanguage = languageCode
            localizationBundle.accept(configuration.bundle.path(forResource: languageCode, ofType: "lproj").flatMap(Bundle.init) ?? localizationBundle.value)
            return languageCode
        }
        
        currentLanguageCode.drive(onNext: { [weak self] in self?.currentLanguageCodeValue = $0 }).disposed(by: disposeBag)
        if let currentLanguage = configuration.value.defaults.currentLanguage {
            changeLanguage.accept(currentLanguage)
        } else {
            let preferredLocalization = configuration.value.bundle.preferredLocalizations.first { $0.count < 3 }
            changeLanguage.accept(preferredLocalization ?? Locale.current.languageCode ?? "en")
        }
        changeConfiguration.bind(to: configuration).disposed(by: disposeBag)
    }
}
