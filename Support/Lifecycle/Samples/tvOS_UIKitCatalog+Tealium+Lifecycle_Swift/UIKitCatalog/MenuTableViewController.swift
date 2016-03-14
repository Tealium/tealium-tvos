/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A `UITableViewController` that, when subclassed, is used as the master view of `MenuSplitViewController` instances. Each subclass specifies a mapping of segue names to perform for each static cell in its storyboard instance.
*/

import UIKit

class MenuTableViewController: UITableViewController {
    // MARK: Properties
    
    /**
        A matrix of segue identifiers that should be performed when a cell
        becomes focused.
    
        Overridden by subclasses.
    */
    var segueIdentifierMap: [[String]] {
        return [[]]
    }
    
    private var lastPerformedSegueIdentifier: String?
    
    private let delayedSeguesOperationQueue = NSOperationQueue()
    
    private static let performSegueDelay: NSTimeInterval = 0.1
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
            Set `remembersLastFocusedIndexPath` to `true` to ensure the same row
            becomes focused whenever focus is returned to the table view.
        */
        tableView.remembersLastFocusedIndexPath = true
        
        /*
            Adjust the layout margins of the `tableView` to add a horizontal inset
            to the cells. This will allow for overscan on older TVs and space for
            the focus effect.
        */
        tableView.layoutMargins.left = 90
        tableView.layoutMargins.right = 20
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        // Check if the requested segue is a segue contained in our mapping.
        guard segueIdentifierMap.contains({ $0.contains(identifier) }) else { return true }
        
        // Don't perform the segue if it's the same as the last performed segue.
        return identifier != lastPerformedSegueIdentifier
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let menuSplitViewController = splitViewController as? MenuSplitViewController else { return }
       
        /*
            Ask the containing `MenuSplitViewController` to move the focus to the
            current detail view controller.
        */
        menuSplitViewController.updateFocusToDetailViewController()
    }
    
    override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        // Check that the next focus view is a child of the table view.
        guard let nextFocusedView = context.nextFocusedView where nextFocusedView.isDescendantOfView(tableView) else { return }
        guard let indexPath = context.nextFocusedIndexPath else { return }

        // Cancel any previously queued segues.
        delayedSeguesOperationQueue.cancelAllOperations()

        // Create an `NSBlockOperation` to perform the detail segue after a delay.
        let performSegueOperation = NSBlockOperation()
        let segueIdentifier = segueIdentifierMap[indexPath.section][indexPath.row]
        
        performSegueOperation.addExecutionBlock { [weak self, unowned performSegueOperation] in
            // Pause the block so the segue isn't immediately performed.
            NSThread.sleepForTimeInterval(MenuTableViewController.performSegueDelay)
            
            /*
                Check that the operation wasn't cancelled and that the segue identifier
                is different to the last performed segue identifier.
            */
            guard !performSegueOperation.cancelled && segueIdentifier != self?.lastPerformedSegueIdentifier else { return }
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                // Perform the segue to show the detail view controller.
                self?.performSegueWithIdentifier(segueIdentifier, sender: nextFocusedView)
                
                // Record the last performed segue identifier.
                self?.lastPerformedSegueIdentifier = segueIdentifier
                
                /*
                    Select the focused cell so that the table view visibly reflects
                    which detail view is being shown.
                */
                self?.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            }
        }
        
        delayedSeguesOperationQueue.addOperation(performSegueOperation)
    }
}
