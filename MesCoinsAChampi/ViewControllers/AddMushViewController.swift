//
//  AddMushViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 12/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

class AddMushViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // FOR DESIGN
    @IBOutlet weak var addImageButton: RoundedUIButton!
    @IBOutlet weak var addAnImageLabel: UILabel!
    @IBOutlet weak var titleTextField: RoundedUITextField!
    @IBOutlet weak var dateTextField: RoundedUITextField!
    @IBOutlet weak var positionTextField: RoundedUITextField!

    @IBOutlet weak var mushTypeLabel: UILabel!
    @IBOutlet weak var mushTypeButton: RoundedUIButton!
    
    @IBOutlet weak var addPicturesButton: RoundedUIButton!
    
    // FOR DATAS
    let colors = ["Red","Yellow","Green","Blue"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - PickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
    
    
    // MARK: - ACTIONS
    
    @IBAction func titleEditingEndedAction(_ sender: Any) {
    }
    
    @IBAction func dateEditingAction(_ sender: Any) {
    }
    
    @IBAction func positionEditingAction(_ sender: Any) {
    }

    @IBAction func addImageButtonClicked(_ sender: Any) {
    }
    
    @IBAction func addPicturesButtonClicked(_ sender: Any) {
    }
    
    @IBAction func mushTypeButtonClicked(_ sender: Any) {
    }
    
    
}
