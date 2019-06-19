//
//  WalkDetailViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 14/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class WalkRunViewController: UIViewController {

    //FOR DESIGN
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberOfMushLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //FOR DATAS
    var walk: Walk!
    var walksArray: [Walk] = []
    private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRun()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }

    // MARK: - SetUp design Methods
    private func configureView(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Walk", in: context)
        if walk != nil {
            let identifier = walk.id
            walk = getWalkFromData(id: identifier!)
            if walk == nil {
                walk = NSManagedObject(entity: entity!, insertInto: context) as? Walk
                walk?.id = identifier
            }
            titleLabel.text = walk?.title
            imageImageView.image = ImageManager.shared.getImageFromPath(imageName: walk?.image ?? "forestIcon", defaultImage: "forestIcon")
            dateLabel.text = FormatDisplay.date(walk?.timestamp)
            distanceLabel.text = "0m"
            timeLabel.text = "0s"
            numberOfMushLabel.text = "0"
        
        }
    }
    
    func getWalkFromData(id: String) -> Walk?{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Walk")
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            
            do {
                walksArray = try context.fetch(fetchRequest) as! [Walk]
                
                if (walksArray.count > 0){
                    return walksArray.first
                }
            } catch {
                print("context could not save data")
            }
            return nil
        }
    
    private func updateDisplay() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        
        distanceLabel.text = formattedDistance
        timeLabel.text = formattedTime
    }
    
    
    // MARK: - Location and Time methods
    
    func startRun() {
        mapView.removeOverlays(mapView.overlays)
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()

    }
    
    func stopRun() {
        locationManager.stopUpdatingLocation()
    }
    
    
    
    
    private func saveRun() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Walk")
        fetchRequest.predicate = NSPredicate(format: "id == %@", walk.id!)
        
        do {
            walksArray = try context.fetch(fetchRequest) as! [Walk]
            
            if (walksArray.count > 0){
                var newWalk = walksArray.first
                newWalk?.distance = distance.value
                newWalk?.duration = Int16(seconds)
                newWalk?.timestamp = Date()
                
                for location in locationList {
                    let locationObject = Position(context: context)
                    locationObject.timestamp = location.timestamp as NSDate
                    locationObject.latitude = location.coordinate.latitude
                    locationObject.longitude = location.coordinate.longitude
                    newWalk?.addToPositions(locationObject)
                }
                walk = newWalk
            }
        } catch {
            print("context could not save data")
        }
        
        do {
            try context.save()
        } catch {
            print("context could not save data")
        }
        
        
        
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
        self.saveRun()
        self.performSegue(withIdentifier: ADD_NEW_MUSH_SEGUE_IDENTIFIER, sender: nil)
    }
    

    
    @IBAction func stopButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Arrêter la balade?",
                                                message: "Voulez-vous vraiment terminer cette balade ?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Sauvegarder", style: .default) { _ in
            self.stopRun()
            self.saveRun()
            self.performSegue(withIdentifier: WALK_DETAIL_SEGUE_IDENTIFIER, sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Quitter sans sauver", style: .destructive) { _ in
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
        present(alertController, animated: true)
    }
   
    
    // MARK: - Navigators
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case WALK_DETAIL_SEGUE_IDENTIFIER:
            let destination = segue.destination as! WalkDetailViewController
            destination.walk = walk
            break
        case ADD_NEW_MUSH_SEGUE_IDENTIFIER:
            let destination = segue.destination as! AddMushViewController
            break
        case .none:
            break
        case .some(_):
            break
        }
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
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                mapView.addOverlay(MKPolyline(coordinates: coordinates, count: 2))
                let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                mapView.setRegion(region, animated: true)
            }
            
            locationList.append(newLocation)
        }
    }
}


extension WalkRunViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
        return renderer
    }

    
}
