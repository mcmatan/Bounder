//
//  ViewController.swift
//  Bounder
//
//  Created by Matan Cohen on 7/23/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

import UIKit
import Bond
class ViewController: UIViewController, IBoundableView {
    var viewModel : ViewControllerViewModel!
    @IBOutlet weak var updatingValue: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var aboutMe: UITextView!
    @IBOutlet weak var writeSomthing: UITextField!
    @IBOutlet weak var logIn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewControllerViewModel()
        Bounder.bind(self, viewModel: self.viewModel)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        // Dispose of any resources that can be recreated.
    }

}

 