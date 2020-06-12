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
    
    private let kNumOfDays = "number of days"
    private let kLang = "language"
    private let kTemperatureUnit = "temperature unit"
    
    var language: Language {
        get {
            return getData(kLang) ?? AppConfiguration.DEFAULT_LANGUAGE
        }
        set {
            saveData(key: kLang, value: newValue)
        }
    }
    
    var numOfDays: Int {
        get {
            return getData(kNumOfDays) ?? AppConfiguration.FORECAST_DAYS_DEFAULT
        }
        
        set {
            return saveData(key: kNumOfDays, value: newValue)
        }
    }
    
    var tempUnit: TemperatureUnit {
        get {
            return getData(kTemperatureUnit) ?? AppConfiguration.DEFAULT_TEMP_UNIT
        }
        set {
            saveData(key: kTemperatureUnit, value: newValue)
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
