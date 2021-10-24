//
//  UIViewControllerExpandable.swift
//  Series
//
//  Created by Jose Mendez on 24/10/21.
//

import UIKit

class UIViewControllerExpandable: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var titleExpanded: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableHeaderHeightConstraint: NSLayoutConstraint!
    //@IBOutlet weak var titleBottomConstraint: NSLayoutConstraint!

    let maxHeaderHeight: CGFloat = 40;
    let minHeaderHeight: CGFloat = 10;
    var previousScrollOffset: CGFloat = 0;
    
    var isScrollingDown: Bool = false;
    var isScrollingUp : Bool = false;
    var beginScroll: Bool = false;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateHeader()
        
        self.headerHeightConstraint.constant = maxHeaderHeight
        self.tableHeaderHeightConstraint.constant = maxHeaderHeight + 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrollViewDidScroll")
        //print(scrollView.contentOffset.y)
        if(scrollView.contentOffset.y <= -20){
            return
        }
        
        beginScroll = false;

        
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        self.isScrollingUp = isScrollingUp
        self.isScrollingDown = isScrollingDown
        
        //print("scrollDiff: \(scrollDiff) isScrollingDown: \(isScrollingDown) isScrollingUp: \(isScrollingUp)")
        if canAnimateHeader(scrollView) {
            // Calculate new header height
            var newHeight = self.headerHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                //we don't want to scroll right after scrolling up
                if(scrollView.contentOffset.y - abs(scrollDiff) < 1){
                    newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
                }
                else{
                    newHeight = self.headerHeightConstraint.constant //min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
                }
            }
            
            // Header needs to animate
            if newHeight != self.headerHeightConstraint.constant {
                self.headerHeightConstraint.constant = newHeight
                self.tableHeaderHeightConstraint.constant = newHeight + 40
                self.updateHeader()
                self.setScrollPosition(self.previousScrollOffset)
            }
            
            self.previousScrollOffset = scrollView.contentOffset.y
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //print("scrollViewDidEndDecelerating")
        
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            //print("scrollViewDidEndDragging")
            
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.beginScroll = true
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)
        
        if self.headerHeightConstraint.constant > midPoint || (self.beginScroll && isScrollingUp) {
            //print("expandHeader")
            
            if(self.headerHeightConstraint.constant != self.maxHeaderHeight){
                self.expandHeader()
            }
        } else {
            //print("collapseHeader")
            if(self.headerHeightConstraint.constant != self.minHeaderHeight){
                self.collapseHeader()
            }
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Calculate the size of the scrollView when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
        
        // Make sure that when header is collapsed, there is still room to scroll
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func collapseHeader() {
        if(!(isScrollingDown || isScrollingUp || beginScroll)){
            beginScroll = true;
            isScrollingUp = true;
        }
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.tableHeaderHeightConstraint.constant = self.minHeaderHeight + 40
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.tableHeaderHeightConstraint.constant = self.maxHeaderHeight + 40
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        
        //self.titleBottomConstraint.constant = 25 - ((1 - percentage) * 16)
        //self.subtitleExpanded.alpha = percentage
        
        if (self.headerHeightConstraint.constant > self.maxHeaderHeight){
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.tableHeaderHeightConstraint.constant = self.maxHeaderHeight + 40
        }
        //self.headerHeightConstraint.constant = self.maxHeaderHeight
        //self.tableHeaderHeightConstraint.constant = self.maxHeaderHeight + 50
        self.titleExpanded.numberOfLines = percentage > 0.8 ? 0 : 1
    }
}
