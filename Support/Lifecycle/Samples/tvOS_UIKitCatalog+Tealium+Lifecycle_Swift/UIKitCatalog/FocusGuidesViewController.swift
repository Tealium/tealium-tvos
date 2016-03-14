/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to add and update `UIFocusGuide`s.
*/

import UIKit

class FocusGuidesViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet var topRightButton: UIButton!
    
    @IBOutlet var bottomLeftButton: UIButton!
    
    private var focusGuide: UIFocusGuide!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
            Create a focus guide to fill the gap below button 2 and to the right
            of button 3.
        */
        focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        
        // Anchor the top left of the focus guide.
        focusGuide.leftAnchor.constraintEqualToAnchor(topRightButton.leftAnchor).active = true
        focusGuide.topAnchor.constraintEqualToAnchor(bottomLeftButton.topAnchor).active = true
        
        // Anchor the width and height of the focus guide.
        focusGuide.widthAnchor.constraintEqualToAnchor(topRightButton.widthAnchor).active = true
        focusGuide.heightAnchor.constraintEqualToAnchor(bottomLeftButton.heightAnchor).active = true
    }

    // MARK: UIFocusEnvironment
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        
        /*
            Update the focus guide's `preferredFocusedView` depending on which
            button has the focus.
        */
        guard let nextFocusedView = context.nextFocusedView else { return }

        switch nextFocusedView {
            case topRightButton:
                focusGuide.preferredFocusedView = bottomLeftButton
            
            case bottomLeftButton:
                focusGuide.preferredFocusedView = topRightButton
            
            default:
                focusGuide.preferredFocusedView = nil
        }
    }
}
