//
//  ColorDataViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ColorDataViewController: UIViewController, StoryboardedProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var vm: ColorDataViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewComponents()
        setupTableView()
        vm.delegate = self
    }
    
    private func setupViewComponents() {
        view.backgroundColor = vm.color
        saveButton.tintColor = vm.color
        saveButton.layer.masksToBounds = true
        saveButton.layer.cornerRadius = Styles.applyButtonCornerRadius
        saveButton.backgroundColor = vm.contrastColor
        backButton.tintColor = vm.contrastColor
        navigationController?.navigationBar.tintColor = vm.contrastColor
        navigationController?.navigationBar.barTintColor = vm.color
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ColorNameCell", bundle: Bundle.main), forCellReuseIdentifier: vm.nameCellIndentifier)
        tableView.register(UINib(nibName: "ColumnDataCell", bundle: Bundle.main), forCellReuseIdentifier: vm.columnDataCellIdentifier)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    @IBAction func saveRemoveColor(_ sender: Any) {
        vm.saveRemovePressed()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ColorDataViewController: ColorDataViewModelDelegate {
    func setButtonTitle(_ title: String) {
        saveButton.setTitle(title, for: .normal)
    }
}

extension ColorDataViewController: UITableViewDelegate {
    
}

extension ColorDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: vm.nameCellIndentifier) as! ColorNameCell
            cell.setup(name: vm.nameData.name, hex: vm.nameData.hex, contrast: vm.contrastColor)
            return cell
        } else {
            let dataCell = tableView.dequeueReusableCell(withIdentifier: vm.columnDataCellIdentifier) as! ColumnDataCell
            if let data = vm.colorData(forIndex: indexPath) {
                dataCell.setup(name: data.name, columns: data.columns, contrast: data.contrast)
            }
            return dataCell
        }
    }
    
    
}


