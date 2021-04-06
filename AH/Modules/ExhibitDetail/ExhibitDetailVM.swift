//
//  ExhibitDetailVM.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import Foundation
import ReactiveSwift

protocol ExhibitDetailVMDelegate: AnyObject {
    
}

final class ExhibitDetailVM: UseCasesConsumer {
    typealias UseCases = HasInformationUseCase

    // MARK: - Public Properties
    
    let exhibitWithDetails: ExhibitWithDetails
    let detailsDataSource: [ExhibitDetail]
//    private(set) var sortedTypes: [Type]
    
    // MARK: - Private Properties
    
    private weak var delegate: ExhibitDetailVMDelegate?
    
    // MARK: - Life Cycle
    
    init(exhibitWithDetails: ExhibitWithDetails, useCases: UseCases, delegate: ExhibitDetailVMDelegate) {
        self.exhibitWithDetails = exhibitWithDetails
        detailsDataSource = useCases.information.tvDataSource(from: exhibitWithDetails)
        self.useCases = useCases
        self.delegate = delegate
    }
}
