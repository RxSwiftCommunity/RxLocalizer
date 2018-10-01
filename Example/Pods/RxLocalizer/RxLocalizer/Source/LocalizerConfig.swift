//
//  LocalizerConfig.swift
//  Localizer
//
//  Created by Vladislav on 9/29/18.
//  Copyright © 2018 MLSDev. All rights reserved.
//

public struct LocalizerConfig {
    let defaults: UserDefaults
    let tableName: String
    let bundle: Bundle

    /// Creates an config for the Localizer
    ///
    /// - Parameters:
    ///   - defaults: User defaults in which Localizer will store current localization. Default value is UserDefaults.standard.
    ///   - bundle: App bundle. Default value is Bundle.main.
    ///   - tableName: The receiver’s string table to search. Default value is Localizable.
    public init(defaults: UserDefaults = .standard, bundle: Bundle = .main, tableName: String = "Localizable") {
        self.defaults = defaults
        self.bundle = bundle
        self.tableName = tableName
    }
}
