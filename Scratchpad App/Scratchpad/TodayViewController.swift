//
//  TodayViewController.swift
//  Scratchpad
//
//  Created by Satendra Dagar on 01/05/18.
//  Copyright © 2018 CB. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {
    
    @IBOutlet var noteTextView: NSTextView!
    override var nibName: NSNib.Name? {
        return NSNib.Name("TodayViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.isEditable = true
        noteTextView.becomeFirstResponder()
        loadPreviousData()
        
        NotificationCenter.default.addObserver(forName: NSTextView.didChangeSelectionNotification, object: noteTextView, queue: OperationQueue.current, using: {(_ note: Notification?) -> Void in
            print("Text: \(String(describing: self.noteTextView.textStorage?.string))")
            UserDefaults.standard.set(self.noteTextView.textStorage?.string, forKey: "LastSavedNote")
            UserDefaults.standard.synchronize()
        })
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        
        completionHandler(.noData)
    }
    
    func loadPreviousData() -> Void {
        let lastMsg = UserDefaults.standard.string(forKey: "LastSavedNote")
        self.noteTextView.string = lastMsg ?? ""
        
    }
}
