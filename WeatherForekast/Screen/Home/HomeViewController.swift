//
//  HomeViewController.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet weak var tableForecasts: UITableView!
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAtStartup()
    }
    
    override func setupUI() {
        refreshControl.addTarget(self, action: #selector(onRefreshTable), for: .valueChanged)
        
        tableForecasts.delegate = self
        tableForecasts.register(cellType: ForecastTableViewCell.self)
        tableForecasts.allowsSelection = false
        tableForecasts.refreshControl = refreshControl
    }
    
    override func setupLocalization() {
        title = "Weather Forekast"
    }
    
    override func bindViewModel() {
        let input = HomeViewModel.Input()
        let _ = viewModel.transform(input)
        
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
    
    func fetchAtStartup() {
        tableForecasts.contentOffset = CGPoint(x: 0, y: -refreshControl.bounds.height)
        viewModel.onPullToRefresh.onNext(())
    }
    
    @objc func onRefreshTable() {
        viewModel.onPullToRefresh.onNext(())
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
