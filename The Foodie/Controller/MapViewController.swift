//
//  MapViewController.swift
//  The Foodie
//
//  Created by Shady Adel on 09/06/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet var detailMapView: MKMapView!
    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler:
                                        { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    // Display the annotation
                    self.detailMapView.showAnnotations([annotation], animated: true)
                    self.detailMapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
