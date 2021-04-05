//
//  Reactive+UIView.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift
import ReactiveCocoa
import UIKit

extension Reactive where Base: UIView {
    var layoutSubviews: Signal<Void, Never> { trigger(for: #selector(Base.layoutSubviews)) }
    var setNeedsLayout: Signal<Void, Never> { trigger(for: #selector(Base.setNeedsLayout)) }
    var layoutIfNeeded: Signal<Void, Never> { trigger(for: #selector(Base.layoutIfNeeded)) }
}
