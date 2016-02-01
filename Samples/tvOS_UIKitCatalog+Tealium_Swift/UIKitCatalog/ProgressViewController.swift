/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demostrates how to use `UIProgressView`. The `UIProgressView`s are updated via Key Value Observing of an `NSProgress` object's `frationCompleted` property. The `NSProgress` is updated via a repeating timer.
*/

import UIKit

/**
    The KVO context for `ProgressViewController` instances. This provides a stable
    address to use as the `context` parameter for KVO observation methods.
*/
private var progressViewKVOContext = 0

class ProgressViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet var progressViews: [UIProgressView]!
    
    /**
        An `NSProgress` object who's `fractionCompleted` is observed using
        KVO to update the `UIProgressView`s' `progress` properties.
    */
    private let progress = NSProgress(totalUnitCount: 10)
    
    /**
        A repeating timer that, when fired, updates the `NSProgress` object's
        `completedUnitCount` property.
    */
    private var updateTimer: NSTimer?
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Register as an observer of the `NSProgress`'s `fractionCompleted` property.
        progress.addObserver(self, forKeyPath: "fractionCompleted", options: [.New], context: &progressViewKVOContext)
    }
    
    deinit {
        // Unregister as an observer of the `NSProgress`'s `fractionCompleted` property.
        progress.removeObserver(self, forKeyPath: "fractionCompleted")
    }
    
    // MARK: UIViewController

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Reset the completed progress of the `UIProgressView`s.
        for progressView in progressViews {
            progressView.setProgress(0.0, animated: false)
        }
        
        /*
            Reset the `completedUnitCount` of the `NSProgress` object and create
            a repeating timer to increment it over time.
        */
        progress.completedUnitCount = 0
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerDidFire", userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Stop the timer from firing.
        updateTimer?.invalidate()
    }
    
    // MARK: Key Value Observing (KVO)
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String: AnyObject]?, context: UnsafeMutablePointer<Void>) {
        // Check if this is the KVO notification for our `NSProgress` object.
        if context == &progressViewKVOContext && keyPath == "fractionCompleted" && object === progress {
            // Update the progress views.
            for progressView in progressViews {
                progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            }
        }
        else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }

    // MARK: Convenience
    
    func timerDidFire() {
        /*
            Update the `completedUnitCount` of the `NSProgress` object if it's
            not completed. Otherwise, stop the timer.
        */
        if progress.completedUnitCount < progress.totalUnitCount {
            progress.completedUnitCount += 1
        }
        else {
            updateTimer?.invalidate()
        }
    }
}
