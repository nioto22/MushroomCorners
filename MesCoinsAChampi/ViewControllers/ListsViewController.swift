//
//  FirstViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 11/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class ListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    

    // FOR DESIGN
    @IBOutlet weak var walkTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // FOR DATAS
    enum DisplayMode: Int {
        case Walks = 0
        case Mush = 1
    }
    // TableView Vars
    var displayMode: DisplayMode = DisplayMode.Walks
    var tableViewCellIdentifier: String!
    
    // Datas Var
    var walksArray: [Walk]! = []
    var mushArray: [Mush]! = []
    var walkSelected: String!
    var mushSelected: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        
        //clearDatas()
        getMushList()
    }

    func clearDatas(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mush")
                let typePredicate = NSPredicate(format: "title = %@", "")
                //let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
                fetchRequest.predicate = typePredicate
                //fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            mushArray = try context.fetch(fetchRequest) as? [Mush]
            for mush in mushArray {
                context.delete(mush)
            }
        } catch {
            print("Context could not send data")
        }
    }
    
    
    // MARK: - SetUp Design
    func refreshTableView(){
        walkTableView.reloadData()
    }
    
    func getMushList(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mush")
//        let typePredicate = NSPredicate(format: "albumInCollection = %@", "true")
//        let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
//        fetchRequest.predicate = typePredicate
//        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            mushArray = try context.fetch(fetchRequest) as? [Mush]
        } catch {
            print("Context could not send data")
        }
        refreshTableView()
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isDisplayWalk() ? walksArray.count : mushArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isDisplayWalk() ? 150 : 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableViewCellIdentifier = isDisplayWalk() ? WALK_TABLE_VIEW_CELL_IDENTIFIER : MUSH_TABLE_VIEW_CELL_IDENTIFIER
           var cell = self.isDisplayWalk() ? self.walkTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! WalkTableViewCell
            : self.walkTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! MushTableViewCell
        
        if isDisplayWalk() {
            cell = setUpWalkCell(cell: cell as! WalkTableViewCell)
        } else {
            cell = setUpMushCell(cell: cell as! MushTableViewCell, indexPath: indexPath)

        }
        
        return cell
    }
    
    func setUpWalkCell(cell: WalkTableViewCell) -> WalkTableViewCell{
        return cell
    }

    func setUpMushCell(cell: MushTableViewCell, indexPath: IndexPath) -> MushTableViewCell{
        let mushSelect = mushArray[indexPath.row]
        if let imagePath = mushSelect.image {
            cell.mushSmallImageView = getImage(imagePath: imagePath)
            cell.musBackgroundImageView = getImage(imagePath: imagePath)
        }
        cell.mushTitleLabel.text = mushSelect.title ?? ""
        cell.mushDateLabel.text = mushSelect.date ?? ""
        cell.mushAdressLabel.text = mushSelect.position ?? ""
        
        return cell
    }
    
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Utils
    
    func getImage(imagePath: String) -> UIImageView{
        var imageView: UIImageView! = UIImageView(image: UIImage(named: "mushPictureIcon"))
        if (imagePath != ""){
            do {
                //let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                let readData = try Data(contentsOf: URL(string: imagePath)!)
                let retreivedImage = UIImage(data: readData)!
                imageView = UIImageView(image: retreivedImage)
            } catch {
                print("Error")
            }
        }
        return imageView
    }

    
    // MARK: - Actions
    
    @IBAction func addNewMushButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Créer", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Une nouvelle balade", style: .default, handler: { action in
                self.performSegue(withIdentifier: ADD_NEW_WALK_SEGUE_IDENTIFIER, sender: self)
            }))
            alert.addAction(UIAlertAction(title: "Un nouveau coin à champignon", style: .default, handler: { action in
                self.performSegue(withIdentifier: ADD_NEW_MUSH_SEGUE_IDENTIFIER, sender: self)
            }))
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func searchButtonClicked(_ sender: Any) {
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
    }
    
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == DisplayMode.Walks.rawValue {
            displayMode = DisplayMode.Walks
        } else {
            displayMode = DisplayMode.Mush
        }
        refreshTableView()
    }
    
    // MARK: - Navigators
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "showStationDetailSegue" {
        //            if let detailVC = segue.destination as? DetailViewController{
        //                detailVC.selectedStation = selectedStation
        //            }
        //        }
    }
    
    
    // MARK: - Utils
    func isDisplayWalk() -> Bool {
        return (displayMode == DisplayMode.Walks) ? true : false
    }
}
