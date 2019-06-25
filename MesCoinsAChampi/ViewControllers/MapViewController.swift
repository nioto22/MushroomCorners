//
//  SecondViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 11/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var walkArray: [Walk]! = []
    var mushArray: [Mush]! = []
    var walkSelected: Walk!
    var mushSelected: Mush!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationRadius = CLLocationDistance(80000)
        let mapCenter = CLLocationCoordinate2D(latitude: 48.42008733448947, longitude: 2.6312255859375)
        let mapRegion = MKCoordinateRegion.init(center: mapCenter, latitudinalMeters: locationRadius,longitudinalMeters: locationRadius)
        mapView.setRegion(mapRegion, animated: false)
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMushList()
        getWalkList()
        
        addAllMapAnnotations()
    }

    func addAllMapAnnotations() {
        for walk in walkArray {
            mapView.addOverlay(polyLine(walk: walk))
        }
        for mush in mushArray {
            mapView.addAnnotation(mush)
        }
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
    }
    
    func getWalkList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Walk")
        do {
            walkArray = try context.fetch(fetchRequest) as? [Walk]
        } catch {
            print("Context could not send data")
        }
    }

    
    private func polyLine(walk: Walk) -> MKPolyline {
        guard let locations = walk.positions else {
        return MKPolyline()
        }
        
        let coords: [CLLocationCoordinate2D] = locations.map { location in
            let location = location as! Position
            return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        }
        return MKPolyline(coordinates: coords, count: coords.count)
    }

    
    
    // MARK: - MapView delegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is Walk {
           let identifier = "WalkAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                let detailButton = UIButton(type: .detailDisclosure)
                detailButton.tintColor = UIColor.blue
                annotationView?.rightCalloutAccessoryView = detailButton
                annotationView?.canShowCallout = true
            }else {
                annotationView!.annotation = annotation
            }
            return annotationView
        } else if annotation is Mush {
            let identifier = "MushAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                let detailButton = UIButton(type: .detailDisclosure)
                detailButton.tintColor = UIColor.green
                annotationView?.rightCalloutAccessoryView = detailButton
                annotationView?.canShowCallout = true
            }else {
                annotationView!.annotation = annotation
            }
            return annotationView
        } else { return nil}
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let walk = view.annotation as? Walk {
            walkSelected = walk
            performSegue(withIdentifier: WALK_DETAIL_SEGUE_IDENTIFIER, sender: self)
        }
        if let mush = view.annotation as? Mush {
           mushSelected = mush
            performSegue(withIdentifier: MUSH_DETAIL_SEGUE_IDENTIFIER, sender: self)
        }
    }
    

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
        return renderer
    }

    
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
    
}

