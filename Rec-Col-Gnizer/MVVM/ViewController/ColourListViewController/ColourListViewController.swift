//
//  ColourListViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

final class ColourListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoScreen: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var vm: ColourListViewModelProtocol!
    var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFavouriteDelegate()
        tableView.reloadData()
        infoLabel.text = vm.infoText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        releaseFavouriteDelegate()
    }
    
    private func setupFavouriteDelegate() {
        if let favVm = vm.data as? FavouriteListData {
            favVm.delegate = self
        }
    }
    
    private func releaseFavouriteDelegate() {
        if let favVm = vm.data as? FavouriteListData {
            favVm.delegate = nil
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: vm.nibName, bundle: Bundle.main), forCellReuseIdentifier: vm.cellIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    public func setupFavouriteSearchBar() {
        let searchBar = (navigationController as? NavigationController)?.searchBar
        searchBar?.delegate = self
        searchBar?.placeholder = vm.placeholder
        
        let sortingItem = (navigationController as? NavigationController)?.sortingItem
        sortingItem?.action = #selector(sortColours)
        sortingItem?.target = self
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = sortingItem
    }
    
    @objc private func sortColours() {
        coordinator?.openSortingView(withTypeSelected: vm.sortingType, delegate: self)
    }
}

extension ColourListViewController: FavouriteListDataDelegate {
    func dataHasChanged() {
        tableView.reloadData()
    }
}

extension ColourListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellIdentifier) as! ColorCell
        if let data = vm.data(forIndex: indexPath.row) {
            cell.setup(label1: data.label1, label2: data.label2, color: data.colour)
        }
        return cell
    }
}

extension ColourListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ColorCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.getColorModel(forIndex: indexPath.row, completion: { model in
            guard let model = model else { return }
            self.coordinator?.openColorData(data: model)
        })
    }
}

extension ColourListViewController: SortingViewDelegate {
    func didSelect(sortingType: SortingType) {
        vm.setSorting(sortingType, completion: {
            if self.vm.colorArrayIsEmpty {
                self.tableView.isHidden = true
                self.infoScreen.isHidden = false
            } else {
                self.tableView.isHidden = false
                self.infoScreen.isHidden = true
            }
            self.tableView.reloadData()
        })
    }
}
