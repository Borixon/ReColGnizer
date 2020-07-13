//
//  FavoriteViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class FavouriteViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoScreen: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var vm = FavouriteViewModel()
    var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        
        vm.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.addDataDelegate()
        vm.refreshData()
        infoLabel.text = vm.infoText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        vm.removeDataDelegate()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: vm.nibName, bundle: Bundle.main), forCellReuseIdentifier: vm.cellIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    internal func setupSearchBar() {
        let searchBar = (navigationController as? NavigationController)?.searchBar
        searchBar?.delegate = self
        searchBar?.placeholder = vm.placeholder
        
        let sortingItem = (navigationController as? NavigationController)?.sortingItem
        sortingItem?.action = #selector(sortColours)
        sortingItem?.target = self
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = sortingItem
    }
    
    @objc private func searchColours() {
        setupSearchBar()
    }
    
    @objc private func sortColours() {
        coordinator?.openSortingView(withTypeSelected: vm.sortingType, delegate: self)
    }
}

extension FavouriteViewController: FavouriteViewModelDelegate {
    func refreshData() {
        if vm.colorArrayIsEmpty {
            tableView.isHidden = true
            infoScreen.isHidden = false
        } else {
            tableView.isHidden = false
            infoScreen.isHidden = true
        }
        tableView.reloadData()
    }
    
    func openColor(_ color: ColorModel) {
        coordinator?.openColorData(data: color)
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellIdentifier) as! ColorCell
        if let data = vm.data(forIndex: indexPath.row) {
            cell.setup(label1: data.label1, label2: data.label2, color: data.colour)
        }
        return cell
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ColorCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.getColorModel(forIndex: indexPath.row)
    }
}

extension FavouriteViewController: SortingViewDelegate {
    func didSelect(sortingType: SortingType) {
        vm.setSorting(sortingType)
    }
}
