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
    case settings(_ handler: HandlerUpdateSettings)
}

extension Screen {
    func createViewController() -> UIViewController {
        var vc = UIViewController()
        switch self {
        case .home:
            if var homeVC = UIUtils.getViewController(with: HomeViewController.className, in: .main) as? HomeViewController {
                homeVC.bindVM(to: HomeViewModel())
                let nav = UINavigationController(rootViewController: homeVC)
                vc = nav
            }
        case .settings(let handler):
            if var settingsVC = UIUtils.getViewController(with: SettingsViewController.className, in: .main) as? SettingsViewController {
                settingsVC.bindVM(to: SettingsViewModel(handler))
                vc = settingsVC
            }
        @unknown default:
            break
        }
        return vc
    }
}
