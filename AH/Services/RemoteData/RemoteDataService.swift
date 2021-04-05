//  
//  RemoteDataService.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift
import CoreData

final class RemoteDataService: RemoteDataUseCase {
    
    // MARK: - Private Properties
    
    private let network: Network
    private let database: CoreDataDatabase
    
    // MARK: - Properties
    
    var exhibitsCount: Int = .max
    
    
    // MARK: - Lifecycle
    
    init(network: Network, database: CoreDataDatabase) {
        self.network = network
        self.database = database
    }
    
    func fetchCollection(with params: BaseParameters) -> AsyncTask<Void> {
        network
            .reactive
            .request(API.RijksData.fetchCollection(parameters: params))
            .decode(CollectionResponse.self)
            .flatMap(.latest) { [unowned self] response -> AsyncTask<Void> in
                exhibitsCount = response.count
                return saveExhibits(response.exhibits)
            }
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
}
