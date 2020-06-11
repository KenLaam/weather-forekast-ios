//
//  PreferencesService.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

class PreferencesService: NSObject {
    private override init() {}
    
    static let shared = PreferencesService()
    private let userDefaults = UserDefaults.standard
    
    private let kLang = "language"
    
    var langCode: String {
        get {
            return getData(kLang) ?? AppUtils.currentLanguageCode()
        }
        set {
            saveData(key: kLang, value: newValue)
        }
    }
    
    func clear() {
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    // MARK: Serializer
    private func getData<T>(_ key: String) -> T? {
        return userDefaults.object(forKey: key) as? T
    }
    
    // MARK: De-serializer
    private func saveData(key: String, value: Any) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
}
