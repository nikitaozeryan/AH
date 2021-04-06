//  
//  RemoteDataUseCase.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift
import CoreData

protocol InformationUseCase {
    var setupProducer: SignalProducer<CoreDataStack, AppError> { get }
    var exhibitsCount: MutableProperty<Int> { get }
    
    func fetchCollection(with params: BaseParameters) -> AsyncTask<Void>
    func fetchExhibitDetails(with params: ExhibitDetailParameters) -> AsyncTask<ExhibitWithDetails?>
    func tvDataSource(from information: ExhibitWithDetails) -> [ExhibitDetail]
    func exhibitsFetchRequest() -> NSFetchRequest<ExhibitEntity>
}
