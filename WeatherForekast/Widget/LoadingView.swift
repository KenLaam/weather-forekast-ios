//
//  LoadingView.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    func configUI() {
        let nib = UINib(nibName: className, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        addSubview(view)
        self.backgroundColor = .clear
        viewContainer.layer.cornerRadius = 10
        viewContainer.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
        activityIndicator.style = .whiteLarge
    }
}
