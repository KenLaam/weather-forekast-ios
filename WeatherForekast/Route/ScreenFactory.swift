//
//  ScreenFactory.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit

enum Screen {
    case home
    case settings
}

extension Screen {
    func createViewController() -> UIViewController {
        switch self {
        case .home:
            return UIViewController()
        case .settings:
            return UIViewController()
        }
    }
}
