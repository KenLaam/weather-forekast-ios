//
//  HomeViewController.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet weak var tableForecasts: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    lazy var btnSettings = UIBarButtonItem(title: "SETTINGS_TITLE".localized(), style: .plain, target: self, action: #selector(showSettings))
    
    override func setupUI() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = btnSettings
        setupSearchBar()
        
        tableForecasts.delegate = self
        tableForecasts.register(cellType: ForecastTableViewCell.self)
        tableForecasts.allowsSelection = false
        tableForecasts.tableFooterView = UIView(frame: .zero)
        tableForecasts.toggleErrorBg(ErrorResponse(.empty))
    }
    
    func setupSearchBar() {
        searchBar.rx.cancelButtonClicked.subscribe(onNext: { _ in
            self.searchBar.setShowsCancelButton(false, animated: true)
            self.searchBar.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        searchBar.rx.textDidBeginEditing.subscribe { _ in
            self.searchBar.setShowsCancelButton(true, animated: true)
        }.disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked.subscribe(onNext: { _ in
            self.searchBar.resignFirstResponder()
            self.searchBar.setShowsCancelButton(false, animated: true)
            self.viewModel.fetchForecast(self.searchBar.text)
        }).disposed(by: disposeBag)
    }
    
    override func setupLocalization() {
        title = "APP_NAME".localized()
        btnSettings.title = "SETTINGS_TITLE".localized()
        searchBar.placeholder = "SEARCH_PLACEHOLDER".localized()
    }
    
    override func bindViewModel() {
        viewModel.setupData()
        viewModel.forecast.bind(to: tableForecasts.rx.items) { tableView, row, item in
            let indexPath = IndexPath(row: row, section: 0)
            var cell = tableView.dequeueReusableCell(with: ForecastTableViewCell.self, for: indexPath)
            let cellVM = ForecastCellViewModel(item)
            cell.bindVM(to: cellVM)
            return cell
        }.disposed(by: disposeBag)
        
        viewModel.isLoading.subscribe(onNext: { isLoading in
            self.tableForecasts.toggleLoading(isLoading)
            }).disposed(by: disposeBag)
        
        viewModel.error.subscribe(onNext: { error in
            self.tableForecasts.toggleErrorBg(error)
        }).disposed(by: disposeBag)
    }
    
    // MARK: Actions
    @objc func showSettings() {
        viewModel.openSettings()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
