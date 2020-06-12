//
//  SettingsViewController.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: BaseViewController<SettingsViewModel> {
    
    @IBOutlet weak var lblNumOfDays: UILabel!
    @IBOutlet weak var sliderNumOfDays: UISlider!
    @IBOutlet weak var lblLang: UILabel!
    @IBOutlet weak var segmentLanguage: UISegmentedControl!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var segmentTemp: UISegmentedControl!
    
    override func setupUI() {
        let btnBack = UIBarButtonItem(title: "BTN_BACK".localized(), style: .plain, target: self, action: #selector(didTapBack))
        navigationItem.leftBarButtonItem = btnBack
        let btnDone = UIBarButtonItem(title: "BTN_DONE".localized(), style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = btnDone
        
        [lblNumOfDays, lblLang, lblTemp].forEach {
            $0?.numberOfLines = 0
            $0?.font = UIFont.preferredFont(forTextStyle: .body)
        }
        setupSliderNumOfDays()
        setupSegmentLanguage()
        setupSegmentUnit()
    }
    
    func setupSliderNumOfDays() {
        sliderNumOfDays.minimumValue = Float(AppConfiguration.FORECAST_DAYS_MIN)
        sliderNumOfDays.maximumValue = Float(AppConfiguration.FORECAST_DAYS_MAX)
        sliderNumOfDays.value = Float(PreferencesService.shared.numOfDays)
        
        sliderNumOfDays.rx.value.map {
            Int($0)
        }.subscribe(onNext: { value in
            self.sliderNumOfDays.value = Float(value)
            self.viewModel.updateNumOfDays(value)
        }).disposed(by: disposeBag)
        sliderNumOfDays.rx.value.map {
            "SETTINGS_NO_DAYS".localizedFormat(Int($0))
        }.bind(to: lblNumOfDays.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    func setupSegmentLanguage() {
        let languages: [Language] = [.english, .vietnamese]
        segmentLanguage.removeAllSegments()
        for (index, lang) in languages.enumerated() {
            segmentLanguage.insertSegment(withTitle: lang.name, at: index, animated: false)
            if viewModel.request.lang == lang {
                segmentLanguage.selectedSegmentIndex = index
            }
        }
        segmentLanguage.rx.value.map {
            languages[$0]
        }.subscribe(onNext: { lang in
            self.viewModel.updateLanguage(lang)
        }).disposed(by: disposeBag)
    }
    
    func setupSegmentUnit() {
        let units: [TemperatureUnit] = [.celsius, .fahrenheit, .kelvin]
        segmentTemp.removeAllSegments()
        for (index, unit) in units.enumerated() {
            segmentTemp.insertSegment(withTitle: unit.name, at: index, animated: false)
            if viewModel.request.units == unit {
                segmentTemp.selectedSegmentIndex = index
            }
        }
        segmentTemp.rx.value.map {
            units[$0]
        }.subscribe(onNext: { unit in
            self.viewModel.updateTempUnit(unit)
        }).disposed(by: disposeBag)
    }
    
    override func setupLocalization() {
        title = "SETTING_TITLE".localized()
        lblLang.text = "SETTINGS_LANG".localized()
        lblTemp.text = "SETTINGS_TEMP_UNIT".localized()
    }
    
    override func bindViewModel() {
        viewModel.setupData()
    }
    
    @objc func didTapBack() {
        viewModel.backPrevious()
    }
    
    @objc func didTapDone() {
        viewModel.finishSettings()
    }
}
