//
//  Bounder.swift
//  Bounder
//
//  Created by Matan Cohen on 7/23/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

import Foundation
import UIKit
import Bond

var textFiledPlaceHolderDeclaration = "PlaceHolder"
var btnTapDeclaration = "TapListener"
var btnEnableDeclaration = "Enabled"

protocol IBoundableView {

}

protocol IBoundableViewModel {
    func setBondableView(view : IBoundableView)
}


class Bounder {
    
    class func bind<T : IBoundableView , E : IBoundableViewModel>(view : T, viewModel : E) {
        var viewPropertyNameForValue = getPropertyValueForName(view)
        var viewModelPropertyNameForValue = getPropertyValueForName(viewModel)
        bindViewPropertiesToViewModel(viewPropertyNameForValue, viewModelPropertiesValueForName: viewModelPropertyNameForValue)
        viewModel.setBondableView(view)
    }
    
    class func getPropertyValueForName<T>(viewModel : T)-> [String : Any] {

        let obj = viewModel
        let reflected = reflect(obj)
        var properties = [String : Any]()
        for index in 0..<reflected.count {
            properties[reflect(viewModel)[index].0] = reflected[index].1.value
        }
        return properties
    }
    
    class func bindViewPropertiesToViewModel(viewPropertiesValueForName : [String : Any], viewModelPropertiesValueForName : [String : Any]) {
        for viewPropertyName in viewPropertiesValueForName.keys {
            var viewModelPropertyName = viewPropertyName
            
            if let isViewModelProperty = viewModelPropertiesValueForName[viewModelPropertyName] {
                var viewProperty = viewPropertiesValueForName[viewPropertyName]
                
                if viewProperty is UILabel {
                            if let isViewModelProperty = viewModelPropertiesValueForName[viewModelPropertyName] as? Dynamic<String> {
                                    if let viewPropertyAsLabel = viewProperty as? UILabel {
                                            isViewModelProperty <->> viewPropertyAsLabel.dynText
                                    }
                            }
                }
                
                if viewProperty is UITextField {
                    if let isViewModelProperty = viewModelPropertiesValueForName[viewModelPropertyName] as? Dynamic<String> {
                        if let viewPropertyAsLabel = viewProperty as? UITextField {
                            isViewModelProperty <->> viewPropertyAsLabel.dynText
                            
                            if let isViewModelPlaceHolderProperty = viewModelPropertiesValueForName[viewModelPropertyName + textFiledPlaceHolderDeclaration] as? Dynamic<String>{
                                viewPropertyAsLabel.placeholder = isViewModelPlaceHolderProperty.value
                            }
                        }
                    }
                }
                
                if viewProperty is UITextView {
                    if let isViewModelProperty = viewModelPropertiesValueForName[viewModelPropertyName] as? Dynamic<String> {
                        if let viewPropertyAsLabel = viewProperty as? UITextView {
                            isViewModelProperty <->> viewPropertyAsLabel.dynText
                        }
                    }
                }
                
                if viewProperty is UIImageView {
                    if let isViewModelProperty = viewModelPropertiesValueForName[viewModelPropertyName] as? Dynamic<UIImage?> {
                        if let viewPropertyAsLabel = viewProperty as? UIImageView {
                            isViewModelProperty ->> viewPropertyAsLabel.dynImage
                        }
                    }
                }
                
            
                
            } else {
                
                if let isViewModelProperty = viewModelPropertiesValueForName[viewModelPropertyName + btnTapDeclaration] {
                    var viewProperty = viewPropertiesValueForName[viewPropertyName]
                    if viewProperty is UIButton {
                        if let isViewModelListenerProperty = viewModelPropertiesValueForName[viewModelPropertyName + btnTapDeclaration] as? Bond<UIControlEvents> {
                            if let viewPropertyAsButton = viewProperty as? UIButton {
                                viewPropertyAsButton.dynEvent.filter(==, .TouchUpInside) ->> isViewModelListenerProperty
                            }
                        }
                        if let isViewModelEnableProperty = viewModelPropertiesValueForName[viewModelPropertyName + btnEnableDeclaration] as? Dynamic<Bool> {
                            if let viewPropertyAsButton = viewProperty as? UIButton {
                                isViewModelEnableProperty ->> viewPropertyAsButton.dynEnabled
                            }
                        }
                        

                    }
                }
                
            }
            
            
        }
    }
    
    
}