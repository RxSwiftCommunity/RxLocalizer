//
//  ViewModel.swift
//  Example
//
//  Created by Vladislav Khambir on 9/30/18.
//  Copyright (c) RxSwiftCommunity
//

import RxCocoa
import RxLocalizer
import RxSwift

protocol ViewModelType {
    var localizedText: Driver<String> { get }
    var localizedText2: Driver<String> { get }
    var changeLanguageTrigger: PublishRelay<String> { get }
}

class ViewModel: ViewModelType {
    let localizedText: Driver<String>
    let localizedText2: Driver<String>
    let changeLanguageTrigger = PublishRelay<String>()
    
    private let disposeBag = DisposeBag()
    
    public init(localizer: LocalizerType) {
        localizedText = localizer.localized("testString")
        localizedText2 = localizer.localized("testString2", arguments: "1", "0")
        changeLanguageTrigger.bind(to: localizer.changeLanguage).disposed(by: disposeBag)
    }
}
