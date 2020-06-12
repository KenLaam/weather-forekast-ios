//
//  SettingsViewModel.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

typealias HandlerUpdateSettings = ((RequestForecast) -> Void)

class SettingsViewModel: BaseViewModel, ViewModelType {
    
    var didFinishUpdateSettings: HandlerUpdateSettings?
    var request = RequestForecast()
    
    init(_ handler: @escaping HandlerUpdateSettings) {
        self.didFinishUpdateSettings = handler
    }
    
    func setupData() {
    }
    
    func updateNumOfDays(_ count: Int) {
        request.count = count
    }
    
    func updateTempUnit(_ unit: TemperatureUnit) {
        request.units = unit
    }
    
    func updateLanguage(_ language: Language) {
        request.lang = language
    }
    
    func backPrevious() {
        Router.shared.pop(true)
    }
    
    func finishSettings() {
        PreferencesService.shared.numOfDays = request.count
        PreferencesService.shared.language = request.lang
        PreferencesService.shared.tempUnit = request.units
        didFinishUpdateSettings?(request)
        backPrevious()
    }
}
