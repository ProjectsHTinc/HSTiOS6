//
//  TabbarController.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate, UISearchControllerDelegate, UISearchBarDelegate {
    
    var menuButton = UIButton(frame: CGRect.zero)
    var searchController = UISearchController()
    var user_id = String()
    
//    var userDetails = [U]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Tabbar border width*/
      
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.clipsToBounds = true
        navTitleOnLeftSide ()
        setupMiddleButton ()
        searchBar ()

    }
     
    override func viewDidAppear(_ animated: Bool) {
//
    }
    
    func searchBar()
    {
       
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        let searchBar = searchController.searchBar
        searchBar.tintColor = UIColor.white
//        searchBar.backgroundColor = UIColor.white
       
        searchBar.barTintColor = UIColor.white
        searchController.searchBar.delegate = self

        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            textfield.backgroundColor = UIColor.white
            
            if let backgroundview = textfield.subviews.first {
                //  Background color
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
    
    @IBAction func profileAction(_ sender: Any) {
        
        let user_Id = UserDefaults.standard.object(forKey: UserDefaultsKey.userIDkey.rawValue) ?? ""
        
        if user_Id as! String == ""
        {
            self.performSegue(withIdentifier: "to_login", sender: self)
        }
        else
        {
            self.performSegue(withIdentifier: "to_settings", sender: self)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuButton.frame.origin.y = self.view.bounds.height - menuButton.frame.height - self.view.safeAreaInsets.bottom

    }
    
    func setupMiddleButton() {

        menuButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height - self.view.safeAreaInsets.bottom
        menuButtonFrame.origin.x = self.view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        menuButton.setImage(UIImage(named: "OPS"), for: UIControl.State.normal)

        //menuButton.backgroundColor = UIColor.green
        self.view.addSubview(menuButton)
        self.view.layoutIfNeeded()
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: UIControl.Event.touchUpInside)

    }

    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 2
        // console print to verify the button works
//        self.performSegue(withIdentifier: "to_OPS", sender: self)
        print("Middle Button was just pressed!")
       }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
       
        self.searchController.isActive = false
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
          if let vc = viewController as? Home {
            vc.user_id = self.user_id
          }
          else if let vc = viewController as? Gallery {
             vc.user_id = self.user_id
          }
          else if let vc = viewController as? Event {
             vc.user_id = self.user_id
          }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_Search")
        {
            let vc = segue.destination as! Search
            vc.keyword = sender as! String
        }
        if (segue.identifier == "to_OPS")
        {
            _ = segue.destination as! ViewController
        }
        if (segue.identifier == "to_login")
        {
            _ = segue.destination as! login
        }
        if (segue.identifier == "to_settings")
        {
            _ = segue.destination as! AppSettings
        }
    }
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
