//
//  FlightSearchResultsListViewController.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

final class FlightSearchResultsListViewController: UIViewController {

    @IBOutlet private weak var navigationBarExtendedView: UIView!
    @IBOutlet private weak var resultsCountLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    private var activityIndicatorView: NVActivityIndicatorView!

    private var viewModels: [FlightSearchResultViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var presenter: FlightSearchResultsListPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setUpActivityIndicator()
        tableView.dataSource = self
        presenter.viewDidLoad()
    }

    private func setUpNavigationBar() {
        navigationItem.titleView = titleView(firstLine: presenter.queryPlaces, secondLine: presenter.queryDates)
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(5, for: .default)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_action_share"), style: .plain, target: nil, action: nil)

        navigationController?.navigationBar.shadowImage = UIImage.from(color: .clear)

        let layer = navigationBarExtendedView.layer
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3

        resultsCountLabel.text = nil
        sortButton.setTitle("Sort", for: .normal)
        filterButton.setTitle("Filter", for: .normal)
        [sortButton, filterButton].forEach { $0?.setTitleColor(.turquoiseBlue, for: .normal) }
    }

    private func titleView(firstLine: String, secondLine: String) -> UIView {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let title = NSMutableAttributedString(string: firstLine,
                                              attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                                                           .foregroundColor: UIColor.darkGray,
                                                           .paragraphStyle: paragraphStyle])
        let subtitle = NSAttributedString(string: "\n" + secondLine,
                                          attributes: [.font: UIFont.systemFont(ofSize: 12),
                                                       .foregroundColor: UIColor.lightGray,
                                                       .paragraphStyle: paragraphStyle])
        title.append(subtitle)

        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = title
        return label
    }

    private func setUpActivityIndicator() {
        let frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .lineScale, color: .turquoiseBlue)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.frame.size.height = 64
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
}

extension FlightSearchResultsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FlightSearchResultTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}

extension FlightSearchResultsListViewController: FlightSearchResultsListViewProtocol {

    func showNoResultsYet() {
        print("No results yet")
    }

    func showResults(_ viewModels: [FlightSearchResultViewModel], totalCount: String) {
        resultsCountLabel.text = totalCount
        self.viewModels = viewModels
    }

    func showLoadingSpinner() {
        activityIndicatorView.startAnimating()
    }

    func hideLoadingSpinner() {
        activityIndicatorView.stopAnimating()
    }

    func showError() {
        print("Error")
    }
}
