//
//  UserProfile.swift
//  OPS
//
//  Created by Happy Sanz Tech on 20/01/21.
//

import UIKit
import Alamofire
import SDWebImage

class UserProfile: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,ProfileUpdatesView, UIPickerViewDataSource, UIPickerViewDelegate, ProfileDetailView {
 
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailIdLbl: UILabel!
    @IBOutlet weak var phoneNumLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    var presenterUpdate = ProfileUpdatePresenter(profileUpdateService:ProfileUpdateService())
    var profileUpdate = [ProfileUpdateData]()
    
    var resp = [ProfileDetailData]()
    let presenterTm = ProfileDetailPresenter(profileDetailService: ProfileDetailService())
    
    var imagePicker = UIImagePickerController()
    var uploadedImage = UIImage()
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    var selectedDate = Date()
    var genderArr = [String]()
    var dateFormatted = String()
    var name = String()
    var phoneNum = String()
    var gender = String()
    var dob = String()
    var emailID = String()
    var profilePic = String()
    var profilePicURL = String()
    var from_userProfile = String()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        self.showDatePicker()
        self.createPickerView()
        self.genderArr = ["Male","Female","Others"]
        self.CallAPIProfileDetail()
        print(GlobalVariables.shared.user_id)
        self.nameTextField.delegate = self
        self.phoneNumTextField.delegate = self
        self.emailIdTextField.delegate = self
        self.dobTextField.delegate = self
        self.genderTextField.delegate = self
//        self.addCustomizedBackBtn(title:"UserProfile")
        if from_userProfile == "To_userProfile" {
            self.navigationItem.setHidesBackButton(true, animated: true)
        }
        self.title = "UserProfile"
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(from_userProfile)
        print("12345")
     
    }
    
    func CallAPIProfileDetail ()
    {
        let user_Id = UserDefaults.standard.object(forKey: UserDefaultsKey.userIDkey.rawValue) ?? ""
        presenterTm.attachView(view: self)
        presenterTm.getProfileDeatail(user_id:user_Id as! String)
    }
    
    func startLoading() {
//
    }
    
    func finishLoading() {
//
    }
    
    func setData(profileDetailData: [ProfileDetailData]) {
        self.resp = profileDetailData
        
        for datas in resp {
            let Name = datas.full_name
            let PhoneNum = datas.phone_number
            let Gender = datas.gender
            let DOB = datas.dob
            let EmailID = datas.email_id
            let ProficPic = datas.profile_pic
            
            self.name.append(Name!)
            self.phoneNum.append(PhoneNum!)
            self.gender.append(Gender!)
            self.dob.append(DOB!)
            self.emailID.append(EmailID!)
            self.profilePic.append(ProficPic!)
            
            self.nameTextField.text = self.name
            self.phoneNumTextField.text = self.phoneNum
            self.emailIdTextField.text = self.emailID
            self.dobTextField.text = self.dob
            self.genderTextField.text = self.gender
            let imageUrl = "http://happysanz.in/opsweb/assets/users/"
            self.userImage.sd_setImage(with: URL(string:imageUrl+profilePic), placeholderImage: UIImage(named:"profile-1"))
            self.profilePicURL = imageUrl+profilePic
//
        }
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    
    @IBAction func imageEditAction(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.openCamera()
        }))
            
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
                self.openGallary()
        }))
            
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
            
        self.present(alert, animated: true, completion: nil)
    }
        
    func openCamera(){
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
        
    //MARK: - Choose image from camera roll
        
    func openGallary(){
         imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
         //If you dont want to edit the photo then you can set allowsEditing to false
         imagePicker.allowsEditing = true
         imagePicker.delegate = self
         self.present(imagePicker, animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         uploadedImage = (info[.originalImage] as? UIImage)!
         if  let editedImage = info[.originalImage] as? UIImage
         {
             self.userImage.image = editedImage
             self.userImage.clipsToBounds = true
         }
         //Dismiss the UIImagePicker after selection
         self.picUploadAPI()
         picker.dismiss(animated: true, completion: nil)
    }
    
    func picUploadAPI ()
    {
        let imgData = uploadedImage.jpegData(compressionQuality: 0.75)
        if imgData == nil
        {
              //self.performSegue(withIdentifier: "back_selectPage", sender: self)
        }
        else
        {
            let functionName = "apiios/profilepic_update/"
            let baseUrl = "https://happysanz.in/opsweb/" + functionName + "\(GlobalVariables.shared.user_id)/"
            let url = URL(string: baseUrl)!
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData!, withName: "user_pic",fileName: "file.jpg", mimeType: "image/jpg")
            },
             to:url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                       upload.uploadProgress(closure: { (progress) in
                           print("Upload Progress: \(progress.fractionCompleted)")
                       })
                       upload.responseJSON { response in
                       print(response.result.value as Any)
                       //ActivityIndicator().hideActivityIndicator(uiView: self.view)
                       let JSON = response.result.value as? [String: Any]
                       let msg = JSON?["msg"] as? String
                       let status = JSON?["status"] as? String
                       GlobalVariables.shared.user_Image = (JSON?["picture_url"] as? String)!
                       print(msg!,status!,GlobalVariables.shared.user_Image)
                        
                                   
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }
    }
  
    @IBAction func saveProfileAction(_ sender: Any) {
        self.CheckValuesAreEmpty()
        
    }
    
    func updateAPI (user_id:String,full_name:String,phone_number:String,email_id:String,dob:String,gender:String)
    {
        presenterUpdate.attachView(view: self)
        presenterUpdate.getProfileUpdate(user_id:GlobalVariables.shared.user_id , full_name: full_name, phone_number: phone_number, email_id: email_id, gender: gender, dob: dob)
    }
    
    func startLoadingUpdate() {
//
    }
    
    func finishLoadingUpdate(){
//        
    }
    
    func setProfileUpdate(msg:String,status:String){
//        if  status == "success"{
////
//            let alertController = UIAlertController(title: Globals.alertTitle, message: msg, preferredStyle: .alert)
//
//            // Create the actions
//            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { [self]
//                UIAlertAction in
//                NSLog("OK Pressed")
//            }
//                alertController.addAction(okAction)
//
//            self.present(alertController, animated: true, completion: nil)
//        }
        self.performSegue(withIdentifier: "to_settings", sender: self)
    }
        
    func setEmptyUpdate(errorMessage:String){
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.genderArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return self.genderArr[row] // dropdown item
    }
    
}

