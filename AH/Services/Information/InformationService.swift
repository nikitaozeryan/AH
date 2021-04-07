//  
//  RemoteDataService.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift
import CoreData

typealias ExhibitWithDetails = (exhibit: Exhibit, details: ExhibitDetails)
typealias ExhibitDetail = (title: String, detail: String)
final class InformationService: InformationUseCase {
    
    // MARK: - Private Properties
    
    private let network: Network
    private let database: CoreDataDatabase
    
    // MARK: - Properties
    
    var exhibitsCount: MutableProperty<Int> = .init(.max)
    var setupProducer: SignalProducer<CoreDataStack, AppError> {
        database.setupProducer
    }
    
    
    // MARK: - Lifecycle
    
    init(network: Network, database: CoreDataDatabase) {
        self.network = network
        self.database = database
    }
    
    func fetchAndSaveCollection(with params: BaseParameters) -> AsyncTask<Void> {
        fetchCollection(with: params)
            .flatMap(.latest) { [unowned self] response -> AsyncTask<Void> in
                exhibitsCount.value = response.count
                return saveExhibits(response.exhibits)
            }
    }
    
    func fetchExhibitDetails(with params: ExhibitDetailParameters) -> AsyncTask<ExhibitWithDetails?> {
        fetchExhibitDetails(with: params.objectNumber)
            .flatMapError { [unowned self] _ -> AsyncTask<ExhibitWithDetails?> in
                self.getExhibitDetails(with: params)
            }
    }
    
    func tvDataSource(from information: ExhibitWithDetails) -> [ExhibitDetail] {
        var details: [ExhibitDetail] = []
        with(information) {
            $0.details.createdOn.flatMap { details.append(((localizedString(key: "exhibitDetailVC.createdOn")), $0)) }
            $0.details.updatedOn.flatMap { details.append(((localizedString(key: "exhibitDetailVC.updatedOn")), $0)) }
            $0.details.dating.flatMap {
                details.append(((localizedString(key: "exhibitDetailVC.presentingDate")), $0.presentingDate))
                details.append(((localizedString(key: "exhibitDetailVC.period")), "\($0.period)"))
            }
            $0.details.artist.flatMap { details.append(((localizedString(key: "exhibitDetailVC.artist")), $0)) }
            if !$0.details.productionPlaces.isEmpty {
                details.append(((localizedString(key: "exhibitDetailVC.productionPlaces")), $0.details.productionPlaces.joined(separator: ",\n")))
            }
            if !$0.details.materials.isEmpty {
                details.append(((localizedString(key: "exhibitDetailVC.materials")), $0.details.materials.joined(separator: ",\n")))
            }
            if !$0.details.techniques.isEmpty {
                details.append(((localizedString(key: "exhibitDetailVC.techniques")), $0.details.techniques.joined(separator: ",\n")))
            }
            
        }
        return details
    }
    
    func exhibitsFetchRequest() -> NSFetchRequest<ExhibitEntity> {
        let fetchRequest = NSFetchRequest<ExhibitEntity>(entityName: String(describing: ExhibitEntity.self))
        let sortDescriptor = NSSortDescriptor(keyPath: \ExhibitEntity.painter, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func fetchCollection(with params: BaseParameters) -> AsyncTask<CollectionResponse> {
        network
            .reactive
            .request(API.RijksData.fetchCollection(parameters: params))
            .decode(CollectionResponse.self)
    }
    
    // MARK: - Helper methods
    
    private func save(_ context: NSManagedObjectContext) {
        context.performAndWait {
            guard context.hasChanges else { return }
            do {
                try context.save()
            } catch {
                #if DEBUG
                print(error)
                #endif
            }
        }
        context.parent?.performAndWait {
            guard context.parent?.hasChanges ?? false else { return }
            do {
                try context.parent?.save()
            } catch {
                #if DEBUG
                print(error)
                #endif
            }
        }
    }
    
    private func handle(_ image: Image,
                        in context: NSManagedObjectContext,
                        to exhibitEntity: ExhibitEntity) throws {
        let imageEntity = try context.fetchOrCreate(entity: ImageEntity.self,
                                                   with: ImageEntity.findPredicate(id: image.id))
        try image.update(imageEntity)
        exhibitEntity.image = imageEntity
        imageEntity.exhibit = exhibitEntity
    }
    
    private func saveExhibits(_ exhibits: [Exhibit]) -> AsyncTask<Void> {
        guard !exhibits.isEmpty else { return .empty }
        return database.performToChildViewContext { [unowned self] context -> Void in
            try exhibits.forEach{ exhibit in
                let exhibitEntity = try context.fetchOrCreate(for: exhibit,
                                                              with: ExhibitEntity.findPredicate(id: exhibit.id))
                try exhibit.update(exhibitEntity)
                try exhibit.image.flatMap { try handle($0, in: context, to: exhibitEntity) }
            }
            self.save(context)
        }.flatMapError { _ -> AsyncTask<Void> in .init(value: ()) }
    }
    
    private func saveDetailsAndFetchInfo(_ exhibitDetails: ExhibitDetails) -> AsyncTask<ExhibitWithDetails?> {
        database.performToChildViewContext { [unowned self] context -> ExhibitWithDetails? in
            let detailsEntity = try context.fetchOrCreate(for: exhibitDetails,
                                                          with: ExhibitDetailsEntity.findPredicate(id: exhibitDetails.id))
            try exhibitDetails.update(detailsEntity)
            self.save(context)
            
            let exhibitEntity = try context.fetchFirst(typeEntity: ExhibitEntity.self,
                                                       predicate: ExhibitEntity.findPredicate(id: exhibitDetails.id))
            
            return (Exhibit(from: exhibitEntity), ExhibitDetails(from: detailsEntity))
        }
    }
    
    private func getExhibitDetails(with params: ExhibitDetailParameters) -> AsyncTask<ExhibitWithDetails?> {
        network.reactive
            .request(API.RijksData.fetchExhibitDetails(parameters: params))
            .decode(ExhibitDetails.Response.self)
            .map(ExhibitDetails.init)
            .flatMap(.latest) { [unowned self] details -> AsyncTask<ExhibitWithDetails?> in
                self.saveDetailsAndFetchInfo(details)
            }
    }
    
    private func fetchExhibitDetails(with id: String) -> AsyncTask<ExhibitWithDetails?> {
        database.performToChildViewContext { context -> ExhibitWithDetails? in
            let detailsEntity = try context.fetchFirst(typeEntity: ExhibitDetailsEntity.self,
                                   predicate: ExhibitDetailsEntity.findPredicate(id: id))
            let exhibitEntity = try context.fetchFirst(typeEntity: ExhibitEntity.self,
                                                       predicate: ExhibitEntity.findPredicate(id: detailsEntity.id))
            
            return (Exhibit(from: exhibitEntity), ExhibitDetails(from: detailsEntity))
        }
    }
}
