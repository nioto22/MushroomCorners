//
//  FormatDisplay.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 14/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import Foundation

struct FormatDisplay {
    static func distance(_ distance: Double) -> String {
        let distanceMeasurement = Measurement(value: distance, unit: UnitLength.meters)
        return FormatDisplay.distance(distanceMeasurement)
    }
    
    static func distance(_ distance: Measurement<UnitLength>) -> String {
        let formatter = MeasurementFormatter()
        return formatter.string(from: distance)
    }
    
    static func time(_ seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds))!
    }
    
    static func pace(distance: Measurement<UnitLength>, seconds: Int, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit] // 1
        let speedMagnitude = seconds != 0 ? distance.value / Double(seconds) : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.metersPerSecond)
        return formatter.string(from: speed.converted(to: outputUnit))
    }
    
    static func date(_ timestamp: Date?) -> String {
        let months: [String] = ["Jan.","Fev.","Mars","Avr.","Mai","Juin","Juil.","Août","Sept.","Oct.","Nov","Dec."]
        let date = timestamp ?? Date()
        let calendar = Calendar.current
        let year = String(calendar.component(.year, from: date))
        let month = months[(calendar.component(.month, from: date) - 1)]
        let day = String(calendar.component(.day, from: date))
        
        let mushDate = day + " " + month + " " + year
        return mushDate
    }
    
    static func getCurrentDateFormated() -> String {
        let months: [String] = ["Jan.","Fev.","Mars","Avr.","Mai","Juin","Juil.","Août","Sept.","Oct.","Nov","Dec."]
        let date = Date()
        let calendar = Calendar.current
        let year = String(calendar.component(.year, from: date))
        let month = months[(calendar.component(.month, from: date) - 1)]
        let day = String(calendar.component(.day, from: date))
        
        let mushDate = day + " " + month + " " + year
        return mushDate
    }
}
