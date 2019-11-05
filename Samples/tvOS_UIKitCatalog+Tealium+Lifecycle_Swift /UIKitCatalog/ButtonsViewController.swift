/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use `UIButton`. The buttons are created using storyboards, but the attributed text button has its text set in code.
*/

import UIKit

class ButtonsViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var attributedTextButton: UIButton!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAttributedTextSystemButton()
    }
    
    // MARK: IB Actions
    
    @IBAction func buttonClicked(_ sender: AnyObject) {
        /*
            Clicking a button fires a UIControlEventPrimaryActionTriggered event.
            The buttons in this view controller have been setup in Interface Builder
            to call this action for the UIControlEventPrimaryActionTriggered event.
        */
        print("A button was clicked.")
        
        TealiumHelper.trackEvent("buttonClicked", dataSources: [String:String]())
    }
    
    // MARK: Convenience
    
    fileprivate func configureAttributedTextSystemButton() {
        let buttonTitle = NSLocalizedString("Button", comment: "")
        var normalTitleAttributes = [NSAttributedString.Key : Any]()
        var highlightedTitleAttributes = [NSAttributedString.Key : Any]()
        //var highlightedTitleAttributes = [NSAttributedString.Key : Any]()
        // Set the button's title for normal state.
        normalTitleAttributes  = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let normalAttributedTitle = NSAttributedString(string: buttonTitle, attributes: normalTitleAttributes)
        attributedTextButton.setAttributedTitle(normalAttributedTitle, for: UIControl.State())
        
        // Set the button's title for highlighted state.
        highlightedTitleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.green,
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.thick.rawValue
        ]
        
        let highlightedAttributedTitle = NSAttributedString(string: buttonTitle, attributes: highlightedTitleAttributes)
        attributedTextButton.setAttributedTitle(highlightedAttributedTitle, for: .highlighted)
    }
}
