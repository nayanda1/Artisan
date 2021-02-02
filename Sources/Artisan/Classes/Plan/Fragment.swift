//
//  Fragment.swift
//  Artisan
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
import UIKit

public protocol Fragment {
    func fragmentWillPlanContent()
    func planContent(_ plan: InsertablePlan)
    func fragmentDidPlanContent()
}

public extension Fragment {
    func fragmentWillPlanContent() { }
    func fragmentDidPlanContent() { }
}

public extension Fragment where Self: UIView {
    
    func planFragment(delegate: PlanDelegate? = nil) {
        let layoutPlaner = LayoutPlaner<Self>(view: self, context: .init(delegate: delegate, currentView: self))
        fragmentWillPlanContent()
        layoutPlaner.planContent(self.planContent(_:))
        fragmentDidPlanContent()
        NSLayoutConstraint.activate(layoutPlaner.plannedConstraints)
    }
    
    func replanContent(delegate: PlanDelegate? = nil) {
        removeAllPlannedConstraints()
        planFragment(delegate: delegate)
    }
}