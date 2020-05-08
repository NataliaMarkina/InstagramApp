//
//  ViewController.swift
//  InstagramApp
//
//  Created by Natalia on 08.05.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var progressBar: ProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.cyan
        
        progressBar = ProgressBar(countSegments: 5)
        progressBar.frame = CGRect(x: 15, y: 30, width: view.frame.width - 30, height: 6)
        
        view.addSubview(progressBar)
        
        progressBar.animation()
    }

    @IBAction func skip(_ sender: UITapGestureRecognizer) {
        progressBar.skip()
    }
    
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        progressBar.back()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

