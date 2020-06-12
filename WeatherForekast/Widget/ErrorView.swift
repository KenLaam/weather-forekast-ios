//
//  ErrorView.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    @IBOutlet weak var lblMessage: UILabel!
    
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
        lblMessage.font = UIFont.preferredFont(forTextStyle: .body)
        lblMessage.numberOfLines = 0
    }
}