extension UserProfile : UITextFieldDelegate, UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.nameTextField){
            self.phoneNumTextField.becomeFirstResponder()
        }
        else if (textField == self.phoneNumTextField){
            self.emailIdTextField.becomeFirstResponder()
        }
        else if (textField == self.emailIdTextField){
            self.dobTextField.becomeFirstResponder()
        }
        else if (textField == self.dobTextField){
            self.genderTextField.becomeFirstResponder()
        }

        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if nameTextField.isFirstResponder
        {
            let maxLength = 30
            let currentString: NSString = nameTextField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if phoneNumTextField.isFirstResponder
        {
            let maxLength = 10
            let currentString: NSString = phoneNumTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if emailIdTextField.isFirstResponder
        {
            let maxLength = 30
            let currentString: NSString = emailIdTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if dobTextField.isFirstResponder
        {
            let maxLength = 30
            let currentString: NSString = dobTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        else
        {
            let maxLength = 240
            let currentString: NSString = genderTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }

    }
    
    func showDatePicker(){
       //Formate Date
       datePicker.datePickerMode = .date
       datePicker.backgroundColor = UIColor.white
       datePicker.setValue(UIColor.black, forKeyPath: "textColor")

       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       toolbar.backgroundColor = UIColor.white
       toolbar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
       let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
       toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        dobTextField.inputAccessoryView = toolbar
        dobTextField.inputView = datePicker

    }
    
    func FormattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }
            
    @objc func donedatePicker(){
       if dobTextField.isFirstResponder
       {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           dateFormatted = formatter.string(from: datePicker.date)
           selectedDate = datePicker.date
           let formatted = self.FormattedDateFromString(dateString: dateFormatted, withFormat: "dd-MM-YYYY")
           dobTextField.text = formatted
           self.view.endEditing(true)
       }
   }
    
    @objc func cancelDatePicker(){
       self.view.endEditing(true)
        
     }
    
    func createPickerView() {
         pickerView.dataSource = self
         pickerView.delegate = self
         pickerView.backgroundColor = UIColor.white
         pickerView.setValue(UIColor.black, forKeyPath: "textColor")
        
         let toolBar = UIToolbar()
         toolBar.sizeToFit()
         let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
         let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
         let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

         toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)
         toolBar.isUserInteractionEnabled = true
//       toolBar.barTintColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 248/255.0, alpha: 1.0)
         toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
         toolBar.isUserInteractionEnabled = true
         toolBar.isTranslucent = true
         genderTextField.inputView = pickerView
         genderTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
          let row = self.pickerView.selectedRow(inComponent: 0)
          self.pickerView.selectRow(row, inComponent: 0, animated: false)
          if self.genderTextField.isFirstResponder{
            genderTextField.text = self.genderArr[row]// selected item
          }
          self.genderTextField.resignFirstResponder()
          view.endEditing(true)
    }
    
    @objc func cancel() {
          view.endEditing(true)
    }
    
    func CheckValuesAreEmpty () {
        
          if self.nameTextField.text?.count == 0   {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "UserName is Empty", complition: {
                    
                  })
             }
           else if self.phoneNumTextField.text?.count == 0 {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "PhoneNumber is Empty", complition: {
                      
                    })
           }
           else if self.dobTextField.text?.count == 0 {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Select DOB", complition: {
                      
                    })
           }
           else if self.genderTextField.text?.count == 0 {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Select Gender", complition: {
                      
                    })
           }
           else {
            self.updateAPI(user_id:GlobalVariables.shared.user_id,full_name: self.nameTextField.text!, phone_number: self.phoneNumTextField.text!, email_id: self.emailIdTextField.text!, dob: self.dobTextField.text!, gender: self.genderTextField.text!)
            
            if from_userProfile == "To_userProfile" {
                self.performSegue(withIdentifier: "to_DashBoard", sender: self)
                print("1")
            }
            else {
                self.performSegue(withIdentifier: "to_settings", sender: self)
                print("2")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
       if (segue.identifier == "to_settings"){
        _ = segue.destination as! AppSettings
//          let vc = nav.topViewController as! TabbarController
//          vc.user_id  = self.user_id
       }
       else if(segue.identifier == "to_DashBoard") {
        _ = segue.destination as! UINavigationController
       }
    }
}
