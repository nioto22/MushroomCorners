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
    var walkSelected: Walk!
    var mushSelected: Mush!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        walkTableView.dataSource = self
        walkTableView.delegate = self

//        getMushList()
//        getWalkList()
    }

    override func viewWillAppear(_ animated: Bool) {
        getMushList()
        getWalkList()
    }
  
    
    // MARK: - SetUp Design
    func refreshTableView(){
        walkTableView.reloadData()
    }
    
    func getMushList(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mush")
        do {
            mushArray = try context.fetch(fetchRequest) as? [Mush]
        } catch {
            print("Context could not send data")
        }
        refreshTableView()
    }
    
    func getWalkList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Walk")
        do {
            walksArray = try context.fetch(fetchRequest) as? [Walk]
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
            cell = setUpWalkCell(cell: cell as! WalkTableViewCell, indexPath: indexPath)
        } else {
            cell = setUpMushCell(cell: cell as! MushTableViewCell, indexPath: indexPath)

        }
        
        return cell
    }
    
    func setUpWalkCell(cell: WalkTableViewCell, indexPath: IndexPath) -> WalkTableViewCell{
        let walkSelect = walksArray[indexPath.row]
        if let imagePath = walkSelect.image {
            cell.backgroundImageView.image = ImageManager.shared.getImageFromPath(imageName: imagePath, defaultImage: "forestIcon")
        }
        cell.walkTitleLabel.text = walkSelect.title ?? ""
        cell.numberOfMushLabel.text = String(walkSelect.mushrooms!.count)
        return cell
    }

    func setUpMushCell(cell: MushTableViewCell, indexPath: IndexPath) -> MushTableViewCell{
        let mushSelect = mushArray[indexPath.row]
        if let imagePath = mushSelect.image {
            cell.mushSmallImageView.image = ImageManager.shared.getImageFromPath(imageName: imagePath, defaultImage: "mushPictureIcon")
            cell.musBackgroundImageView.image = ImageManager.shared.getImageFromPath(imageName: imagePath, defaultImage: "mushPictureIcon")
        }
        cell.mushTitleLabel.text = mushSelect.title ?? ""
        cell.mushDateLabel.text = mushSelect.date ?? ""
        
        
        return cell
    }
    
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if  isDisplayWalk() {
            walkSelected = walksArray[indexPath.row]
            performSegue(withIdentifier: WALK_DETAIL_SEGUE_IDENTIFIER, sender: self)
       } else {
            mushSelected = mushArray[indexPath.row]
            performSegue(withIdentifier: MUSH_DETAIL_SEGUE_IDENTIFIER, sender: self)
        }
    }
    
    

    
    // MARK: - Actions
    
    @IBAction func addNewMushButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "CRÉER :", message: nil, preferredStyle: .actionSheet)
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
        if segue.identifier == WALK_DETAIL_SEGUE_IDENTIFIER {
            if let destinationVC = segue.destination as? WalkDetailViewController{
                destinationVC.walk = walkSelected
            }
        } else if segue.identifier == MUSH_DETAIL_SEGUE_IDENTIFIER {
            if let destinationVC = segue.destination as? MushDetailViewController{
                destinationVC.mush = mushSelected
            }
        }
    }
    
    
    // MARK: - Utils
    func isDisplayWalk() -> Bool {
        return (displayMode == DisplayMode.Walks) ? true : false
    }
}
