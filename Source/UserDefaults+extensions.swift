//
//  UserDefaults.swift
//  Localizer
//
//  Created by Vladislav Khambir on 9/8/18.
//  Copyright (c) RxSwiftCommunity
//

import Foundation

extension UserDefaults {
    var currentLanguage: String? {
        get { string(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
}
