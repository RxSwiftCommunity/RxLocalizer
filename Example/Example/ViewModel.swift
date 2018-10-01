//
//  ViewModel.swift
//  Example
//
//  Created by Vladislav on 9/30/18.
//  Copyright © 2018 MLSDev. All rights reserved.
//

import RxCocoa
import RxLocalizer
import RxSwift

protocol ViewModelType {
    var localizedText: Driver<String> { get }
    var changeLanguageTrigger: PublishRelay<String> { get }
}

class ViewModel: ViewModelType {
    let localizedText: Driver<String>
    let changeLanguageTrigger = PublishRelay<String>()
    
    private let disposeBag = DisposeBag()
    
    public init(localizer: LocalizerType) {
        localizedText = localizer.localized("testString")
        changeLanguageTrigger.bind(to: localizer.changeLanguage).disposed(by: disposeBag)
    }
}
