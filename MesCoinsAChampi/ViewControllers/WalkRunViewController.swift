//
//  WalkDetailViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 14/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

class WalkRunViewController: UIViewController {

    //FOR DESIGN
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberOfMushLabel: UILabel!
    
    
    //FOR DATAS
    var walk: Walk!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView(){
        titleLabel.text = walk.title
        imageImageView.image = getImageView(imagePath: walk.image ?? "")
        distanceLabel.text = "0m"
        timeLabel.text = "0s"
        numberOfMushLabel.text = "0"
    }
 
    func getImageView(imagePath: String) -> UIImage{
        let iV: UIImage! =  UIImage(named: "forestIcon")
        return iV
    }
    
    
    
    // MARK: - Actions :
    
    @IBAction func addMushButtonClicked(_ sender: Any) {
    }
    
    @IBAction func pauseButtonClicked(_ sender: Any) {
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Arrêter la balade?",
                                                message: "Voulez-vous vraiment terminer cette balade ?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Sauvegarder", style: .default) { _ in
            self.performSegue(withIdentifier: WALK_DETAIL_SEGUE_IDENTIFIER, sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Quitter sans sauver", style: .destructive) { _ in
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
        present(alertController, animated: true)
    }
    
}
