//
//  ManualColorGetterViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class PickerViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkDataButton: UIButton!
    @IBOutlet weak var colorBackgroundView: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    let vm = PickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupViewComponents()
        setupSegmentedControl()
        styleView()
    }
     
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAfterLayout()
    }
    
    private func styleView() {
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = Style.keyColor
            searchBar.searchTextField.textColor = Style.keyContrastColor
            if let icon = searchBar.searchTextField.leftView as? UIImageView {
                let newImage = icon.image?.withTintColor(Style.accentKeyColor, renderingMode: .alwaysTemplate)
                searchBar.searchTextField.leftView = UIImageView(image: newImage)
            }
        } else if let serchField = searchBar.value(forKey: "searchField") as? UITextField {
            
        }
 
        searchBar.tintColor = Style.accentKeyColor
        searchBar.backgroundImage = UIImage()
        tableView.allowsSelection = false
    }
    
    private func setupAfterLayout() {
        if colorBackgroundView.bounds.height > colorBackgroundView.bounds.width {
            
        } else {
            tableViewHeightConstraint.constant = 3 * SliderCell.height
        }
        
        colorBackgroundView.layoutIfNeeded()
        colorBackgroundView.layer.masksToBounds = true
        colorBackgroundView.layer.cornerRadius = colorBackgroundView.frame.width / 2
    }
    
    private func setupViewComponents() {
        vm.delegate = self
        vm.setController(self)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        colorBackgroundView.backgroundColor = vm.selectedColor
        checkDataButton.backgroundColor = .clear
        checkDataButton.tintColor = .clear
        checkDataButton.setTitleColor(.clear, for: .normal)
    }
    
    private func setupSearchBar() {
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        searchBar.placeholder = vm.placeholder
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = vm.rowHeight
        tableView.register(UINib(nibName: "SliderCell", bundle: Bundle.main), forCellReuseIdentifier: vm.sliderCellIdentifier)
    }
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        for i in 0...(vm.segmentedItems.count - 1) {
            segmentedControl.insertSegment(withTitle: vm.segmentedItems[i], at: i, animated: false)
        }
        segmentedControl.selectedSegmentIndex = vm.indexOfSelectedPicker
    }
    
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        vm.segmentSelected(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func checkData(_ sender: Any) {
        openLoadingScreen()
        vm.sendDataRequest()
    }
    
    @objc internal func hideKeyboard() {
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }
    
    internal func revelKeyboard() {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

extension PickerViewController: PickerViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    func show(color: WSColorModel) {
        DispatchQueue.main.async {
            self.hideLoadingScreen()
            self.coordinator?.openColorData(data: ColorModel(color: color))
        }
    }
    
    func show(error: Error?) {
        // coordinator?.show(error: error)
    }
    
    func didPick(color: UIColor) {
        colorBackgroundView.backgroundColor = color
    }
}

extension PickerViewController: SliderCellDelegate {
    func didChange(value: Float, type: SliderCellType) {
        vm.sliderDataChange(value, type: type)
    }
}


/* TODO Zbiorczy
 CD Baza REMOVE!!!!!
 Modele - colory exact i derivative
 Kolory w aplikacji Tint - Styl?
 Layout głownego pickera
 Konwersja RGB-HLS-CMYK
 Loading screen add / remove
 Kamera wyłączanie sesji
 Alerty:
    Zły hex,
    bład kolorów,
    brak kamery,
    inne catche
 
 Optionale
 Dodanie CMYK?
 Kamera naprawa pinch zoom
 Kamera dodanie flash
 
 Kolejny etam
 Schematy kolorów
 */

