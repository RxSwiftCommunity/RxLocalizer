//
//  Localizer.swift
//  Localizer
//
//  Created by Vladislav on 9/8/18.
//  Copyright © 2018 MLSDev. All rights reserved.
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
    
    /// Localizes the string
    ///
    /// - Parameter string: String which will be localized
    /// - Returns: Localized string
    func localized(_ string: String) -> Driver<String>
}

public class Localizer: LocalizerType, ReactiveCompatible {
    public static let shared: LocalizerType = Localizer()
    
    public let changeLanguage = PublishRelay<String?>()
    public let changeConfiguration = PublishRelay<LocalizerConfig>()
    public let currentLanguageCode: Driver<String?>
    public private(set) var currentLanguageCodeValue: String?
    
    private var localizationBundle: Bundle
    
    private let _configuration = BehaviorRelay<LocalizerConfig>(value: LocalizerConfig())
    private let _currentLanguage = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()
    
    public func localized(_ string: String) -> Driver<String> {
        return currentLanguageCode.asDriver().map { [weak self] _ in
            guard let self = self else { return "" }
            return self.localizationBundle.localizedString(forKey: string, value: "Unlocalized String", table: self._configuration.value.tableName)
        }
    }
    
    private init() {
        localizationBundle = _configuration.value.bundle
        currentLanguageCode = _currentLanguage.asDriver(onErrorJustReturn: nil)
        changeLanguage.asDriver(onErrorJustReturn: nil).drive(onNext: { [weak self] in
            self?._configuration.value.defaults.currentLanguage = $0
            if let localizationBundle = self?._configuration.value.bundle.path(forResource: $0, ofType: "lproj").flatMap(Bundle.init) {
                self?.localizationBundle = localizationBundle
            }
            self?._currentLanguage.accept($0)
        }).disposed(by: disposeBag)
        
        currentLanguageCode.drive(onNext: { [weak self] in self?.currentLanguageCodeValue = $0 }).disposed(by: disposeBag)
        if let currentLanguage = _configuration.value.defaults.currentLanguage {
            changeLanguage.accept(currentLanguage)
        } else {
            let preferredLocalization = _configuration.value.bundle.preferredLocalizations.filter { $0.count < 3 }.first
            changeLanguage.accept(preferredLocalization ?? "")
        }
        changeConfiguration.bind(to: _configuration).disposed(by: disposeBag)
    }
}
