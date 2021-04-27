//
//  Planable+HorizontalEdges.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension Planer {
    
    // MARK: Left Anchor
    
    @discardableResult
    func left(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutXAxisAnchor,
        priority: UILayoutPriority) -> Self {
        let constraint: NSLayoutConstraint
        switch relation {
        case .moreThanTo(let space):
            constraint = view.leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: space)
        case .lessThanTo(let space):
            constraint = view.leftAnchor.constraint(lessThanOrEqualTo: anchor, constant: space)
        case .equalTo(let space):
            constraint = view.leftAnchor.constraint(equalTo: anchor, constant: space)
        case .moreThan:
            constraint = view.leftAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .lessThan:
            constraint = view.leftAnchor.constraint(lessThanOrEqualTo: anchor)
        case .equal:
            constraint = view.leftAnchor.constraint(equalTo: anchor)
        }
        constraint.priority = priority
        constraint.identifier = "draftsman_\(view.uniqueKey)_left_to_\(identifier(ofSecondItemIn: constraint))"
        plannedConstraints.removeAll { $0.identifier == constraint.identifier }
        plannedConstraints.append(constraint)
        return self
    }
    
    @discardableResult
    func left(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutXAxisAnchor) -> Self {
        return left(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func left(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutXAxisAnchor>) -> Self {
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
        return left(
            relation.add(offset: offsettedAnchor.offset),
            to: offsettedAnchor.anchor,
            priority: context.mutatingPriority
        )
    }
    
    @discardableResult
    func left(
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
            return leftToSafeArea(of: relatedView, relation: relation, priority: priority)
        } else {
            return left(relation, to: relatedView.leftAnchor, priority: priority)
        }
    }
    
    @discardableResult
    func left(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation) -> Self {
        return left(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    // MARK: Right Anchor
    
    @discardableResult
    func right(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutXAxisAnchor,
        priority: UILayoutPriority) -> Self {
        let constraint: NSLayoutConstraint
        switch relation {
        case .moreThanTo(let space):
            constraint = view.rightAnchor.constraint(lessThanOrEqualTo: anchor, constant: -space)
        case .lessThanTo(let space):
            constraint = view.rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -space)
        case .equalTo(let space):
            constraint = view.rightAnchor.constraint(equalTo: anchor, constant: -space)
        case .moreThan:
            constraint = view.rightAnchor.constraint(lessThanOrEqualTo: anchor)
        case .lessThan:
            constraint = view.rightAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .equal:
            constraint = view.rightAnchor.constraint(equalTo: anchor)
        }
        constraint.priority = priority
        constraint.identifier = "draftsman_\(view.uniqueKey)_right_to_\(identifier(ofSecondItemIn: constraint))"
        plannedConstraints.removeAll { $0.identifier == constraint.identifier }
        plannedConstraints.append(constraint)
        return self
    }
    
    @discardableResult
    func right(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: NSLayoutXAxisAnchor) -> Self {
        return right(relation, to: anchor, priority: context.mutatingPriority)
    }
    
    @discardableResult
    func right(
        _ relation: LayoutRelation<CGFloat>,
        to anchor: RelatedAnchor<NSLayoutXAxisAnchor>) -> Self {
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
        return right(
            relation.add(offset: offsettedAnchor.offset),
            to: offsettedAnchor.anchor,
            priority: context.mutatingPriority
        )
    }
    
    @discardableResult
    func right(
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
            return righttToSafeArea(of: relatedView, relation: relation, priority: priority)
        } else {
            return right(relation, to: relatedView.rightAnchor, priority: priority)
        }
    }
    
    @discardableResult
    func right(_ relation: LayoutRelation<CGFloat>, to anchor: AnonymousRelation) -> Self {
        return right(relation, to: anchor, priority: context.mutatingPriority)
    }
}

extension Planer {
    
    private func leftToSafeArea(
        of relatedView: UIView,
        relation: LayoutRelation<CGFloat>,
        priority: UILayoutPriority) -> Self {
        if #available(iOS 11.0, *) {
            let guide = relatedView.safeAreaLayoutGuide
            return left(relation, to: guide.leftAnchor, priority: priority)
        } else {
            let spaceAdded = relatedView.layoutMargins.left
            return left(relation.add(offset: spaceAdded), to: relatedView.leftAnchor, priority: priority)
        }
    }
    
    private func righttToSafeArea(
        of relatedView: UIView,
        relation: LayoutRelation<CGFloat>,
        priority: UILayoutPriority) -> Self {
        if #available(iOS 11.0, *) {
            let guide = relatedView.safeAreaLayoutGuide
            return right(relation, to: guide.rightAnchor, priority: priority)
        } else {
            let spaceAdded = relatedView.layoutMargins.right
            return right(relation.add(offset: spaceAdded), to: relatedView.rightAnchor, priority: priority)
        }
    }
}
#endif
