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
        
       mushUID = getMushUID()
        print(mushUID)
        getCurrentDateFormated()
       

    }
    
    func createTheMush(){
        mush.id = mushUID
        mush.image = firstImage
    }
    
    
    // MARK: - Utils
    func getCurrentDateFormated(){
        let months: [String] = ["Jan.","Fev.","Mars","Avr.","Mai","Juin","Juil.","Août","Sept.","Oct.","Nov","Dec."]
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
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String? ?? ""
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
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            //self.saveImage(image: image)
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
    }
    
    @IBAction func positionButtonClicked(_ sender: Any) {
    }
    
    @IBAction func saveNewMushClicked(_ sender: Any) {
        createTheMush()
        // Todo storeTheMush()
        // Todo returnBack()
    }
    
    
}
