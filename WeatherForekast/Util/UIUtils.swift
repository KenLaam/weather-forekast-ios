//
//  UIUtils.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit

class UIUtils {
    static func getViewController(with id: String? = nil, in storyboard: UIStoryboard) -> UIViewController? {
        if let id = id {
            return storyboard.instantiateViewController(withIdentifier: id)
        }
        return storyboard.instantiateInitialViewController()
    }
}
