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
    
    fileprivate func configureCustomBackgroundSegmentedControl() {
        // Set the background images for each control state.
        let normalSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background")
        customBackgroundSegmentedControl.setBackgroundImage(normalSegmentBackgroundImage, for: UIControl.State(), barMetrics: .default)

        let disabledSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background_disabled")
        customBackgroundSegmentedControl.setBackgroundImage(disabledSegmentBackgroundImage, for: .disabled, barMetrics: .default)

        let highlightedSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background_highlighted")
        customBackgroundSegmentedControl.setBackgroundImage(highlightedSegmentBackgroundImage, for: .highlighted, barMetrics: .default)

        // Set the divider image.
        let segmentDividerImage = UIImage(named: "stepper_and_segment_divider")
        customBackgroundSegmentedControl.setDividerImage(segmentDividerImage, forLeftSegmentState: UIControl.State(), rightSegmentState: UIControl.State(), barMetrics: .default)

        // Create a font to use for the attributed title (both normal and highlighted states).
        let captionFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.caption1)
        let font = UIFont(descriptor: captionFontDescriptor, size: 0)

        let normalTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.purple,
            NSAttributedString.Key.font: font
        ]
        customBackgroundSegmentedControl.setTitleTextAttributes(normalTextAttributes, for: UIControl.State())

        let highlightedTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.purple,
            NSAttributedString.Key.font: font
        ]
        customBackgroundSegmentedControl.setTitleTextAttributes(highlightedTextAttributes, for: .highlighted)
    }
}
