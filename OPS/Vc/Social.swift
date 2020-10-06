//
//  Social.swift
//  OPS
//
//  Created by Happy Sanz Tech on 06/10/20.
//

import UIKit
import WebKit

class Social: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    var segmentedControl = HMSegmentedControl()
    var socialMedia = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        socialMedia = ["Facebook","Twitter","Instagram","Linkedin","Sharechat"]
        setUpSegementControl()
        self.segmentedControl.selectedSegmentIndex = 0
        let request = URLRequest(url: URL(string: "https://www.facebook.com/OfficeOfOPS/")!)
        webView?.load(request)
        
    }
    
    func setUpSegementControl ()
    {
        segmentedControl = HMSegmentedControl(sectionTitles: self.socialMedia)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.segmentView.frame.width, height: 50)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        segmentView.addSubview(segmentedControl)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 67.0/255.0, green: 67.0/255.0, blue: 67.0/255.0, alpha: 1.0)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 11.0/255.0, green: 148.0/255.0, blue: 33.0/255.0, alpha: 1.0)]
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.fixed
        segmentedControl.selectionIndicatorHeight = 4.0
        segmentedControl.selectionIndicatorColor = UIColor(red: 11.0/255.0, green: 148.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 13.0)!]
    }

    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        if segmentedControl.selectedSegmentIndex == 0
        {
            let request = URLRequest(url: URL(string: "https://www.facebook.com/OfficeOfOPS/")!)
            webView?.load(request)
        }
        else if segmentedControl.selectedSegmentIndex == 1
        {
            let request = URLRequest(url: URL(string: "https://twitter.com/OfficeOfOPS")!)
            webView?.load(request)
        }
        else if segmentedControl.selectedSegmentIndex == 2
        {
            let request = URLRequest(url: URL(string: "https://www.instagram.com/officeof_ops/")!)
            webView?.load(request)
        }
        else if segmentedControl.selectedSegmentIndex == 3
        {
            let request = URLRequest(url: URL(string: "https://www.linkedin.com/in/panneerselvam-o-033762192/")!)
            webView?.load(request)
        }
        else if segmentedControl.selectedSegmentIndex == 4
        {
            let request = URLRequest(url: URL(string: "https://sharechat.com/profile/officeofops?referer=tagProfileSearchPage")!)
            webView?.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         print("Strat to load")
        self.view.activityStartAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         print("finish to load")
        self.view.activityStopAnimating()

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
