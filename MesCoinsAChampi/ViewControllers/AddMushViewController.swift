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

class AddMushViewController: UIViewController, CLLocationManagerDelegate {
    
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

    // FOR DATAS
    var mush: Mush!
    var firstImage: String! = ""
    var mushTitle: String! = ""
    var mushDate: String! = ""
    var mushPosition: CLLocation!
    var mushType: String! = ""
    var picturesList: [String]! = []
    
    var mushUID: String! = ""
    
    let months: [String] = ["Jan.","Fev.","Mars","Avr.","Mai","Juin","Juil.","Août","Sept.","Oct.","Nov","Dec."]
    private let locationManager = LocationManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.isHidden = true
        startLocationUpdating()
        showDatePicker()
        
       mushUID = getMushUID()
        dateTextField.text = FormatDisplay.getCurrentDateFormated()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    func startLocationUpdating() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mushPosition = locationManager.location
        //"Latitude: \(mushPosition.coordinate.latitude), longitude: \(mushPosition.coordinate.longitude)"
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
        mush?.position?.latitude = mushPosition.coordinate.latitude
        mush?.position?.longitude = mushPosition.coordinate.longitude
        mush?.position?.timestamp = mushPosition.timestamp as NSDate
        
        do {
            try context.save()
        } catch {
            print("context could not save data")
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    
    
    // MARK: - Utils
    
    func getMushUID() -> String {
        return UUID().uuidString
    }
    
 
    func getCurrentPosition(){
        mushPosition = locationManager.location
        print(mushPosition)
        //positionTextField.text = "Latitude: " + String(mushPosition.coordinate.latitude) + ", longitude: " + String(mushPosition.coordinate.longitude)
//        let userLocation = locationManager.location!.coordinate
//        if (userLocation.latitude != 0 && userLocation.longitude != 0) {
//            mush?.position?.latitude = userLocation.latitude
//            mush?.position?.longitude = userLocation.longitude
//        }
//        return "Latitude: " + String(userLocation .latitude) + ", Longitude: " + String(userLocation.longitude)
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
    }
    

//    @IBAction func dateEditingAction(_ sender: Any) {
//        showDatePicker()
////        let datePickerView:UIDatePicker = UIDatePicker()
////        datePickerView.datePickerMode = UIDatePicker.Mode.date
////        dateTextField.inputView = datePickerView
////        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControl.Event.valueChanged)
//    }

    
    @IBAction func positionEditingAction(_ sender: Any) {
        //mushPosition = positionTextField.text
    }

    @IBAction func addImageButtonClicked(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.firstImage = ImageManager.shared.saveImage(image: image, uid: self.mushUID)
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
        // Todo returnBack()
    }
    
    
}
