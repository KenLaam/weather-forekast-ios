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
    
    lazy var searchBar = UISearchBar()
    lazy var btnSearch = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
    lazy var btnSettings = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showSettings))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        navigationItem.rightBarButtonItem = btnSettings
        navigationItem.leftBarButtonItem = btnSearch
        
        searchBar.rx.cancelButtonClicked.subscribe(onNext: { _ in
            self.hideSearchBar()
        }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked.subscribe(onNext: { _ in
            self.searchBar.resignFirstResponder()
            self.viewModel.fetchForecast(self.searchBar.text)
        }).disposed(by: disposeBag)
        
        tableForecasts.delegate = self
        tableForecasts.register(cellType: ForecastTableViewCell.self)
        tableForecasts.allowsSelection = false
        tableForecasts.tableFooterView = UIView(frame: .zero)
    }
    
    override func setupLocalization() {
        title = "Weather Forekast".localized()
        searchBar.placeholder = "Search city".localized()
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
    
    @objc func showSearchBar() {
        navigationItem.rightBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
        navigationItem.titleView = searchBar
        searchBar.setShowsCancelButton(true, animated: false)
        searchBar.alpha = 0.0
        UIView.animate(withDuration: 0.23, animations: {
            self.searchBar.alpha = 1.0
        }) { finshed in
            self.searchBar.becomeFirstResponder()
        }
    }
    
    @objc func hideSearchBar() {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = btnSettings
        navigationItem.leftBarButtonItem = btnSearch
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
