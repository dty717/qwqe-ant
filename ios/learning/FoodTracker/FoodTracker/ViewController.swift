//
//  ViewController.swift
//  FoodTracker
//
//  Created by dty on 2018/10/1.
//  Copyright © 2018年 dty. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var meal:Meal?
    
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var Input_name: UITextField!
    @IBOutlet weak var Image_test: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        Input_name.resignFirstResponder()
        let imgPickerController=UIImagePickerController()
        imgPickerController.sourceType = .photoLibrary
        imgPickerController.delegate=self;
        present(imgPickerController, animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentationController is UINavigationController;
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController=navigationController{
            owningNavigationController.popViewController(animated: true)
        }else{
            fatalError("The mealController is not inside a navigation controller.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button=sender as? UIBarButtonItem, button===saveButton else {
            os_log("The save button was not pressed, cancelling",log:OSLog.default,type: .debug)
            return
        }
        let name=Input_name.text ?? ""
        let photo=Image_test.image
        let rating = ratingControl.rating
        meal=Meal(name: name, rating: rating, photo: photo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Input_name.delegate=self
        if let meal=meal{
            navigationItem.title=meal.name
            Image_test.image=meal.photo
            ratingControl.rating=meal.rating
            Input_name.text=meal.name
        }
        updateButtonState();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateButtonState(){
        let text=Input_name.text ?? ""
        saveButton.isEnabled = !text.isEmpty;
    }
    
    
    // MARK: Action_test
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled=false;
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Lable_name.text=Input_name.text;
        updateButtonState()
        navigationItem.title=Input_name.text;
    }
    
    
    // MARK: Action_cancel_controller
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let Image_tap = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following :\(info)")
        }
        Image_test.image=Image_tap;
        dismiss(animated: true, completion: nil);
    }
    
}


