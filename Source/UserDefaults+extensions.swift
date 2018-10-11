//
//  UserDefaults.swift
//  Localizer
//
//  Created by Vladislav Khambir on 9/8/18.
//  Copyright (c) RxSwiftCommunity
//

extension UserDefaults {
    var currentLanguage: String? {
        get { return string(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
}
