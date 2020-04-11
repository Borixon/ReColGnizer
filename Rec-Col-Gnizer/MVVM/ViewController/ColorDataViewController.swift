//
//  ColorDataViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ColorDataViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    var vm: ColorDataViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewComponents()
        setupTableView()
    }

    private func setupViewComponents() {
        view.backgroundColor = vm.color
        saveButton.tintColor = vm.color
        saveButton.layer.masksToBounds = true
        saveButton.layer.cornerRadius = Styles.applyButtonCornerRadius
        saveButton.backgroundColor = vm.contrastColor 
        navigationController?.navigationBar.tintColor = vm.contrastColor
        navigationController?.navigationBar.barTintColor = vm.color
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ColorNameCell", bundle: Bundle.main), forCellReuseIdentifier: vm.nameCellIndentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
}

extension ColorDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //vm.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: vm.nameCellIndentifier) as? ColorNameCell {
            cell.setup(name: vm.nameData.name, hex: vm.nameData.hex, contrast: vm.contrastColor)
            return cell
        }
        return UITableViewCell()
    }
}


