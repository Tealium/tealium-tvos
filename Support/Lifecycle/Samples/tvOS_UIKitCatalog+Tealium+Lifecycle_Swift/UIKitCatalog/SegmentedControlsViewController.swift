/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use `UISegmentedControl`.
*/

import UIKit

class SegmentedControlsViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var customBackgroundSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCustomBackgroundSegmentedControl()
    }
    
    private func configureCustomBackgroundSegmentedControl() {
        // Set the background images for each control state.
        let normalSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background")
        customBackgroundSegmentedControl.setBackgroundImage(normalSegmentBackgroundImage, forState: .Normal, barMetrics: .Default)

        let disabledSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background_disabled")
        customBackgroundSegmentedControl.setBackgroundImage(disabledSegmentBackgroundImage, forState: .Disabled, barMetrics: .Default)

        let highlightedSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background_highlighted")
        customBackgroundSegmentedControl.setBackgroundImage(highlightedSegmentBackgroundImage, forState: .Highlighted, barMetrics: .Default)

        // Set the divider image.
        let segmentDividerImage = UIImage(named: "stepper_and_segment_divider")
        customBackgroundSegmentedControl.setDividerImage(segmentDividerImage, forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)

        // Create a font to use for the attributed title (both normal and highlighted states).
        let captionFontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleCaption1)
        let font = UIFont(descriptor: captionFontDescriptor, size: 0)

        let normalTextAttributes = [
            NSForegroundColorAttributeName: UIColor.purpleColor(),
            NSFontAttributeName: font
        ]
        customBackgroundSegmentedControl.setTitleTextAttributes(normalTextAttributes, forState: .Normal)

        let highlightedTextAttributes = [
            NSForegroundColorAttributeName: UIColor.purpleColor(),
            NSFontAttributeName: font
        ]
        customBackgroundSegmentedControl.setTitleTextAttributes(highlightedTextAttributes, forState: .Highlighted)
    }
}
