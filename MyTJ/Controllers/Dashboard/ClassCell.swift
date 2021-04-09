//
//  ClassCell.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 08/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import BRCountDownView



class ClassCell: UITableViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var urlLbl: UILabel!
    @IBOutlet weak var stdNameLbl: UILabel!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var timer: UIView!
    @IBOutlet weak var timerWidth: NSLayoutConstraint!
    
    var seconds = 0
    
    
    lazy var countdownView: BRCountDownView = {
        let countdownView = BRCountDownView(timeSeconds: /* 30000 */ seconds)
        countdownView.animationStyle = .slideInFromBottom
        /** you can make animate that you would like to perform in this closure if you would.
         To do this, you should change animationStyle property to 'true'.
         */
        //    countdownView.animationStyle = .custom
        //    countdownView.customAnimation = {
        //      [unowned self] animateView, duration in
        //      UIView.animate(withDuration: duration, animations: {
        //        animateView.alpha = 0.0
        //      }, completion:{ finished in
        //        if finished {
        //          animateView.alpha = 1.0
        //        }
        //      })
        //    }
        
        countdownView.didFinish = {
            [unowned self] (countdownView) -> Void in
            
            DispatchQueue.main.async {
                //                self.checkTestLabel.text = "countdown is finished..."
            }
            
            /** you can again repeat countdown with seconds you want whenever you want. */
            // self.countdownView.repeatCountDown(in: 5)
        }
        
        countdownView.didRepeat = {
            [unowned self] (countdownView) -> Void in
            
            // it is fired when count-down repeat gets started.
            DispatchQueue.main.async {
                //                self.checkTestLabel.text = "countdown is repeated..."
            }
        }
        
        countdownView.didResume = {
            [unowned self] (countdownView) -> Void in
            /**
             do any task here if you need.
             */
            print("didResume!")
        }
        
        countdownView.didTerminate = {
            [unowned self] (countdownView) -> Void in
            /**
             do any task here if you need.
             */
            print("didTerminate!")
        }
        
        countdownView.didStop = {
            [unowned self] (countdownView) -> Void in
            /**
             do any task here if you need.
             */
            print("didStop!")
        }
        
        countdownView.isUserInteractionEnabled = true
        countdownView.didTouchBegin = {
            [unowned self] sender in
            
            print("didTouchBegin!?")
        }
        
        countdownView.didTouchEnd = {
            [unowned self] sender in
            
            print("didTouchEnd!?")
        }
        
        return countdownView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
