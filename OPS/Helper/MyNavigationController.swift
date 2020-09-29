//
//  MyNavigationController.swift
//  OPS
//
//  Created by Happy Sanz Tech on 30/09/20.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         
         let gradient = CAGradientLayer()
         var bounds = navigationBar.bounds
         bounds.size.height += UIApplication.shared.statusBarFrame.size.height
         gradient.frame = bounds
         gradient.colors = [UIColor(red: 11.0/255.0, green: 148.0/255.0, blue: 33.0/255.0, alpha: 1.0).cgColor, UIColor(red: 6.0/255.0, green: 74.0/255.0, blue: 17.0/255.0, alpha: 1.0).cgColor]
         gradient.startPoint = CGPoint(x: 0, y: 0)
         gradient.endPoint = CGPoint(x: 1, y: 0)

         if let image = getImageFrom(gradientLayer: gradient) {
             navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
         }
        
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
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
