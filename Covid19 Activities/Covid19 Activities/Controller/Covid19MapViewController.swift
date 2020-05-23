//
//  Covid19MapViewController.swift
//  Covid19 Activities
//
//  Created by Carlos Hernandez on 5/20/20.
//

import UIKit
import MapKit

class Covid19MapViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    
    //GOOD ONE for now
    //@IBOutlet weak var sebastianiImagView: UIImageView!
    
    @IBOutlet weak var sebastianiImagView: UIImageView!
    
    //@IBOutlet weak var gloriaferrerImagView: UIImageView!
    @IBOutlet weak var gloriaferrerImagView: UIImageView!
    
    //@IBOutlet weak var carnerosImagView: UIImageView!
    @IBOutlet weak var carnerosImagView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Title of windown/view controller
        navigationItem.title = "Wine Country"
        
        // Set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 38.291859, longitude: -122.4580356 )

        myMapView.centerToLocation(initialLocation)

        //rounding images
        sebastianiImagView.roundingImage()
        gloriaferrerImagView.roundingImage()
        carnerosImagView.roundingImage()
        

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


private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}


//to round bottoms or imagines
extension UIImageView {
    func roundingImage(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
