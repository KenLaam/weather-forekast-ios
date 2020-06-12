//
//  Date+Converter.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

extension Date {
    func toString(_ format: String = AppConfiguration.DEFAULT_DATE_FORMAT) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: PreferencesService.shared.language.rawValue)
        return formatter.string(from: self)
    }
}
