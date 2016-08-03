//
//  DetailViewController.swift
//  SwiftCommonApp
//
//  Created by John O'Sullivan on 8/2/16.
//  Copyright © 2016 John O'Sullivan. All rights reserved.
//

import UIKit

import SwiftCommon

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    func getLocalEnglishMoment(date: NSDate) -> Moment {
        return moment(date, timeZone: NSTimeZone.defaultTimeZone(),
                      locale: NSLocale(localeIdentifier: "en"))
    }
    func configureView() {
        
        let now = NSDate()
        let nowMoment = getLocalEnglishMoment(now)
        print(nowMoment.description)
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("timeStamp")!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

