//
//  AddMushViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 12/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class AddMushViewController: UIViewController {
    
    // FOR DESIGN
    
    @IBOutlet weak var scroller: UIScrollView!
    
    @IBOutlet weak var scrollSubView: UIView!
    @IBOutlet weak var addImageButton: RoundedUIButton!
    @IBOutlet weak var addAnImageLabel: UILabel!
    @IBOutlet weak var titleTextField: RoundedUITextField!
    @IBOutlet weak var dateTextField: RoundedUITextField!
    @IBOutlet weak var positionTextField: RoundedUITextField!
    @IBOutlet weak var mushTypeLabel: UILabel!
    @IBOutlet weak var mushTypeButton: RoundedUIButton!
    
    @IBOutlet weak var baladeLabel: UILabel!
    @IBOutlet weak var chooseWalkButton: RoundedUIButton!
    @IBOutlet weak var addPicturesButton: RoundedUIButton!
    
    let changeImageText = "Changer l'image"
    let datePicker = UIDatePicker()
    let months: [String] = ["Jan.","Fev.","Mars","Avr.","Mai","Juin","Juil.","Août","Sept.","Oct.","Nov","Dec."]

    // FOR DATAS
    var mush: Mush!
    var firstImage: String! = ""
    var mushTitle: String! = ""
    var mushDate: String! = ""
    var mushPosition: String! = ""
    var mushType: String! = ""
    var picturesList: [String]! = []
    
    var mushUID: String! = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        showDatePicker()
        
       mushUID = getMushUID()
        getCurrentDateFormated()
        mushPosition = positionTextField.text

    }
    
    func createAndSaveTheMush(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Mush", in: context)
        
        mush = NSManagedObject(entity: entity!, insertInto: context) as? Mush
        
        mush?.id = mushUID
        mush?.image = firstImage
        mush?.title = titleTextField.text
        mush?.date = dateTextField.text
        mush?.mushroomType = mushType
        
        do {
            try context.save()
        } catch {
            print("context could not save data")
        }
    }
    

    
    
    // MARK: - Utils
    func getCurrentDateFormated(){
        
        let date = Date()
        let calendar = Calendar.current
        let year = String(calendar.component(.year, from: date))
        let month = months[(calendar.component(.month, from: date) - 1)]
        let day = String(calendar.component(.day, from: date))
        
        mushDate = day + " " + month + " " + year
        dateTextField.text = mushDate
    }
    
    func getMushUID() -> String {
        return UUID().uuidString
    }
    
    // MARK: - Image Methods
    func saveImage(image: UIImage){
        let data = image.pngData()!
        do {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            firstImage = "\(documentsPath)/\(String(mushUID))"
            try data.write(to: URL(string: firstImage)!, options: .atomic)
            } catch {
                print("Error")
            }
    }
    
    func getImage(imagePath: String){
        do {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let readData = try Data(contentsOf: URL(string: "\(documentsPath)/myImage")!)
            let retreivedImage = UIImage(data: readData)!
        } catch {
        print("Error")
        }
    }
 
    
    // MARK: - DatePicker actions
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        
        dateTextField.inputView = datePicker

        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
       dateTextField.inputAccessoryView = toolbar
        
    }
    
    @objc func donedatePicker(){
        
        let calendar = Calendar.current
        let year = String(calendar.component(.year, from: datePicker.date))
        let month = months[(calendar.component(.month, from: datePicker.date) - 1)]
        let day = String(calendar.component(.day, from: datePicker.date))
        
        mushDate = day + " " + month + " " + year
        dateTextField.text = mushDate
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    // MARK: - ACTIONS
    
    @IBAction func titleEditingEndedAction(_ sender: Any) {
        mushTitle = titleTextField.text
        print(mushTitle)
    }
    

//    @IBAction func dateEditingAction(_ sender: Any) {
//        showDatePicker()
////        let datePickerView:UIDatePicker = UIDatePicker()
////        datePickerView.datePickerMode = UIDatePicker.Mode.date
////        dateTextField.inputView = datePickerView
////        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControl.Event.valueChanged)
//    }

    
    @IBAction func positionEditingAction(_ sender: Any) {
        mushPosition = positionTextField.text
    }

    @IBAction func addImageButtonClicked(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.saveImage(image: image)
            self.addImageButton.setImage(image, for: .normal)
            self.addAnImageLabel.text = self.changeImageText
            
        }
    }
    
    @IBAction func addPicturesButtonClicked(_ sender: Any) {
    }
    
    @IBAction func mushTypeButtonClicked(_ sender: Any) {
    }
    
    
    @IBAction func chooseWalkButtonClicked(_ sender: Any) {
    }
    
    @IBAction func calendarButtonClicked(_ sender: Any) {
        showDatePicker()
//        let datePickerView:UIDatePicker = UIDatePicker()
//        datePickerView.datePickerMode = UIDatePicker.Mode.date
//        dateTextField.inputView = datePickerView
//        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControl.Event.valueChanged)

    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let calendar = Calendar.current
        let year = String(calendar.component(.year, from: sender.date))
        let month = months[(calendar.component(.month, from: sender.date) - 1)]
        let day = String(calendar.component(.day, from: sender.date))
        
        mushDate = day + " " + month + " " + year
        dateTextField.text = mushDate
    }
    
    @IBAction func positionButtonClicked(_ sender: Any) {
    }
    
    @IBAction func saveNewMushClicked(_ sender: Any) {
        createAndSaveTheMush()
        // Todo storeTheMush()
        // Todo returnBack()
    }
    
    
}
