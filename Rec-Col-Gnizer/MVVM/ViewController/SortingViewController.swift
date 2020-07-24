//
//  SortingViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 17/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol SortingViewDelegate {
    func didSelect(sortingType: SortingType) 
}

final class SortingViewController: BaseViewController {
  
    @IBOutlet weak var tableView: UITableView!
    var delegate: SortingViewDelegate? = nil
    var vm = SortingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SortingCell", bundle: Bundle.main), forCellReuseIdentifier: vm.cellIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Set sorting"
    }
    
    public func setCurrent(sortingType: SortingType) {
        vm.selectedSortingType = sortingType
    }
}

extension SortingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellIdentifier) as? SortingCell else {
            fatalError("Cell not implemented")
        }
        cell.setup(name: vm.elementFor(index: indexPath.row)?.rawValue, selected: vm.isSelectedIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfElements
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Style.cellHeightRegular
    }
}

extension SortingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = vm.elementFor(index: indexPath.row) else { return }
        delegate?.didSelect(sortingType: type)
        coordinator?.dismissViewController()
    }
}
