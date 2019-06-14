//
//  WalkDetailViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 14/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit
import CoreLocation

class WalkRunViewController: UIViewController {

    //FOR DESIGN
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberOfMushLabel: UILabel!
    
    
    //FOR DATAS
    var walk: Walk!
    private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startRun()
        //configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }

    // MARK: - SetUp design Methods
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
    
    private func updateDisplay() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        
        distanceLabel.text = formattedDistance
        timeLabel.text = formattedTime
    }
    
    
    // MARK: - Location and Time methods
    
    func startRun() {
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()

    }
    
    func eachSecond() {
        seconds += 1
        updateDisplay()
    }
    

    
    private func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
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

extension WalkRunViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            
            locationList.append(newLocation)
        }
    }
}
