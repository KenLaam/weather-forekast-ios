//
//  ForecastTableViewCell.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit

class ForecastTableViewCell: BaseTableViewCell<ForecastCellViewModel> {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imvIcon: UIImageView!
    
    override func setupUI() {
        [lblDate, lblTemp, lblPressure, lblHumidity, lblDescription].forEach {
            $0?.numberOfLines = 0
            $0?.font = UIFont.preferredFont(forTextStyle: .body)
        }
    }
    
    override func bindViewModel() {
        viewModel.setupData()
        viewModel.date.bind(to: lblDate.rx.text).disposed(by: disposeBag)
        viewModel.temp.bind(to: lblTemp.rx.text).disposed(by: disposeBag)
        viewModel.pressure.bind(to: lblPressure.rx.text).disposed(by: disposeBag)
        viewModel.humidity.bind(to: lblHumidity.rx.text).disposed(by: disposeBag)
        viewModel.description.bind(to: lblDescription.rx.text).disposed(by: disposeBag)
        viewModel.icon.bind(to: imvIcon.rx.imageURL).disposed(by: disposeBag)
    }
    
}
