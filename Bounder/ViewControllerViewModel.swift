//
//  ViewControllerViewModel.swift
//  Bounder
//
//  Created by Matan Cohen on 7/23/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

import UIKit
import Foundation
import Bond

class ViewControllerViewModel: NSObject, IBoundableViewModel {
    var popUpPresener = PopUpPresenter()
    var view : IBoundableView!
    var updatingValue = Dynamic<String>("Starting value")
    var name = Dynamic<NSAttributedString>(NSAttributedString())
    var aboutMe = Dynamic<String>("I like coding stuff")
    var writeSomthing = Dynamic<String>("")
    var writeSomthingPlaceHolder = Dynamic<String>("Write here")
    var profileImage = Dynamic<UIImage?>(UIImage())
    var logInTapListener = Bond<UIControlEvents>()
    var logInEnabled = Dynamic<Bool>(false)

    override init() {
        super.init()
        self.startUpdating()
        var attString = NSAttributedString(string: "My name is Matan", attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
        self.name.value = attString
        self.profileImage.value = UIImage(named: "images.jpeg")!
        self.logInTapListener = Bond<UIControlEvents>() { [weak self] event in
            self?.showPopUp()
        }
        self.logInEnabled = writeSomthing.map { count($0) >= 3 }
    }
    
    func showPopUp() {
        
        var title = "Did press"
        var message = "Content message"
        var cancelButton = ButtonAction(title: "Cancel", handler: { (ButtonAction) -> Void in
            println("Did press cancel")
        })
        var someEtherButton = ButtonAction(title: "Done", handler: { (ButtonAction) -> Void in
            println("Did press done")
        })

        var moreButton = ButtonAction(title: "More", handler: { (ButtonAction) -> Void in
            println("Did press moreButton")
        })

        self.popUpPresener.presentPopUp(title, message: message, cancelButton: cancelButton, buttons: [someEtherButton, moreButton]) { () -> Void in
            println("Did present")
        }
    }
    
    func setBondableView(view : IBoundableView) {
        self.view = view
    }
    
    func startUpdating() {
        var updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "changeText", userInfo: nil, repeats: true)
    }
    func changeText() {
        var tempName = self.randomStringWithLength(5) as? String
        var txt = ""
        if let tempName = tempName {
            txt = tempName
        } else {
            txt = "some initial value"
        }
        
        self.updatingValue.value = txt
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
}
