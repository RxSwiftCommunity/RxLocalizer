//
//  UserDefaults.swift
//  Localizer
//
//  Created by Vladislav on 9/8/18.
//  Copyright © 2018 MLSDev. All rights reserved.
//

extension UserDefaults {
    var currentLanguage: String? {
        get { return string(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
}
