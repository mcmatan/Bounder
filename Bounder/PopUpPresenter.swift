//
//  PopUpPresenter.swift
//  Bounder
//
//  Created by Matan Cohen on 7/26/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

import Foundation
import UIKit

class ButtonAction  {
    var title: String
    var handler : ((ButtonAction!) -> Void)!
    init(title: String, handler: ((ButtonAction!) -> Void)!) {
        self.title = title
        self.handler = handler
    }
}


class PopUpPresenter {

    func presentPopUp(title : String, message : String , cancelButton : ButtonAction! , buttons : [ButtonAction]! , completion : (() -> Void)? ){
        var view = UIApplication.sharedApplication().keyWindow?.rootViewController
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        if let isButtons = buttons {
            for buttonAction in buttons {
                alert.addAction(UIAlertAction(title: buttonAction.title, style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                    buttonAction.handler(buttonAction)
                }))
            }
        }
        
        if let isCancelButton = cancelButton {
            alert.addAction(UIAlertAction(title: isCancelButton.title, style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
                isCancelButton.handler(isCancelButton)
            }))
        }

        view!.presentViewController(alert, animated: true, completion: completion)
    }
}