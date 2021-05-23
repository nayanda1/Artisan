//
//  Planable+VerticalEdges.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 27/04/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension Planer {
    
    // MARK: Top Anchor
    
    @discardableResult
    func top(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutYAxisAnchor,
        priority: UILayoutPriority) -> Self {
        let constraint: NSLayoutConstraint
        switch relation {
        case .moreThanTo(let space):
            constraint = view.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: space)
        case .lessThanTo(let space):
            constraint = view.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: space)
        case .equalTo(let space):
            constraint = view.topAnchor.constraint(equalTo: anchor, constant: space)
        case .moreThan:
            constraint = view.topAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .lessThan:
            constraint = view.topAnchor.constraint(lessThanOrEqualTo: anchor)
        case .equal:
            constraint = view.topAnchor.constraint(equalTo: anchor)
        }
        constraint.priority = priority
        constraint.identifier = "draftsman_\(view.uniqueKey)_top_to_\(identifier(ofSecondItemIn: constraint))"
        plannedConstraints.removeAll { $0.identifier == constraint.identifier }
        plannedConstraints.append(constraint)
        return self
    }
    
    @discardableResult
    func top(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutYAxisAnchor) -> Self {
        return top(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func top(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutYAxisAnchor>) -> Self {
        guard let offsettedAnchor = anchor.getOffsettedAnchor(from: context) else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenCreateConstraints(
                    of: Self.self,
                    failureReason: "Failed to get anchor of anonymous relation"
                )
            )
            return self
        }
        return top(
            relation.add(offset: offsettedAnchor.offset),
            to: offsettedAnchor.anchor,
            priority: context.mutatingPriority
        )
    }
    
    @discardableResult
    func top(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority) -> Self {
        guard let relatedView = getView(from: anchor) else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenCreateConstraints(
                    of: Self.self,
                    failureReason: "Failed to get related relation"
                )
            )
            return self
        }
        if anchor.isSafeArea {
            return topToSafeArea(of: relatedView, relation: relation, priority: priority)
        } else {
            return top(relation, to: relatedView.topAnchor, priority: priority)
        }
    }
    
    @discardableResult
    func top(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation) -> Self {
        return top(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    // MARK: Bottom Anchor
    
    @discardableResult
    func bottom(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutYAxisAnchor,
        priority: UILayoutPriority) -> Self {
        let constraint: NSLayoutConstraint
        switch relation {
        case .moreThanTo(let space):
            constraint = view.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: -space)
        case .lessThanTo(let space):
            constraint = view.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -space)
        case .equalTo(let space):
            constraint = view.bottomAnchor.constraint(equalTo: anchor, constant: -space)
        case .moreThan:
            constraint = view.bottomAnchor.constraint(lessThanOrEqualTo: anchor)
        case .lessThan:
            constraint = view.bottomAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .equal:
            constraint = view.bottomAnchor.constraint(equalTo: anchor)
        }
        constraint.priority = priority
        constraint.identifier = "draftsman_\(view.uniqueKey)_bottom_to_\(identifier(ofSecondItemIn: constraint))"
        plannedConstraints.removeAll { $0.identifier == constraint.identifier }
        plannedConstraints.append(constraint)
        return self
    }
    
    @discardableResult
    func bottom(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutYAxisAnchor) -> Self {
        return bottom(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func bottom(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutYAxisAnchor>) -> Self {
        guard let offsettedAnchor = anchor.getOffsettedAnchor(from: context) else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenCreateConstraints(
                    of: Self.self,
                    failureReason: "Failed to get anchor of anonymous relation"
                )
            )
            return self
        }
        return bottom(
            relation.add(offset: offsettedAnchor.offset),
            to: offsettedAnchor.anchor,
            priority: context.mutatingPriority
        )
    }
    
    @discardableResult
    func bottom(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation,
        priority: UILayoutPriority) -> Self {
        guard let relatedView = getView(from: anchor) else {
            context.delegate.planer(
                view,
                errorWhenPlanning: .whenCreateConstraints(
                    of: Self.self,
                    failureReason: "Failed to get related relation"
                )
            )
            return self
        }
        if anchor.isSafeArea {
            return bottomToSafeArea(of: relatedView, relation: relation, priority: priority)
        } else {
            return bottom(relation, to: relatedView.bottomAnchor, priority: priority)
        }
    }
    
    @discardableResult
    func bottom(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: AnonymousRelation) -> Self {
        return bottom(relation, to: anchor, priority: context.mutatingPriority)
    }
}

extension Planer {
    private func topToSafeArea(
        of relatedView: UIView,
        relation: LayoutRelation<CGFloat>,
        priority: UILayoutPriority) -> Self {
        if #available(iOS 11.0, *) {
            let guide = relatedView.safeAreaLayoutGuide
            return top(relation, to: guide.topAnchor, priority: priority)
        } else {
            let spaceAdded = relatedView.layoutMargins.top
            return top(relation.add(offset: spaceAdded), to: relatedView.topAnchor, priority: priority)
        }
    }
    
    private func bottomToSafeArea(
        of relatedView: UIView,
        relation: LayoutRelation<CGFloat>,
        priority: UILayoutPriority) -> Self {
        if #available(iOS 11.0, *) {
            let guide = relatedView.safeAreaLayoutGuide
            return bottom(relation, to: guide.bottomAnchor, priority: priority)
        } else {
            let spaceAdded = relatedView.layoutMargins.bottom
            return bottom(
                relation.add(offset: spaceAdded),
                to: relatedView.bottomAnchor,
                priority: priority
            )
        }
    }
}
#endif
