//
//  UITableViewExt.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
    func toggleLoading(_ isLoading: Bool) {
        if isLoading {
            let loadingView = LoadingView(frame: bounds)
            addSubview(loadingView)
        } else {
            for view in subviews where view is LoadingView {
                view.removeFromSuperview()
            }
        }
    }
    
    func toggleErrorBg(_ error: ErrorResponse?) {
        guard let error = error else {
            backgroundView = nil
            return
        }
        let viewError = ErrorView(frame: bounds)
        backgroundView = viewError
        viewError.updateStatus(error)
    }
}
