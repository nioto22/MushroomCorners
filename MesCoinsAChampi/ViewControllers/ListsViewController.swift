//
//  FirstViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 11/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

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
    var walksArray: [String]! = []
    var mushArray: [String]! = []
    var walkSelected: String!
    var mushSelected: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - SetUp Design
    func refreshTableView(){
        
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
        var cell: UITableViewCell!
            cell = self.isDisplayWalk() ? self.walkTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! WalkTableViewCell
            : self.walkTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! MushTableViewCell
        
        if isDisplayWalk() {
            cell = setUpWalkCell(cell: cell as! WalkTableViewCell)
        } else {
            cell = setUpMushCell(cell: cell as! MushTableViewCell)
        }
        
        return cell
    }
    
    func setUpWalkCell(cell: WalkTableViewCell) -> WalkTableViewCell{
        return cell
    }

    func setUpMushCell(cell: MushTableViewCell) -> MushTableViewCell{
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

    
    // MARK: - Actions
    
    @IBAction func addNewMushButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: ADD_NEW_MUSH_SEGUE_IDENTIFIER, sender: self)
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
