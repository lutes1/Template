//
//  DIContainer.swift
//  Template
//
//  Created by Petru Lutenco on 31.10.2023.
//

import Swinject
import SwinjectAutoregistration
import Foundation

public class DIContainer {
    private init() { }
    public static let shared = DIContainer()
    
    private let container = Container()
    
    public func resolve<T>(_ type: T.Type) -> T {
        container.resolve(type)
    }
    
    public func resolveMock<T>(_ type: T.Type) -> T {
        guard let resolved = container.resolve(type, name: _mockTypeName(type)) else {
            fatalError(
                """
                Type \(type) was not registered with registerMock in the container. 
                Please use registerMock to register a mock for \(String(describing: T.self)).
                """)
        }
        
        return resolved
    }
    
    /** Registers a factory that resolves the mocked Service based on dependencies inferred from the
     Service initializer that takes one already registered service.
     
     Usage: `registerMock(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered mocked service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func registerMock<T>(
        _ type: T.Type,
        with initializer: @escaping () -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            name: _mockTypeName(type),
            initializer: initializer
        )
        .inObjectScope(
            scope.toObjectScope()
        )
    }

    /** Registers an object that will be resolved as for the provided Service type.
     
     Usage: `register(MyService.self), as: objectOfTypeMyService)`
     - Parameters:
     - service: Registered service type
     - as: An object of type MyService
     */
    public func register<T>(_ type: T.Type, as object: T, scope: DIScope = .graph) {
        container.register(
            type,
            factory: { r in object }
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on a factory that provides a resolver 
     for eventual dependencies
     
     Usage: `register(MyService.self), factory: { r in let dependency = r.resolver(Dependency.self) 
     return Service(dependency) }`
     - Parameters:
     - service: Registered service type
     - factory: A factory that provides a resolver for eventual dependencies
     */
    public func register<T>(
        _ type: T.Type,
        factory: @escaping (DIResolver) -> T,
        scope: DIScope = .graph
    ) {
        // r will always be a Container which conforms to both Resolver and DIResolver
        
        container.register(
            type,
            factory: { (r: Resolver) in factory(r as! DIResolver)}
        )
        .inObjectScope(scope.toObjectScope())
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the 
     Service initializer that takes no registered parameters. It also allows to configure the resolved services
     with dependencies that may be circular.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - initCompleted: runs when the init has completed and allows to configure the service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T>(
        _ type: T.Type,
        with initializer: @escaping () -> T,
        scope: DIScope = .graph,
        initCompleted: @escaping (DIResolver, T) -> Void
    ) {
        container.autoregister(
            T.self, initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        ).initCompleted(
            { (r: Resolver, object) in initCompleted(r as! DIResolver, object) }
        )
    }
    
    /**  Registers a factory that resolves the Service based on dependencies inferred from the 
     Service initializer that takes one registered parameters. It also allows to configure the resolved services
     with dependencies that may be circular.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - initCompleted: runs when the init has completed and allows to configure the service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A>(
        _ type: T.Type,
        with initializer: @escaping (A) -> T,
        scope: DIScope = .graph,
        initCompleted: @escaping (DIResolver, T) -> Void
    ) {
        container.autoregister(
            T.self, initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        ).initCompleted(
            { (r: Resolver, object) in initCompleted(r as! DIResolver, object) }
        )
    }
    
    /**  Registers a factory that resolves the Service based on dependencies inferred from the 
     Service initializer that takes two registered parameters. It also allows to configure the resolved services
     with dependencies that may be circular.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - initCompleted: runs when the init has completed and allows to configure the service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2>(
        _ type: T.Type,
        with initializer: @escaping (A, A2) -> T,
        scope: DIScope = .graph,
        initCompleted: @escaping (DIResolver, T) -> Void
    ) {
        container.autoregister(
            T.self, initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        ).initCompleted(
            { (r: Resolver, object) in initCompleted(r as! DIResolver, object) }
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the 
     Service initializer that takes one already registered service.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T>(
        _ type: T.Type,
        with initializer: @escaping () -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the Service
     initializer that takes 2 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A>(
        _ type: T.Type,
        with initializer: @escaping (A) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self, initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the Service
     initializer that takes 3 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2>(
        _ type: T.Type,
        with initializer: @escaping (A, A2) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the Service
     initializer that takes 3 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the 
     Service initializer that takes 4 already registered services as arguments
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3, A4>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3, A4) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the 
     Service initializer that takes 5 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3, A4, A5>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3, A4, A5) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the
     Service initializer that takes 6 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3, A4, A5, A6>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3, A4, A5, A6) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the
     Service initializer that takes 7 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3, A4, A5, A6, A7>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3, A4, A5, A6, A7) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the
     Service initializer that takes 8 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3, A4, A5, A6, A7, A8>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3, A4, A5, A6, A7, A8) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the
     Service initializer that takes 9 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3, A4, A5, A6, A7, A8, A9>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3, A4, A5, A6, A7, A8, A9) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the
     Service initializer that takes 10 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3, A4, A5, A6, A7, A8, A9, A10>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3, A4, A5, A6, A7, A8, A9, A10) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    /** Registers a factory that resolves the Service based on dependencies inferred from the
     Service initializer that takes 11 already registered services as arguments.
     
     Usage: `register(MyService.self), initializer: MyService.init`
     - Parameters:
     - service: Registered service type
     - initializer: Initializer of the registered service
     - Important: Might fail if one of the dependencies is unresolvable.
     */
    public func register<T, A, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11>(
        _ type: T.Type,
        with initializer: @escaping (A, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11) -> T,
        scope: DIScope = .graph
    ) {
        container.autoregister(
            T.self,
            initializer: initializer
        ).inObjectScope(
            scope.toObjectScope()
        )
    }
    
    private func _mockTypeName<T>(_: T) -> String {
        "\(String(describing: T.self))Mock"
    }
    
    public func invalidate(_ scope: DIScope) {
        container.resetObjectScope(scope.toObjectScope())
    }
}

fileprivate extension DIScope {
    func toObjectScope() -> ObjectScope {
        switch self {
            case .singleton: .container
            case .graph: .graph
        }
    }
}
