//
//  AppUtils.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

class AppUtils {
    static func currentLanguageCode() -> String {
        if let code = Locale.current.languageCode {
            switch code {
            case "vi":
                return code
            default:
                return AppConfiguration.DEFAULT_LANGUAGE_CODE
            }
        }
        return AppConfiguration.DEFAULT_LANGUAGE_CODE
    }
}
