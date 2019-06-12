//
//  AddMushViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 12/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

class AddMushViewController: UIViewController {
    
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
    var firstImage: String!
    var mushTitle: String!
    var mushDate: String!
    var mushPosition: String!
    var mushType: String!
    var picturesList: [String]! = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    
    
    // MARK: - ACTIONS
    
    @IBAction func titleEditingEndedAction(_ sender: Any) {
        mushTitle = titleTextField.text
    }
    
    @IBAction func dateEditingAction(_ sender: Any) {
        mushDate = dateTextField.text
    }
    
    @IBAction func positionEditingAction(_ sender: Any) {
        mushPosition = positionTextField.text
    }

    @IBAction func addImageButtonClicked(_ sender: Any) {
    }
    
    @IBAction func addPicturesButtonClicked(_ sender: Any) {
    }
    
    @IBAction func mushTypeButtonClicked(_ sender: Any) {
    }
    
    @IBAction func calendarButtonClicked(_ sender: Any) {
    }
    
    @IBAction func positionButtonClicked(_ sender: Any) {
    }
}
