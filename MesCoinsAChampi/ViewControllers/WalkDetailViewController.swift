//
//  WalkDetailViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 17/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit
import MapKit

class WalkDetailViewController: UIViewController {
    
    // FOR DESIGN
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageImageView: UIImageView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var numberOfMushLabel: UILabel!
    
    // FOR DATA
    var walk: Walk!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = true
        configureView()
    }
    
    
    private func configureView() {
        let distance = Measurement(value: walk.distance, unit: UnitLength.meters)
        let seconds = Int(walk.duration)
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedDate = FormatDisplay.date(walk.timestamp)
        //let formattedDate = FormatDisplay.getCurrentDateFormated()
        let formattedTime = FormatDisplay.time(seconds)
        
        distanceLabel.text = formattedDistance
        dateTimeLabel.text = formattedDate
        durationLabel.text = formattedTime
        
        titleLabel.text = walk.title
        loadImage()
        loadMap()
    }

    
    // MARK: - SETUP DISPLAY
    func loadImage() {
        titleImageImageView.image = ImageManager.shared.getImageFromPath(imageName: walk!.image!, defaultImage: "forestIcon")
    }
    
    // MARK: - MAP DRAWING METHODS
    private func loadMap() {
        guard
            let locations = walk.positions,
            locations.count > 0,
            let region = mapRegion()
            else {
                let alert = UIAlertController(title: "Error",
                                              message: "Sorry, this walk has no locations saved",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true)
                return
        }
        mapView.setRegion(region, animated: true)
        mapView.addOverlay(polyLine())
    }
    
    private func mapRegion() -> MKCoordinateRegion? {
        guard
            let locations = walk.positions,
            locations.count > 0
            else {
                return nil
        }
        
        let latitudes = locations.map { location -> Double in
            let location = location as! Position
            return location.latitude
        }
        
        let longitudes = locations.map { location -> Double in
            let location = location as! Position
            return location.longitude
        }
        
        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLong = longitudes.max()!
        let minLong = longitudes.min()!
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
                                            longitude: (minLong + maxLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3,
                                    longitudeDelta: (maxLong - minLong) * 1.3)
        return MKCoordinateRegion(center: center, span: span)
    }

    private func polyLine() -> MKPolyline {
        guard let locations = walk.positions else {
            return MKPolyline()
        }
        
        let coords: [CLLocationCoordinate2D] = locations.map { location in
            let location = location as! Position
            return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        }
        return MKPolyline(coordinates: coords, count: coords.count)
    }

}


extension WalkDetailViewController: MKMapViewDelegate {
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
