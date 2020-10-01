//
//  TabbarController.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate, UISearchControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Tabbar border width*/
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.clipsToBounds = true
        navTitleOnLeftSide ()
        setupMiddleButton()
        searchBar ()
    }
    
    func searchBar ()
    {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self

        let searchBar = searchController.searchBar
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white

        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {

                // Background color
                backgroundview.backgroundColor = UIColor.white

                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }


        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.setGradientBackground(colors: [UIColor(red: 11.0/255.0, green: 148.0/255.0, blue: 33.0/255.0, alpha: 1.0), UIColor(red: 6.0/255.0, green: 74.0/255.0, blue: 17.0/255.0, alpha: 1.0)], startPoint: .topLeft, endPoint: .bottomRight)
        }
        

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    func setupMiddleButton() {
           let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 54, height: 54))

           var menuButtonFrame = menuButton.frame
           menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 20
           menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
           menuButton.frame = menuButtonFrame

           //menuButton.backgroundColor = UIColor.red
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
           view.addSubview(menuButton)

           menuButton.setImage(UIImage(named: "OPS"), for: .normal)
           //menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

           view.layoutIfNeeded()
       }


       // MARK: - Actions

//       @objc private func menuButtonAction(sender: UIButton) {
//           selectedIndex = 2
//       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class UINavigationBarGradientView: UIView {
    
    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
                case .topRight: return CGPoint(x: 1, y: 0)
                case .topLeft: return CGPoint(x: 0, y: 0)
                case .bottomRight: return CGPoint(x: 1, y: 1)
                case .bottomLeft: return CGPoint(x: 0, y: 1)
                case .custom(let point): return point
            }
        }
    }

    private weak var gradientLayer: CAGradientLayer!

    convenience init(colors: [UIColor], startPoint: Point = .topLeft,
                     endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        self.init(frame: .zero)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        backgroundColor = .clear
    }

    func set(colors: [UIColor], startPoint: Point = .topLeft,
             endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = locations
    }

    func setupConstraints() {
        guard let parentView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        parentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        parentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.frame = frame
        superview?.addSubview(self)
    }
}

extension UINavigationBar {
    func setGradientBackground(colors: [UIColor],
                               startPoint: UINavigationBarGradientView.Point = .topLeft,
                               endPoint: UINavigationBarGradientView.Point = .bottomLeft,
                               locations: [NSNumber] = [0, 1]) {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        guard let gradientView = backgroundView.subviews.first(where: { $0 is UINavigationBarGradientView }) as? UINavigationBarGradientView else {
            let gradientView = UINavigationBarGradientView(colors: colors, startPoint: startPoint,
                                                           endPoint: endPoint, locations: locations)
            backgroundView.addSubview(gradientView)
            gradientView.setupConstraints()
            return
        }
        gradientView.set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
    }
}
