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
    lazy var refreshControl = UIRefreshControl()
    
    lazy var searchBar = UISearchBar()
    lazy var btnSearch = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
    lazy var btnSettings = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(showSettings))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSearchBar()
    }
    
    override func setupUI() {
        navigationItem.rightBarButtonItem = btnSearch
        
        searchBar.rx.cancelButtonClicked.subscribe(onNext: { _ in
            self.hideSearchBar()
        }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked.subscribe(onNext: { _ in
            self.searchBar.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .debounce(.microseconds(2310), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] keyword in
                guard let `self` = self else { return }
                if keyword.count > 3 {
                    self.viewModel.fetchForecast(keyword)
                }
            }).disposed(by: disposeBag)
        
        refreshControl.addTarget(self, action: #selector(onRefreshTable), for: .valueChanged)
        
        tableForecasts.delegate = self
        tableForecasts.register(cellType: ForecastTableViewCell.self)
        tableForecasts.allowsSelection = false
        tableForecasts.refreshControl = refreshControl
        tableForecasts.tableFooterView = UIView(frame: .zero)
    }
    
    override func setupLocalization() {
        title = "Weather Forekast"
        searchBar.placeholder = "Search city for weather forecast"
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
        
        viewModel.refreshingIndicator.subscribe(onNext: { [weak self] isLoading in
            guard let `self` = self else { return }
            isLoading ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
        }).disposed(by: disposeBag)
    }
    
    // MARK: Actions
    @objc func onRefreshTable() {
        viewModel.onPullToRefresh.onNext(())
    }
    
    @objc func showSettings() {
        debugPrint("Settings")
    }
    
    @objc func showSearchBar() {
        navigationItem.rightBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
        navigationItem.titleView = searchBar
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.becomeFirstResponder()
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
