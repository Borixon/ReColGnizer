//
//  FavoriteViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let vm = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.refreshData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ColorCell", bundle: Bundle.main), forCellReuseIdentifier: vm.cellIdentifier)
    }

}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellIdentifier) as! ColorCell
        if let color = vm.data(forIndex: indexPath.row) {
            cell.setup(name: color.name, hex: color.hex, color: UIColor(hexString: color.hex) ?? .black)
        }
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
}
