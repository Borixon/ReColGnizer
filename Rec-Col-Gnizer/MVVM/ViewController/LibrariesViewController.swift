//
//  LibrariesViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 12/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

final class LibrariesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let vm = LibrariesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "Libraries of colours"
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: vm.cellIdentifier)
        tableView.tableFooterView = UIView()
    }
}

extension LibrariesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: vm.cellIdentifier)!
        vm.cellForRow(index: indexPath.row, cell: &cell)
        return cell
    }
}

extension LibrariesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        vm.cellHeight
    }
}
