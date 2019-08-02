//
//  ViewController.swift
//  Example
//
//  Created by Vladislav Khambir on 9/30/18.
//  Copyright (c) RxSwiftCommunity
//

import RxLocalizer
import RxSwift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var localizedLabel: UILabel!
    @IBOutlet weak var localizedLabel2: UILabel!
    @IBOutlet weak var urkaineButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var italianButton: UIButton!
    
    let localizer = Localizer.shared
    let disposeBag = DisposeBag()
    let viewModel: ViewModelType = ViewModel(localizer: Localizer.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.merge(
            urkaineButton.rx.tap.map { Language.ukrainian.rawValue },
            englishButton.rx.tap.map { Language.english.rawValue },
            italianButton.rx.tap.map { Language.italian.rawValue }
        ).bind(to: viewModel.changeLanguageTrigger).disposed(by: disposeBag)
        
        viewModel.localizedText.drive(localizedLabel.rx.text).disposed(by: disposeBag)
        viewModel.localizedText2.drive(localizedLabel2.rx.text).disposed(by: disposeBag)
    }
}
